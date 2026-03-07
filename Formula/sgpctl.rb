class Sgpctl < Formula
  desc "CLI tool for managing SGP services"
  homepage "https://github.com/scaleapi/sgpctl"
  url "https://github.com/scaleapi/sgpctl/releases/download/v0.0.1/sgpctl-darwin-arm64"
  version "0.0.1"
  sha256 "528ef19cfe50e69791a5f7d09bd6cc1466ea3b0d29801acdcde05a1d55bb2ea9"

  def install
    bin.install "sgpctl-darwin-arm64" => "sgpctl"
  end

  test do
    system "#{bin}/sgpctl", "--help"
  end
end
