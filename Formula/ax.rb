# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.19"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "b99c32817bb42369442876830e84c8a8dae5cbcc178d3d0803101e76d1ce47db"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "4fe69d88500dd8f0b059f3ebeee636e0363770bdc8cd581727627932455b4c01"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "59ea7117eee6d94f0306248665e3e05a2a2dcf0c1b55cf15a0347a5ac566cc76"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "f57f7438a3210be6a8067e39516577f420f91a798f79fabe7720a716adb6cc61"
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
