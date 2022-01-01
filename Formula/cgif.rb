class Cgif < Formula
  desc "A fast and lightweight GIF encoder"
  homepage "https://github.com/dloebl/cgif"
  url "https://github.com/dloebl/cgif/archive/V0.1.0.tar.gz"
  version "0.1.0"
  sha256 "fc7a79d79c7325cd3ef2093fece064e688bbc0bc309c1a5feae3e62446bbd088"
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
