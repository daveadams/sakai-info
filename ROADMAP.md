# sakai-info Roadmap #

*Last updated 2012-02-24*

### 0.3 ###

* CLI access to more objects, eg quizzes, tools, assignments, and groups
* Sqlite test infrastructure for a few basic objects

### 0.5 ###

* Test fixtures and basic unit tests for all represented objects
* RDoc coverage for every class

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

