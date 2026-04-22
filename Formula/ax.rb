# frozen_string_literal: true

class Ax < Formula
  desc "Run multiple Claude Code agents in parallel, each isolated in its own git worktree, and monitor them all from a single terminal dashboard"
  homepage "https://github.com/jedipunkz/ax"
  version "0.1.16"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_amd64"
      sha256 "1d138e50282ded171ce45a2b3df7e39c7b76971a97aebf499d792c193feb5e0f"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_darwin_arm64"
      sha256 "009efd9f281b57d4733e3e3fff956ca64480b66f963ebdfee857c7636a843030"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_amd64"
      sha256 "4a8da41bc3f4ce3027aab40a57ca84d9e3e6d8501b1cada5103ffbd25fe66a36"
    end

    on_arm do
      url "https://github.com/jedipunkz/ax/releases/download/v#{version}/ax_v#{version}_linux_arm64"
      sha256 "af20f8d02b8407aae214e55a60db2d5f5a2fa686e8eeb21384d74762789b9d71"
    end
  end

  def install
    bin.install Dir["ax_v#{version}_*"].first => "ax"
  end

  test do
    assert_match "Manage multiple Claude Code agents", shell_output("#{bin}/ax --help 2>&1")
  end
end
