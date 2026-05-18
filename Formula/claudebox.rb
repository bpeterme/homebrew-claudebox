class Claudebox < Formula
  desc "Claude Code container runtime — scoped per project, runs in Docker or Apple Container"
  homepage "https://github.com/bpeterme/claudebox"
  url "https://github.com/bpeterme/claudebox/archive/refs/tags/2026.05.18.1.tar.gz"
  sha256 "d107443e6d5ac02072dd3abdea031a7133083ff6ba8c94425bf5908e1f2a08df"
  license "MIT"

  depends_on :macos
  depends_on "bash"
  depends_on "jq"

  def install
    bin.install "cbox.sh" => "cbox"
    (share/"claudebox").install "dockerfile"
  end

  def caveats
    <<~EOS
      Build the container image before first use:
        cbox rebuild
    EOS
  end

  test do
    output = shell_output("#{bin}/cbox version")
    assert_match version.to_s, output
  end
end
