# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhp81Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/132a11fd26675db9eb9f0e9a3e2887c161875206.tar.gz"
  version "3.5.0"
  sha256 "f94982135603811cd15da19b80959c7456ada9a916af5bd7162b5bad80fa34c4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 6
    sha256 "2903bcd92d34a610d0edfb2c52aab194491b317a1a06dd49ec8effa54a721355" => :catalina
  end

  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file
  end
end
