# typed: false
# frozen_string_literal: true

class Tourminal < Formula
  desc "Follow and create Microsoft CodeTour walkthroughs from the terminal"
  homepage "https://github.com/jillesme/tourminal"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.4/tourminal_0.1.4_darwin_arm64.tar.gz"
      sha256 "2ba5b3941314d1de583da61ae1a74504988aa2a742ca31b5622490ce017f7d4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.4/tourminal_0.1.4_darwin_amd64.tar.gz"
      sha256 "31aa3bc85dacc4aa4c5fc71deed44082d0c18d59474992e5d252a6248f477c56"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.4/tourminal_0.1.4_linux_arm64.tar.gz"
      sha256 "acf2d09717478f0cf6ee91d09be87b15cc248ce64588bbe533d7e0b6fb02ae75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.4/tourminal_0.1.4_linux_amd64.tar.gz"
      sha256 "33919bf048e2dd7b2fc4569573ef4adb569cddd34c8fccce877c80f7e972a84e"
    end
  end

  def install
    bin.install "tour"
    bin.install_symlink "tour" => "tourminal"
  end

  test do
    assert_match "tourminal #{version}", shell_output("#{bin}/tour version")
    assert_match "tourminal #{version}", shell_output("#{bin}/tourminal version")
    assert_match "name: create-codetour", shell_output("#{bin}/tour skill")

    (testpath/".tours").mkpath
    (testpath/".tours/smoke.tour").write <<~JSON
      {
        "title": "Homebrew smoke test",
        "steps": [{"description": "### Installed correctly"}]
      }
    JSON
    assert_match "valid: Homebrew smoke test (1 steps)", shell_output("#{bin}/tour validate #{testpath}")
    assert_match '"apiVersion": 1', shell_output("#{bin}/tour inspect --json #{testpath}")
  end
end
