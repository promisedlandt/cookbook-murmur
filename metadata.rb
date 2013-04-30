name             "murmur"
maintainer       "Nils Landt"
maintainer_email "cookbooks@promisedlandt.de"
license          "MIT"
description      "Installs Murmur, the official Mumble server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

%w(apt runit).each { |dep| depends dep }

%w(ubuntu debian).each { |os| supports os }
