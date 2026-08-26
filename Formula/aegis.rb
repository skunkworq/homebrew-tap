class Aegis < Formula
  desc "Securely sync project environment files with your Aegis vault"
  homepage "https://a3gis.me"
  url "https://github.com/skunkworq/homebrew-tap/releases/download/aegis-v0.1.7/aegis-cli-0.1.7.tar.gz"
  sha256 "6cc56c996b4dcb4b511a4a70656df134eeaa81056d6ceabb48fb149c52b30211"
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
