class Harness < Formula
  desc "Unified Harness CLI Control Plane for domain harnesses and spokes"
  homepage "https://github.com/Koality-Assured/harness-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_darwin_arm64.tar.gz"
      sha256 "6e1e7d2b51aa9e4f55c6197966944e77e8cadb6e55971dd018850266c95ba899"
    else
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_darwin_amd64.tar.gz"
      sha256 "93bfb7af59bb316a074a443a28f359780efa9deb1a5b82a60ff78fe3f460ccbe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_linux_arm64.tar.gz"
      sha256 "947ce2e97eee3cb0a62236b28676e4b96c812fa6186d0f6d7fd3ee73df8ddf85"
    else
      url "https://github.com/Koality-Assured/harness-cli/releases/download/v#{version}/harness_#{version}_linux_amd64.tar.gz"
      sha256 "37c8d31f604be42318325bb6e69d5739815a04385dc3919510b5bfe891559d24"
    end
  end

  def install
    bin.install "harness"
  end

  test do
    assert_match "Unified Harness CLI Control Plane", shell_output("#{bin}/harness --help")
  end
end
