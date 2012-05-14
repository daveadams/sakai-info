# sakai-info Roadmap #

*Last updated 2012-05-14*

### 0.5.x ###

* Sqlite test infrastructure for a few basic objects
* Deeper query functionality and field specification
* Simple web query interface - HTML, JSON, and YAML
* Global cache instead of per-class

### 0.6.x ###

* Test fixtures and basic unit tests for all represented objects
* RDoc coverage for every class

### 0.7.x ###

* OSP support

------

Ideas for future releases:

* More complete object relationship support for full drilldown capability
  * Gradebook/assignment/quiz interaction
  * Quiz attempts per-student and per-quiz
  * Assignment submissions per-assignment and per-student
* Support for more Sakai objects
  * OSP
  * Evaluations
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
  * web UI
  * CLI shell

