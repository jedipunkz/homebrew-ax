# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.22"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "4f92cbba96a0b92a129f80ff4c9f8705bd1ec4baa4218116bcacaf85b1e41f8f"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "ffc6a166f48277445dc454c49f6164fb90c3e0449cbe19c057714d518c1d5d3e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "434cdee6517d47a1ca16089dab2ff5601c8b484e598b5176712506fe7f893817"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "1a92e4e7f46b14c3a25cd900e4f38de42d5d8553413a05d194ecd51abcfaf603"
    end
  end

  def install
    bin.install Dir["ax_v#{version}_*"].first => "ax"
  end

  def post_install
    pid_file = Pathname.new(Dir.home) / ".ax" / "daemon.pid"
    if pid_file.exist?
      pid = pid_file.read.strip.to_i
      if pid.positive?
        begin
          Process.kill("TERM", pid)
          ohai "Stopped ax daemon (PID: #{pid})"
        rescue Errno::ESRCH
          # Process already exited
        end
      end
      pid_file.delete
    end
  end

  test do
    assert_match "Manage multiple Claude Code agents", shell_output("#{bin}/ax --help 2>&1")
  end
end
