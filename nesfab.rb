# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Nesfab < Formula
  desc "Programming language that targets the Nintendo Entertainment System"
  homepage "https://pubby.games/nesfab.html"
  url "https://github.com/pubby/nesfab/archive/refs/tags/v1.6.tar.gz"
  sha256 "c98e1de362de0503b4a3ad313ccfbf02da0e1fba8056594e942f55b361e88b09"
  license "GPL-3.0-only"

  depends_on "make" => :build
  depends_on "boost" => :build

  on_linux do
    depends_on "gcc"
  end  

  def install
    system "make", "release" if Hardware::CPU.intel?
    system "make", "ARCH=", "release" if Hardware::CPU.arm?
    bin.install "nesfab"
  end

  test do
    system bin/"nesfab", "--version"
  end
end
