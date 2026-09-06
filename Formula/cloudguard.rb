class Cloudguard < Formula
  desc "CloudGuardian CLI - Cloud cost protection for GCP & AWS"
  homepage "https://cloudguard.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.0/cloudguard_darwin_arm64"
      sha256 "fadc5b878525c457feb7f67ba01764a87cd918a07e8361c45110686989e43bc7"
    else
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.0/cloudguard_darwin_amd64"
      sha256 "5e81c6ca62326826733fa6ee0ec8471d06a1a8cfe043251df42860deb5b5e0b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.0/cloudguard_linux_arm64"
      sha256 "bcffd418eb909ac2cb0448598e6e23683748ac5621f3d28f6d5b199d1df7e0be"
    else
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.0/cloudguard_linux_amd64"
      sha256 "aac02c5169929df09b98e6acb89443ae85370bf03a6cd696b07f44776600121d"
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
