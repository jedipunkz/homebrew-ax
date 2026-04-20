# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.15"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "d49dceed6d5cad5fefe15402ddcf9f60e5fd72ac1cb4b7a04ec320b248e2464a"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "3e2b6077d4b00918a069b636488ce9bffd4075daed0fe062252c4f9e5703ad4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "d0179f3abf3d20f1f46a0d9a7788dc865bd7b5e2430bbe4b87b5049418e3e73d"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "444e120d06b828a3b48b9bbad71815598bd5487b9852ba532a1834d25eabd769"
    end
  end

  def install
    bin.install Dir["ax_v#{version}_*"].first => "ax"
  end

  test do
    assert_match "Manage multiple Claude Code agents", shell_output("#{bin}/ax --help 2>&1")
  end
end
