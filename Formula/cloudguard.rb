class Cloudguard < Formula
  desc "CloudGuardian CLI - Cloud cost protection for GCP & AWS"
  homepage "https://cloudguard.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/cloud-guardian/releases/download/v0.1.0/cloudguard_darwin_arm64"
      sha256 "PLACEHOLDER_SHA256_ARM64"
    else
      url "https://github.com/skunkworq/cloud-guardian/releases/download/v0.1.0/cloudguard_darwin_amd64"
      sha256 "PLACEHOLDER_SHA256_AMD64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/cloud-guardian/releases/download/v0.1.0/cloudguard_linux_arm64"
      sha256 "PLACEHOLDER_SHA256_LINUX_ARM64"
    else
      url "https://github.com/skunkworq/cloud-guardian/releases/download/v0.1.0/cloudguard_linux_amd64"
      sha256 "PLACEHOLDER_SHA256_LINUX_AMD64"
    end
  end

  def install
    bin.install "cloudguard_darwin_arm64" => "cloudguard" if OS.mac? && Hardware::CPU.arm?
    bin.install "cloudguard_darwin_amd64" => "cloudguard" if OS.mac? && Hardware::CPU.intel?
    bin.install "cloudguard_linux_arm64" => "cloudguard" if OS.linux? && Hardware::CPU.arm?
    bin.install "cloudguard_linux_amd64" => "cloudguard" if OS.linux? && Hardware::CPU.intel?
  end

  test do
    system "#{bin}/cloudguard", "version"
  end
end
