#!/bin/bash
# Update Casks/solidcraft.rb to the latest stable upstream release.
set -euo pipefail
cd "$(dirname "$0")/.."

repo=tangency-labs/solidcraft
cask=Casks/solidcraft.rb

tag=$(gh release view -R "$repo" --json tagName --jq .tagName)   # latest = newest non-prerelease
version=${tag#v}
current=$(sed -n 's/^  version "\(.*\)"/\1/p' "$cask")
if [ "$version" = "$current" ]; then
  echo "solidcraft is up to date ($current)"
  exit 0
fi

scripts/gen-versioned.sh "$current"   # keep the superseded release installable as solidcraft@$current

dmg="solidcraft-$version-macos-universal.dmg"
sha=$(gh release download "$tag" -R "$repo" -p SHA256SUMS.txt -O - | awk -v f="$dmg" '$2 == f {print $1}')
[ -n "$sha" ] || { echo "no checksum for $dmg" >&2; exit 1; }

sed -i.bak -e "s/^  version \".*\"/  version \"$version\"/" -e "s/^  sha256 \".*\"/  sha256 \"$sha\"/" "$cask"
rm -f "$cask.bak"
echo "solidcraft $current -> $version"
