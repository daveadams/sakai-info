# sakai-info #

last updated: 2012-04-24  
author: David Adams (daveadams@gmail.com)  
github url: https://github.com/daveadams/sakai-info

The *sakai-info* gem consists of a suite of Ruby libraries which enable the
exploration of a Sakai database without the intermediation of a Java VM or
any official Sakai code, along with a command line tool, `sin`.

Because the primary goal of this tool is to assist in information gathering
and troubleshooting, no capability to change the database is included in the
tool or the libraries.

## Testing ##

Tests are defined in ./test using Test::Unit. The default `rake` action is to
run all tests.

## Building ##

Use `rake` to test and build the gem:

    $ rake gem:build

The resulting gem will be saved to the working directory as
`sakai-info-0.4.1.gem`.

Cleanup built gems using:

    $ rake clean

## Installing ##

Install the *sakai-info* gem locally with:

    $ rake gem:install

Uninstall with:

    $ rake gem:uninstall

## Database Connectivity ##

[Sequel](http://sequel.rubyforge.org) is used for database connectivity. Driver
gems must also be installed to support whatever database or databases you use.

Oracle support requires the `ruby-oci8` gem, and MySQL support requires the
`mysql` gem. Some unit tests make use of the `sqlite3` gem.

## MySQL Support ##

MySQL support is now working. Your MySQL server must have the setting
`lower_case_table_names=1` or be running on a case-insensitive filesystem.

I recommend you use the `mysql2` gem, which is faster than the `mysql` or
`ruby-mysql` gems and is also much better tested.

## Configuration ##

To run, *sakai-info* needs to be able to connect to your Sakai database server.
It is possible to specify multiple instances to choose from at runtime.

In this release, *sakai-info* expects a to find the config in a file located at
`$HOME/.sakai-info`. The file must be in YAML format and can contain one or
more Sakai database connection nicknames and connection strings, for example:

    prod: oracle://sakai:password@SAKAIPROD
    test: mysql2://test:password@mysql-host/db_name
    local: mysql2://sakai:ironchef@localhost/db_name

The first connection in the list is the default connection. Other connections
may be specified using the corresponding YAML key, which functions as a
nickname for the connection.

[More information on how to specify a Sequel connection string.](http://sequel.rubyforge.org/rdoc/files/doc/opening_databases_rdoc.html)

## Command Line Usage ##

After installing the gem, the `sin` program should be found in your PATH. For
usage details, run:

    $ sin help

## Library Usage ##

To use the library in your own Ruby programs, simply specify:

    require 'sakai-info'

Further specifying `include SakaiInfo` will pull all object classes into the
primary namespace and could save some typing. Be careful that class names such
as `User`, `Site`, and `Group` do not conflict with other elements of your
program.

Full RDoc documentation for each class is not available in this release, but is
planned for a future release.

## Change History ##

See CHANGELOG.md

## Future Plans ##

See ROADMAP.md

## License ##

This work is dedicated to the public domain. No rights are reserved. See
LICENSE for more information.

## Acknowledgements ##

Thanks so much to Will Humphries for his interest, feedback, and assistance in
testing.
