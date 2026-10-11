class Cloudguard < Formula
  desc "CloudGuardian CLI - Cloud cost protection for GCP & AWS"
  homepage "https://cloudguard.dev"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.1/cloudguard_darwin_arm64"
      sha256 "b552eeb48393f32fa58e0d7b7bd52a4cbd4859aa44bbdef38e90c3fb174ef749"
    else
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.1/cloudguard_darwin_amd64"
      sha256 "bfc2fd2cef5827d1ac21237d7c81cac90abd25c11f4c8d91d2a92d2dacea0102"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.1/cloudguard_linux_arm64"
      sha256 "9309bd8a836d82d1cc4e1f26d52dfd2c88966439687071bf7cecd0e99a40a609"
    else
      url "https://github.com/skunkworq/homebrew-tap/releases/download/cloudguard-v0.1.1/cloudguard_linux_amd64"
      sha256 "3fca8eb41420578f119950ee0c7383a81b35e5b14ea512172106c31bbd205d42"
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
