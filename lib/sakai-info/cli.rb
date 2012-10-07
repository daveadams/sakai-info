# sakai-info/cli.rb
#  - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-10-07 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'sakai-info/cli/help'
require 'sakai-info/cli/lookup'
require 'sakai-info/cli/query'
require 'sakai-info/cli/special'
require 'sakai-info/cli/shell'

# it's faster to run single-threaded
Sequel.single_threaded = true

