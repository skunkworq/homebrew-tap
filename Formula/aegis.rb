class Aegis < Formula
  desc "Securely sync project environment files with your Aegis vault"
  homepage "https://a3gis.me"
  url "https://github.com/skunkworq/homebrew-tap/releases/download/aegis-v0.1.5/aegis-cli-0.1.5.tar.gz"
  sha256 "695b79e06bde1570047166097db40077fa1d078ec29f9233bc7b1c61d68859f8"
  depends_on "node@22"

  def install
    libexec.install "cli.js", "core.js", "session.js", "package.json"
    chmod 0755, libexec/"cli.js"
    (bin/"aegis").write_env_script libexec/"cli.js", PATH: "#{formula_opt_bin("node@22")}:$PATH"
  end

  test do
    assert_match "aegis login", shell_output("#{bin}/aegis --help")
  end
end
