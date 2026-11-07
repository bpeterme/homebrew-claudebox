class Claudebox < Formula
  desc "Claude Code container runtime — scoped per project, runs in Docker or Apple Container"
  homepage "https://github.com/bpeterme/claudebox"
  url "https://github.com/bpeterme/claudebox/archive/refs/tags/2026.11.07.3.tar.gz"
  sha256 "b916edb6ff249d63e5c35be3c0649bc32077d7a26dc95483dc68eaa074a1988c"
  license "MIT"

  head "https://github.com/bpeterme/claudebox.git", branch: "dev"

  depends_on :macos

  def install
    version_str = build.head? ? "HEAD-#{`git rev-parse --short HEAD`.chomp}" : version.to_s
    inreplace "cbox.sh", '_CBOX_VERSION="dev"', "_CBOX_VERSION=\"#{version_str}\""
    bin.install "cbox.sh" => "cbox"
    (share/"claudebox").install "dockerfile"
    (share/"claudebox").install "cbox.env.example"
    zsh_completion.install "completions/_cbox"
  end

  def caveats
    <<~EOS
      claudebox requires Apple Container (macOS) or Docker to run containers.

      Build the container image before first use:
        cbox rebuild

      To configure claudebox, copy the example config:
        mkdir -p ~/.config/claudebox
        cp #{share}/claudebox/cbox.env.example ~/.config/claudebox/cbox.env
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbox version")
  end
end
