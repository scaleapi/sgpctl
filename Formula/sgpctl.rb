class Sgpctl < Formula
  desc "CLI tool for managing SGP services"
  homepage "https://github.com/scaleapi/sgpctl"
  url "https://api.github.com/repos/scaleapi/sgpctl/releases/assets/0",
      headers: [
        "Accept: application/octet-stream",
        "X-GitHub-Api-Version: 2022-11-28",
        "Authorization: bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}",
      ]
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  def install
    bin.install "sgpctl-darwin-arm64" => "sgpctl"
  end

  test do
    system "#{bin}/sgpctl", "--help"
  end
end
