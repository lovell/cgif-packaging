class Cgif < Formula
  desc "A fast and lightweight GIF encoder"
  homepage "https://github.com/dloebl/cgif"
  url "https://github.com/dloebl/cgif/archive/V0.0.1.tar.gz"
  version "0.0.1"
  sha256 "4e61d6bd387182f5e0090de49197084a8676e9f5aeac0d61562f52c553d71598"
  license "MIT"

  bottle :unneeded

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
    ]

    mkdir "build" do
      system "meson", *args, ".."
      system "ninja", "install"
    end
  end
end
