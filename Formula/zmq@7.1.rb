# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT71 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "c79e828ad3338211581f8d0e7c173ed8e064d504aafcfde32e6066968850a58a"
    sha256 cellar: :any,                 arm64_ventura:  "ca3d8fb4b3db68b2201214eb9f3b495beb6b521c2e34cf6d0dc11008c83a3e90"
    sha256 cellar: :any,                 arm64_monterey: "82dea0db0f5ce55ccbfe897beaa17d06868781b337936ce6e48bcf35fd50bce6"
    sha256 cellar: :any,                 ventura:        "df9269e4aeccf3a780c6cac8bc055180d6d6fa238e14bf43cc806a3605404e1b"
    sha256 cellar: :any,                 monterey:       "c1543200a1c0700645603f3be0f4c43bff83b9fe41e8a13a0a62af831b0cf737"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15f9039038313f29101163bc395e1b24d770476aa514aa18230e0cf2ebc161ed"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libsodium"].opt_prefix}/lib/pkgconfig"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
