class Mal4s < Formula
  desc "Malicious host finder based on gource"
  homepage "https://github.com/secure411dotorg/mal4s/"
  url "https://github.com/secure411dotorg/mal4s/releases/download/1.3-beta/mal4s-1.3-beta.tar.gz"
  sha256 "19ec3c47f361dec390283740e9f6f392a982523174883439340a514f2d85e9a3"
  revision 8

  head "https://github.com/secure411dotorg/mal4s.git"

  bottle do
    rebuild 1
    sha256 "8a3fd76a8aed3f2ed825ee58c6e84df4b8d23c1365dec0de679d6e5de7811477" => :sierra
    sha256 "95a5871af84d0ea208e478bebd7c29bad070ed916347cbdd853d911acaf69d1b" => :el_capitan
    sha256 "4ce392506649494538c6765f10bf11f3a8cca6b3acfc64222cff5a84efa8c19c" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "glm" => :build
  depends_on "boost"
  depends_on "glew"
  depends_on "pcre"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "freetype"
  depends_on :x11 => :optional

  def install
    # clang on Mt. Lion will try to build against libstdc++,
    # despite -std=gnu++0x
    ENV.libcxx

    args = ["--disable-dependency-tracking",
            "--prefix=#{prefix}",
	    "--with-boost=#{Formula["boost"].opt_prefix}"]
    args << "--without-x" if build.without? "x11"
    system "autoreconf", "-f", "-i"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/mal4s", "--help"
  end
end
