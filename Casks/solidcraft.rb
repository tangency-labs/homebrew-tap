cask "solidcraft" do
  version "0.30.0"
  sha256 "b05751f79e503f9c52914ca87f295e2a84760b1b22a695bc94714ddd543ced97"

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
