# sakai-info Roadmap #

*Last updated 2012-10-11*

### 0.5.3 ###

* Add ability to specify Sequel connect string on command line
* Better date formatting and proper time zone understanding
* More query functionality
* OSP presentation/metaobj support
* More query and shell functionality

### 0.5.4 ###

* RDS schema creation and data loading for MySQL and Oracle testing
* More query and shell functionality
* Test fixture generation for quizzes
* Chat channel/message support
* More OSP support

### 0.5.5 ###

* Barebones web interface - HTML, JSON, and YAML
* More query and shell functionality
* Complete OSP support

### 0.6.x ###

* Global cache instead of per-class
* More query, web, and shell functionality
* Test fixtures and basic unit tests for all represented objects
* RDoc coverage for every class
* Grow support for other library usage besides ad hoc queries

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

