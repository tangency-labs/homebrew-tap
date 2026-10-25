#!/bin/bash
# Generate Casks/solidcraft@<version>.rb for an upstream release: scripts/gen-versioned.sh 0.21.0
set -euo pipefail
cd "$(dirname "$0")/.."

repo=tangency-labs/solidcraft
version=${1:?usage: gen-versioned.sh <version>}
out="Casks/solidcraft@$version.rb"
dmg="solidcraft-$version-macos-universal.dmg"

sha=$(gh release download "v$version" -R "$repo" -p SHA256SUMS.txt -O - | awk -v f="$dmg" '$2 == f {print $1}')
[ -n "$sha" ] || { echo "no checksum for $dmg" >&2; exit 1; }

# The CLI is bundled in the app from 0.13.0 on.
binary=
if [ "$(printf '%s\n0.13.0\n' "$version" | sort -V | head -n1)" = "0.13.0" ]; then
  binary='  binary "#{appdir}/SolidCraft.app/Contents/MacOS/solidcraft-cli"
'
fi

cat > "$out" <<RUBY
cask "solidcraft@$version" do
  version "$version"
  sha256 "$sha"

  url "https://github.com/$repo/releases/download/v#{version}/solidcraft-#{version}-macos-universal.dmg"
  name "SolidCraft"
  desc "Open-source parametric 3D CAD"
  homepage "https://solidcraft.io/"

  livecheck do
    skip "Versioned cask"
  end

  conflicts_with cask: "solidcraft"
  depends_on :macos

  app "SolidCraft.app"
${binary}
  # Releases are ad-hoc signed and not notarized, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/SolidCraft.app"],
        writable_paths: ["{{appdir}}/SolidCraft.app"]
  end

  zap trash: [
    "~/Library/Application Support/solidcraft",
    "~/Library/Caches/solidcraft",
  ]
end
RUBY
echo "wrote $out"
