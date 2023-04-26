# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT73 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-2.0.7.tgz"
  sha256 "86545e1e09b79e3693dd93f2a5a8f15ea161b5a1928f315c7a27107744ee8772"
  head "https://github.com/laruence/php-lua.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "08bfd4e6caff74e1eced5f6123779bf686cb48ab0147aee44d656dd574acac37"
    sha256 cellar: :any,                 arm64_big_sur:  "5d3ce9f7086889519b3bc9eb77916298ad0e761c411373c3b55ce99cf8acfdc8"
    sha256 cellar: :any,                 ventura:        "be1f64564c4c2a99794354d1d0a25c7f2685a0d67d1e6d67c4a5e2b9689cb432"
    sha256 cellar: :any,                 monterey:       "44d515c820dddf63d82b4d240faf51d6153044b32a030ce650c8b222945a4528"
    sha256 cellar: :any,                 big_sur:        "07da518a32ff1fb3530306612f65e791c617dcb808647aa5132c197002cfbe7d"
    sha256 cellar: :any,                 catalina:       "285803444e907676e9f88e8b7648221d71ec69a50717d2530abda160477fb164"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4ee76b55f288ca6c3e2f4017f8a19d97072927b1d7f68e8d6a82a801bdb8822"
  end

  depends_on "lua"

  def install
    args = %W[
      --with-lua=#{Formula["lua"].opt_prefix}
    ]
    Dir.chdir "lua-#{version}"
    inreplace "config.m4", "include/lua.h", "include/lua/lua.h"
    inreplace "php_lua.h", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "lua/lua_closure.h", "lua_closure.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
