# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.18"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "336e94d2506dd641e8a749648ff7b6a7a4625dff92b781e083fe5c8f8cad6196"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "02c77f4be8be6c492da2fb1c11716e8ce879d15adcc659f1fb2737712873822c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "e56be620054d678e4518a141e4cf97edafeaf789caffb2e7552f5340b776ecf6"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "22c221d6ae3f0fffc2bcaebfdc1760f5025b38744852847c37195e9d9f351eaa"
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
