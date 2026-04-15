# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.12"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "98354a7329d261b4ee97714b56600c3b42f39a842efb84b1eba830ddb31891f1"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "fd4e9c58ac6488ea7e947a8254bd81ee7770bbb967956e7dc2aafda20325005c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "bb66c7889de8e1a9e91fd2bc64337b0956bac22d427f26c3dda1a6373d10ee56"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "d7c2f1f29d84e05e35ea7d1ca6567bc0c146cedcd316ef90d68115d54940b29e"
    end
  end

  def install
    bin.install Dir["ax_v#{version}_*"].first => "ax"
  end

  test do
    assert_match "Manage multiple Claude Code agents", shell_output("#{bin}/ax --help 2>&1")
  end
end
