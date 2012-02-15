# sakai-info.gemspec
#   Gem definition file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

Gem::Specification.new do |spec|
  spec.name = "sakai-info"
  spec.version = "0.0.0"
  spec.date = "2012-02-15"
  spec.summary = "Tools and library for exploring a Sakai database"
  spec.description = "A command line tool and a suite of libraries for representing the objects and relationships defined by a Sakai CLE database."
  spec.author = "David Adams"
  spec.email = "daveadams@gmail.com"
  spec.homepage = "https://github.com/daveadams/sakai-info"

  spec.files = ["lib/sakai-info.rb", "bin/sakai-info"]
  spec.executables << "sakai-info"
end

