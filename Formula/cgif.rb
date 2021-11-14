class Cgif < Formula
  desc "A fast and lightweight GIF encoder"
  homepage "https://github.com/dloebl/cgif"
  url "https://github.com/dloebl/cgif/archive/V0.0.2.tar.gz"
  version "0.0.2"
  sha256 "679e8012b9fe387086e6b3bcc42373dbc66fb26f8d070d7a1d23f39d42842258"
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
