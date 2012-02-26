# sakai-info Roadmap #

*Last updated 2012-02-26*

### 0.3.1  ###

* CLI access to assignments

### 0.3.2 ###

* CLI access to groups

### 0.3.3 ###

* CLI access to pages and tools

### 0.3.4 ###

* CLI access to forums

### 0.4 ###

* Standardized abstraction for user and site to support --mod and --dbrow
* Sqlite test infrastructure for a few basic objects

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

