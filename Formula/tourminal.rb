# typed: false
# frozen_string_literal: true

class Tourminal < Formula
  desc "Follow and create Microsoft CodeTour walkthroughs from the terminal"
  homepage "https://github.com/jillesme/tourminal"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.2/tourminal_0.1.2_darwin_arm64.tar.gz"
      sha256 "9ff4ad39ffe5afdf84cec1834ed32f2ec0196f0047b3ca18596180ba7c16650f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.2/tourminal_0.1.2_darwin_amd64.tar.gz"
      sha256 "0d448fd04513d23ba8f5fda3f5a6b9b7d9b6ede909dde9bc826979eca0c62ad4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.2/tourminal_0.1.2_linux_arm64.tar.gz"
      sha256 "a966266c0ad9f3f6241001256f509b4579f56f4e9511d243ed8e79d5bbadd2e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jillesme/tourminal/releases/download/v0.1.2/tourminal_0.1.2_linux_amd64.tar.gz"
      sha256 "0c6592a2e8198df8cee1fcf0328b3c485cde5c6bcb51e88155b69b8000cab93d"
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
