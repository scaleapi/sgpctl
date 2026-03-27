class Sgpctl < Formula
  desc "CLI tool for managing SGP services"
  homepage "https://github.com/scaleapi/sgpctl"
  url "https://github.com/scaleapi/sgpctl/releases/download/v0.0.3/sgpctl-darwin-arm64"
  version "0.0.3"
  sha256 "22cf51ede6813b793861e62dd798203aafb762ceb4dc4f41a532810589f10899"

  def install
    bin.install "sgpctl-darwin-arm64" => "sgpctl"
  end

  test do
    system "#{bin}/sgpctl", "--help"
  end
end
