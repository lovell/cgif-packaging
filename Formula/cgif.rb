class Cgif < Formula
  desc "A fast and lightweight GIF encoder"
  homepage "https://github.com/dloebl/cgif"
  url "https://github.com/dloebl/cgif/archive/04ee473.tar.gz"
  sha256 "dddf187a02c55059739f62665cb6b5b0f23a3ea36827fb251e60f323a3d26efb"
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
