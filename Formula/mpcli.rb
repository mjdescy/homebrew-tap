class Mpcli < Formula
  desc "mpcli: Micropub Publisher CLI | Publish text-only blog posts to Micropub endpoints via a command-line interface."
  homepage "https://github.com/mjdescy/mp"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mpcli-aarch64-apple-darwin.tar.xz"
      sha256 "233420ec546309ea9c8ca4319bebd456c7f5d2428dae391a3184ff61a2e0833b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mpcli-x86_64-apple-darwin.tar.xz"
      sha256 "2e9e3a525d6e37992865666ed7441ace92a8a4b56f4bad846fb340edd5ddf2a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mpcli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "335b858e0dc859aee0a318fcd7ae54bae086ca6a7cc5ecd495a7f70428c8c1a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mjdescy/mp/releases/download/v0.1.3/mpcli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3813378fe98b4788fd4c7f50df1d4697d79a053a432c10c2c7ffcd6e0206166a"
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
      bin.install "mp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mp"
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
