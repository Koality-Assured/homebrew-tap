class Harness < Formula
  desc "Unified Harness CLI Control Plane for domain harnesses and spokes"
  homepage "https://github.com/Koality-Assured/harness-cli"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_darwin_arm64.tar.gz"
      sha256 "7c2aaf4306bf97288dc413d762a118664368caf42dc6b7ce84921721253b3777"
    else
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_darwin_amd64.tar.gz"
      sha256 "53fb189b5bb7db7e379fb5c8b692437f40ee6c31c37063da1893a5a08dac46ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_linux_arm64.tar.gz"
      sha256 "3519eae8ad8cead3d3b78d40877993166f06da579fe21cc6c44319ff3f040577"
    else
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_linux_amd64.tar.gz"
      sha256 "9e0349c4927448e799c26bee66343a89629c422a63010b9633bec4f76bd2d2fb"
    end
  end

  def install
    bin.install "harness"
  end

  test do
    assert_match "Unified Harness CLI Control Plane", shell_output("#{bin}/harness --help")
  end
end
