class Mptui < Formula
  desc "mptui: Micropub Publisher Terminal User Interface | Publish text-only blog posts to Micropub endpoints."
  homepage "https://github.com/mjdescy/mptui"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mptui-aarch64-apple-darwin.tar.xz"
      sha256 "31b0b280cb1b412d6ad1806655d6f439936b25b1873ed0c20698d666f193e3d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mptui-x86_64-apple-darwin.tar.xz"
      sha256 "e3cff152fe2c79e551ebcbb380145026b5e51e0c45b98cf40b56597ab96b0f4c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mptui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0760aee3a8b566f976a4957e75075ea8fd903d215051461d3351ae57058c2e8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mptui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a2223587aa117809b8fda7fda0f487559c1e8e15f022c624e4dd472fdd3f088e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mptui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mptui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mptui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mptui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
