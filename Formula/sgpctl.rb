class Sgpctl < Formula
  desc "CLI tool for managing SGP services"
  homepage "https://github.com/scaleapi/sgpctl"
  url "https://github.com/scaleapi/sgpctl/releases/download/v0.0.4/sgpctl-darwin-arm64"
  version "0.0.4"
  sha256 "2c4359897dbce3785ab5fa4ef4e73cbf3049769f8059f071f1dddbd9aa954a3d"

  def install
    bin.install "sgpctl-darwin-arm64" => "sgpctl"
  end

  test do
    system "#{bin}/sgpctl", "--help"
  end
end
