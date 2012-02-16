sakai-info
==========

*sakai-info* is a command line tool and a suite of Ruby libraries which enable
the exploration of a Sakai database without the intermediation of a Java VM or
any official Sakai code. Because the primary goal of this tool is to assist in
information gathering and troubleshooting, no capability to change the database
is included in the tool or the libraries.

Meta
----
author: David Adams (daveadams@gmail.com)  
last updated: 2012-02-16  
github url: https://github.com/daveadams/sakai-info

Caveat
------

I'm starting from an installation-specific set of libraries and scripts, and
working to make them generic, adding tests along the way. The initial commits
so far are incomplete, although everything works.

Building
--------

Use rake to test and build the gem:

    $ rake test
    $ rake gem:build
    
The resulting gem will be saved to the working directory as
sakai-info-x.x.x.gem. Install it locally with:

    $ rake gem:install

License
-------
This work is dedicated to the public domain. No copyright is reserved. See
LICENSE for more information.

