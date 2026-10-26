class Claudebox < Formula
  desc "Claude Code container runtime — scoped per project, runs in Docker or Apple Container"
  homepage "https://github.com/bpeterme/claudebox"
  url "https://github.com/bpeterme/claudebox/archive/refs/tags/2026.10.26.0.tar.gz"
  sha256 "d421e3f93952a503a66030113e952fe0b2f6d3092dcda4690544fff7973acb89"
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
