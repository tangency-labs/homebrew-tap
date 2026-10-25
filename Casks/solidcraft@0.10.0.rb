cask "solidcraft@0.10.0" do
  version "0.10.0"
  sha256 "d5f0b8cfc1cc090a7fd0d143e77aac6574bfe9d4cd8962fae4af38d11d33a387"

  url "https://github.com/tangency-labs/solidcraft/releases/download/v#{version}/solidcraft-#{version}-macos-universal.dmg"
  name "SolidCraft"
  desc "Open-source parametric 3D CAD"
  homepage "https://solidcraft.io/"

  livecheck do
    skip "Versioned cask"
  end

  conflicts_with cask: "solidcraft"
  depends_on :macos

  app "SolidCraft.app"

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
