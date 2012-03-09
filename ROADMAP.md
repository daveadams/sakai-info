# sakai-info Roadmap #

*Last updated 2012-03-09*

### 0.3.5 ###

* CLI access to forums

### 0.3.6 ###

* CLI access to gradebook

### 0.3.7 ###

* CLI access to announcements

### 0.3.8 ###

* CLI access to content

### 0.3.9 ###

* CLI access to authz (realms, roles, functions)

### 0.4 ###

* Sqlite test infrastructure for a few basic objects
* Command line tool name change to "sin"

### 0.5 ###

* Test fixtures and basic unit tests for all represented objects
* RDoc coverage for every class

### 0.6 ###

* Basic OSP support

------

Other things on the wishlist for future releases:

* More complete object relationship support for full drilldown capability
  * Gradebook/assignment/quiz interaction
  * Quiz attempts per-student and per-quiz
  * Assignment submissions per-assignment and per-student
* Support for more Sakai objects
  * OSP
  * Forum topics and posts
  * Private messages
  * Events
  * Sessions
* Generalized reporting capabilities
  * Storage utilization per-site
  * Session and event statistics
* Metrics on various elements
  * Typical quiz duration
  * Quiz/assignment completion rates
  * Forum post rates, post length
* Additional tools
  * httpd log analysis helper
  * RPC client for Sakai-monitoring servlet
  * schema analysis and generators

