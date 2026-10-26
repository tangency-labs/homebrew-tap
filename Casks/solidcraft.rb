cask "solidcraft" do
  version "0.23.1"
  sha256 "0d93b1dda4314c3a5ce9c95e8c10da7b4e2c1b2cad7e5dd3ff40ee810f43d1c6"

  url "https://github.com/tangency-labs/solidcraft/releases/download/v#{version}/solidcraft-#{version}-macos-universal.dmg"
  name "SolidCraft"
  desc "Open-source parametric 3D CAD"
  homepage "https://solidcraft.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "SolidCraft.app"
  binary "#{appdir}/SolidCraft.app/Contents/MacOS/solidcraft-cli"

  zap trash: [
    "~/Library/Application Support/solidcraft",
    "~/Library/Caches/solidcraft",
  ]
end
