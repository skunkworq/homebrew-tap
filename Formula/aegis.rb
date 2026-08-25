class Aegis < Formula
  desc "Securely sync project environment files with your Aegis vault"
  homepage "https://a3gis.me"
  url "https://github.com/skunkworq/homebrew-tap/releases/download/aegis-v0.1.2/aegis-cli-0.1.2.tar.gz"
  sha256 "830343910367069a1357773f84ccdd3189d40791890ba3bc90bd342478e584f3"
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
