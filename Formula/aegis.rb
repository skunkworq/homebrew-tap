class Aegis < Formula
  desc "Securely sync project environment files with your Aegis vault"
  homepage "https://a3gis.me"
  url "https://github.com/skunkworq/homebrew-tap/releases/download/aegis-v0.1.3/aegis-cli-0.1.3.tar.gz"
  sha256 "f1571efde51947f9f093d45365abe881f60b57d929257f56061f1ab7bf4c9387"
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
