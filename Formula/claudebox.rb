class Claudebox < Formula
  desc "Claude Code container runtime — scoped per project, runs in Docker or Apple Container"
  homepage "https://github.com/bpeterme/claudebox"
  url "https://github.com/bpeterme/claudebox/archive/refs/tags/2026.05.19.1.tar.gz"
  sha256 "91631fe68613d3454891ae749dd6ce8ad19aab780e431f6d687443fee2a3d05c"
  license "MIT"

  head "https://github.com/bpeterme/claudebox.git", branch: "dev"

  depends_on :macos

  def install
    version_str = build.head? ? "HEAD-#{`git describe --tags --always`.chomp}" : version.to_s
    inreplace "cbox.sh", '_CBOX_VERSION="dev"', "_CBOX_VERSION=\"#{version_str}\""
    bin.install "cbox.sh" => "cbox"
    (share/"claudebox").install "dockerfile"
  end

  def caveats
    <<~EOS
      claudebox requires Apple Container (macOS) or Docker to run containers.

      Build the container image before first use:
        cbox rebuild
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbox version")
  end
end
