sakai-info
==========

*sakai-info* is a command line tool and a suite of Ruby libraries which enable
the exploration of a Sakai database without the intermediation of a Java VM or
any official Sakai code.

Because the primary goal of this tool is to assist in information gathering
and troubleshooting, no capability to change the database is included in the
tool or the libraries.

Meta
----
last updated: 2012-02-18  
author: David Adams (daveadams@gmail.com)  
github url: https://github.com/daveadams/sakai-info

Testing
-------

Tests are defined in ./test using Test::Unit. The default `rake` action is to
run all tests.

Building
--------

Use `rake` to test and build the gem:

    $ rake gem:build
    
The resulting gem will be saved to the working directory as
`sakai-info-0.0.0.gem`.

Installing
----------

Install the *sakai-info* gem locally with:

    $ rake gem:install

Uninstall with:

    $ rake gem:uninstall

Supported Databases
-------------------

For this release, only Oracle databases are supported. MySQL support is planned
as soon as possible. Support for SQLite or some other lightweight database may
be implemented for unit testing purposes.

Configuration
-------------

To run, *sakai-info* needs to be able to connect to your Sakai database server.
It is possible to specify multiple instances to choose from at runtime.

TODO: document configuration options

Command Line Usage
------------------

After installing the gem, the `sakai-info` program should be found in your PATH.
As of the current release, this program is only a placeholder.

Library Usage
-------------

To use the library in your own Ruby programs, simply specify:

    require 'sakai-info'

Further specifying `include SakaiInfo` will pull all object classes into the
primary namespace and could save some typing. Be careful that class names such
as `User`, `Site`, and `Group` do not conflict with other elements of your
program.

Full RDoc documentation for each class is not available in this release, but is
planned for a future release.

Change History
--------------

See CHANGELOG.md

Future Plans
------------

See ROADMAP.md

License
-------
This work is dedicated to the public domain. No rights are reserved. See
LICENSE for more information.

