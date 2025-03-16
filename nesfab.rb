# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Nesfab < Formula
  desc "Programming language that targets the Nintendo Entertainment System"
  homepage "https://pubby.games/nesfab.html"
  url "https://github.com/pubby/nesfab/archive/refs/tags/v1.6_mac.tar.gz"
  sha256 "9eeeefbefeecf84837a3b7af700fad9882b28fc7b26fd4a02ec6788cd3c64836"
  license "GPL-3.0-only"

  on_linux do
    depends_on "gcc" => :build
  end
  depends_on "make" => :build
  depends_on "boost"

  def install
    if OS.mac?
      system "make", "CXX=clang++", "release" if Hardware::CPU.intel?
      system "make", "CXX=clang++", "ARCH=", "release" if Hardware::CPU.arm?
    else
      system "make", "release" if Hardware::CPU.intel?
      system "make", "ARCH=", "release" if Hardware::CPU.arm?
    end
    bin.install "nesfab"
  end

  test do
    system bin/"nesfab", "--version"
  end
end
