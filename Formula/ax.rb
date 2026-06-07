# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "0e388dbf159920bf3dcc20d1eb59f2a082ecfdfef4fe59dab1e22e3da14fd695"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "d9bdfa163bf5f979af0908bed051a4f2ea980b504f9743c7328a52ba041a1c8e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "3db83a38dd4793bf247119764dfd2dbee0b6bfac43d11cc9746487022fa94a2a"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "029a3df4d0ef6c2b45a2dffab0fe1b02ae6f33b528e82a6fb9c868b9211e3e31"
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
