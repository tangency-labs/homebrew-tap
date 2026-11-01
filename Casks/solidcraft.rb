cask "solidcraft" do
  version "0.29.0"
  sha256 "98f19aecbd59eb6ce8bcd83e1af94b127118a121538ee68445f42ad665b53c23"

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
