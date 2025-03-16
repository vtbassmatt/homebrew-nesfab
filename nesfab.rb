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
    # update this when bumping package version
    git_sha = "3aa29964"

    # work around a race condition with lexer_gen
    rm %w( src/asm_lex_tables.cpp src/ext_lex_tables.cpp src/lex_tables.cpp src/macro_lex_tables.cpp )
    rm %w( src/asm_lex_tables.hpp src/ext_lex_tables.hpp src/lex_tables.hpp src/macro_lex_tables.hpp )

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
