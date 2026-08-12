# typed: false
# frozen_string_literal: true

class Tourminal < Formula
  desc "Follow and create Microsoft CodeTour walkthroughs from the terminal"
  homepage "https://github.com/jillesme/tourminal"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.1/tourminal_0.1.1_darwin_arm64.tar.gz"
      sha256 "b35a87e40a7717938538082966f4d8ebac4589e1170974bb8db85d3882c1f527"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.1/tourminal_0.1.1_darwin_amd64.tar.gz"
      sha256 "20ce8dd4fbdf60ddd6618543c7326608195fd3b87670770283d72459e73f6537"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.1/tourminal_0.1.1_linux_arm64.tar.gz"
      sha256 "b99c81f42f2b6063140c2f4bdcaec8cede6a9f1bfdef8924a3209e3882f85b5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.1/tourminal_0.1.1_linux_amd64.tar.gz"
      sha256 "6638ecba456cdb741894a6b7afe78985fd9eb63c0b35204d0e33d87f7f975800"
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
