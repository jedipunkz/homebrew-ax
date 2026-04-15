# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.14"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "d0aea0a172483fd4695d5e27ea8a5d4e9927fc4bf451ddf72a6c2ada2a7f9e98"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "3b40df8faa9e2838d43ae188e9322ff2ae994c038a48eb927f5c620eb51100b6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "377f2e24cba77e696a80981b6c81f56ea80f048dc24fbb65805e31e11c0ca70a"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "20c53668392d468d1d1a42ec3e34129d8eb8b16ca3e91d6f970db3486dde1c59"
    end
  end

  def install
    bin.install Dir["ax_v#{version}_*"].first => "ax"
  end

  test do
    assert_match "Manage multiple Claude Code agents", shell_output("#{bin}/ax --help 2>&1")
  end
end
