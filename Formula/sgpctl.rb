class Sgpctl < Formula
  desc "CLI tool for managing SGP services"
  homepage "https://github.com/scaleapi/sgpctl"
  url "https://github.com/scaleapi/sgpctl/releases/download/v0.0.2/sgpctl-darwin-arm64"
  version "0.0.2"
  sha256 "19338eee9645de2384e9142cc724b2483d16c41b87b70942a7191b849f9034f7"

  def install
    bin.install "sgpctl-darwin-arm64" => "sgpctl"
  end

  test do
    system "#{bin}/sgpctl", "--help"
  end
end
