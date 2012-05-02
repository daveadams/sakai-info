# sakai-info.gemspec
#   Gem definition file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-05-02 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain. See LICENSE for more information.
#

require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'sakai-info', 'version'))

Gem::Specification.new do |spec|
  spec.name = "sakai-info"
  spec.version = SakaiInfo::VERSION
  spec.summary = "Tools and library for exploring a Sakai database"
  spec.description = "A command line tool and a suite of libraries for representing the objects and relationships defined by a Sakai CLE database."
  spec.author = "David Adams"
  spec.email = "daveadams@gmail.com"
  spec.homepage = "https://github.com/daveadams/sakai-info"
  spec.license = "Public Domain"

  spec.files = Dir["lib/**/*.rb"] + ["bin/sin"] + %w(README.md LICENSE CHANGELOG.md ROADMAP.md)
  spec.bindir = "bin"
  spec.executables = ["sin"]

  spec.add_dependency('sequel')

  spec.add_development_dependency('sqlite3')
end

