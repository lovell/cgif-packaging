class Cgif < Formula
  desc "A fast and lightweight GIF encoder"
  homepage "https://github.com/dloebl/cgif"
  url "https://github.com/dloebl/cgif/archive/80bd8fb.tar.gz"
  sha256 "9437c11ba317a97a723027d446957e3d3825e96d799fa65774984f07b86965fd"
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
