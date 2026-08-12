# typed: false
# frozen_string_literal: true

class Tourminal < Formula
  desc "Follow and create Microsoft CodeTour walkthroughs from the terminal"
  homepage "https://github.com/jillesme/tourminal"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.0/tourminal_0.1.0_darwin_arm64.tar.gz"
      sha256 "d1a635f7e14f1326f9289d6c5612893a81b780ce41e02d95defa72ea352d0373"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.0/tourminal_0.1.0_darwin_amd64.tar.gz"
      sha256 "47c1cbec85f784343247e76cc52515c2162f68f943400f7c8ba2ef6ebda86ea9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.0/tourminal_0.1.0_linux_arm64.tar.gz"
      sha256 "78c96fdddc8d5481c4ae10cf2cacd86c944836f2708c976ccaf83b921180e02c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.0/tourminal_0.1.0_linux_amd64.tar.gz"
      sha256 "c095bea3e11ce37b95df144d285d029a7f3a378b57a16da606ef36ff051d72e8"
    end
  end

  def install
    bin.install "tourminal"
  end

  test do
    assert_match "tourminal #{version}", shell_output("#{bin}/tourminal version")
    assert_match "name: create-codetour", shell_output("#{bin}/tourminal skill")

    (testpath/".tours").mkpath
    (testpath/".tours/smoke.tour").write <<~JSON
      {
        "title": "Homebrew smoke test",
        "steps": [{"description": "### Installed correctly"}]
      }
    JSON
    assert_match "valid: Homebrew smoke test (1 steps)", shell_output("#{bin}/tourminal validate #{testpath}")
  end
end
