# typed: false
# frozen_string_literal: true

class Tourminal < Formula
  desc "Follow and create Microsoft CodeTour walkthroughs from the terminal"
  homepage "https://github.com/jillesme/tourminal"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.3/tourminal_0.1.3_darwin_arm64.tar.gz"
      sha256 "e92ffeff3263904bf4012be9cf72cc1430523e1eaf234bd337faeb5f50eff880"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.3/tourminal_0.1.3_darwin_amd64.tar.gz"
      sha256 "9ce53c2dcbc187ba27322e3cfd67ce386abe2fc6dbb2e05b17cfd37233c5f1f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.3/tourminal_0.1.3_linux_arm64.tar.gz"
      sha256 "e80ff60a6af67b02b10bb29c357a3e626fdd40a6511d84550653d43f24d54d5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.3/tourminal_0.1.3_linux_amd64.tar.gz"
      sha256 "f3c4467e1089d7985672bbeae4551631e2b3c91077f3fd1d712f41d33765d657"
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
  end
end
