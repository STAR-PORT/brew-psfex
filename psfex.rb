class Psfex < Formula
  desc "PSFEx  (“PSF Extractor”) extracts models of the Point Spread Function (PSF) from FITS images processed with SExtractor, and measures the quality of images. The generated PSF models can be used for model-fitting photometry or morphological analyses."
  homepage "https://www.astromatic.net/software/psfex/"
  url "https://github.com/astromatic/psfex/archive/refs/tags/3.24.2.tar.gz"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "openblas"
  depends_on "plplot"

  def install
    openblas = Formula["openblas"]
    system "./autogen.sh"
    system "./configure", *std_configure_args,
           "--disable-silent-rules",
           "--enable-openblas",
           "--with-openblas-libdir=#{openblas.lib}",
           "--with-openblas-incdir=#{openblas.include}"
    system "make", "install"
    # Remove references to Homebrew shims
    rm Dir["tests/Makefile*"]
  end

end
