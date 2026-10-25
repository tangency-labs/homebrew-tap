cask "solidcraft@0.11.1" do
  version "0.11.1"
  sha256 "98613e9975f7076995434122fafad9cce98d2a5b7e1a057f9232f6c1c4313920"

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
