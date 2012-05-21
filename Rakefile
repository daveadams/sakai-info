# Rakefile
#   rake definitions
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

BASEDIR = File.expand_path(File.dirname(__FILE__))
LIBDIR = File.join(BASEDIR, 'lib')
TMPDIR = File.join(BASEDIR, 'tmp')
BINDIR = File.join(BASEDIR, 'bin')
RAKELIBDIR = File.join(BASEDIR, 'rakelib')

require File.join(LIBDIR, 'sakai-info', 'version')

# rake tasks
require File.join(RAKELIBDIR, 'test')
require File.join(RAKELIBDIR, 'gem')
require File.join(RAKELIBDIR, 'db')
require File.join(RAKELIBDIR, 'doc')
require File.join(RAKELIBDIR, 'misc')

# make the default task to run tests
desc "By default, rake will run tests"
task :default => :test

