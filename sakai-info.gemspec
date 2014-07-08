# sakai-info.gemspec
#   Gem definition file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2014-07-08 daveadams@gmail.com
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

  spec.add_dependency('sequel', '~> 4.12')

  spec.add_development_dependency('sqlite3', '~> 1.3', '>= 1.3.9')
  spec.add_development_dependency('marky_markov', '~> 0.3', '>= 0.3.5')
end
