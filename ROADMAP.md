# sakai-info Roadmap #

*Last updated 2012-10-07*

### 0.5.2 ###

* Ability to specify alternate config file at the command line
* Better date formatting and proper time zone understanding
* More query functionality
* Proof-of-concept sin shell
* Chat channel/message support
* Alias support
* Add simple tests against user/site fixture data

### 0.5.3 ###

* RDS schema creation and data loading for MySQL and Oracle testing
* More query and shell functionality
* Test fixture generation for quizzes

### 0.5.4 ###

* Barebones web interface - HTML, JSON, and YAML
* More query and shell functionality

### 0.5.5 ###

* Global cache instead of per-class
* More query, web, and shell functionality

### 0.6.x ###

* Test fixtures and basic unit tests for all represented objects
* RDoc coverage for every class
* More focus on other library usage besides ad hoc CLI/web queries

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

