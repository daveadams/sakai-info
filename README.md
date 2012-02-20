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
last updated: 2012-02-19  
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
`sakai-info-0.2.0.gem`.

Cleanup built gems using:

    $ rake clean

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

System Requirements
-------------------

For Oracle support, the `ruby-oci8` gem is required.

So far, testing has occurred using Ruby 1.9.1p376 and Ruby 1.9.2p290, with
version 2.0.6 of the `ruby-oci8` gem, on Ubuntu 10.04, against Oracle 11g
R2 versions 11.2.0.1 and 11.2.0.3, using the Oracle Instant Client version
11.2.0.3.

Configuration
-------------

To run, *sakai-info* needs to be able to connect to your Sakai database server.
It is possible to specify multiple instances to choose from at runtime.

In this release, *sakai-info* expects a to find the config in a file located at
`$HOME/.sakai-info`. The file must be in YAML format and can contain one or
more Sakai database connection definitions. To define a single database
connection, specify the file like this:

    dbtype: oracle
    username: sakai
    password: <password>
    service: SAKAIPROD
    host: oracle.db
    port: 1521

The `port` value is optional, with a default of 1521. If your Oracle setup uses
a `tnsnames.ora` file, then both `host` and `port` can be excluded, and
`service` will be used to find the corresponding `tnsnames.ora` entry.

Multiple instances may be specified by using the following format:

    default: production
    instances:
      production:
        dbtype: oracle
        username: sakai
        password: <password>
        service: SAKAIPROD
        host: oracle.db
        port: 1521
     test:
       dbtype: oracle
       username: sakai
       password: <password>
       service: SAKAITEST

The `default` key identifies which of the connections under `instances` you
wish to be used in the absence of any explicit specification. Other instances
will be referenced by the corresponding YAML key (eg, `production` and `test`
in the example above).

Command Line Usage
------------------

After installing the gem, the `sakai-info` program should be found in your
PATH. For this release, very limited functionality is included. For usage
details, run:

    $ sakai-info help

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

