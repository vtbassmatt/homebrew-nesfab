class Nesfab < Formula
  desc "Programming language that targets the Nintendo Entertainment System"
  homepage "https://pubby.games/nesfab.html"
  url "https://github.com/pubby/nesfab/archive/da18a43dc7b941cc4c56c949303aa37633fdc1b0.tar.gz"
  version "1.6"
  sha256 "bfd8c497df0d87138fda9e5de61d1ab5a36fb1951eeaed413b6619032b711745"
  license "GPL-3.0-only"

  depends_on "make" => :build
  depends_on "boost"
  on_linux do
    depends_on "gcc" => :build
  end

  def install
    # update this when bumping package version
    git_sha = "da18a43d"

    if OS.mac?
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "CXX=clang++", "release" if Hardware::CPU.intel?
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "CXX=clang++", "ARCH=", "release" if Hardware::CPU.arm?
      bin.install "nesfab" => "nesfab-release"

      system "make", "clean"
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "CXX=clang++", "debug" if Hardware::CPU.intel?
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "CXX=clang++", "ARCH=", "debug" if Hardware::CPU.arm?
      bin.install "nesfab"
    else
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "release" if Hardware::CPU.intel?
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "ARCH=", "release" if Hardware::CPU.arm?
      bin.install "nesfab" => "nesfab-release"

      system "make", "clean"
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "debug" if Hardware::CPU.intel?
      system "make", "GIT_COMMIT=#{git_sha}-homebrew", "ARCH=", "debug" if Hardware::CPU.arm?
      bin.install "nesfab" => "nesfab"
    end
  end

  test do
    system bin/"nesfab", "--version"
  end
end
