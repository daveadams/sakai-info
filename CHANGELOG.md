# sakai-info Change History #

### 0.5.3 ###

*Released 2012-??-??*

* Unit test cleanup, refactor, and migration to MiniTest
* Added simple tests against user/site fixture data
* Refactored and simplified rake tasks for initializing test database
* Added ability to specify alternate config file at the command line
* New method to find ContentResource by UUID
* Metaobj and Wiki support
* More graceful failing for Users, Sites, and AuthzRealms not found

### 0.5.2 ###

*Released 2012-10-11*

* Added JSON output option for lookups
* Proof-of-concept sin shell
* Alias support

### 0.5.1 ###

*Released 2012-10-07*

* Added new private-message lookup type
* Adjusted to new use of the 'author' field in PrivateMessage/ForumPost table
* Now including post body with forum-post
* Added new pending-quiz-access-control and published-quiz-access-control types
* Integrated access control objects with quiz object output
* New deleted-content-resource type
* New rake task to load test fixtures into database
* Added to_csv method with field selection to SakaiObject
* Added more use cases to POC query mode
* Added field selection to lookup via --fields=x,y,z

### 0.5.0 ###

*Released 2012-06-21*

* Added --full-children and --all options for content
* Refactored rake tasks into one directory
* Added a barebones proof-of-concept-only query mode
* Removed quiz, quiz-section, and quiz-item types due to ID overlap risk
* Added new special modes to intercept calls for these removed object types
* Added published-quiz and pending-quiz types
* Added published-quiz-section and pending-quiz-section types
* Added published-quiz-item and pending-quiz-item types
* Added --texts record listing to published-quiz-item and pending-quiz-item
* Added --items record listing to quiz
* Better summaries for items in quiz-sections and quizzes
* Added a number of command line object type shortcuts
* Added random test fixture generation for user objects

### 0.4.6 ###

*Released 2012-05-19*

* Reinstated stub PrivateMessage class
* Removed defunct message.rb
* Re-added `count_by_date` method to PrivateMessage and ForumPost classes

### 0.4.5 ###

*Released 2012-05-14*

* CLI support for authz roles, realms, and functions
* Bugfix: fix syntax error using ContentCollection.find! on missing collections
* Bugfix: gracefully handle missing AnnouncementChannel for Site serializations

### 0.4.4 ###

*Released 2012-05-12*

* Standardized gradebook and gradebook-item APIs
* Renamed GradableObject class to GradebookItem
* CLI access to gradebook and gradebook-item objects

### 0.4.3 ###

*Released 2012-05-10*

* Tweaked site summary serialization to display creator EID
* Added attempted_at field to quiz attempt item serializations
* Added CLI support for announcement and announcement-channel
* Added clear_cache class method to all objects using caches
* Added Cache.clear_all class and method to SakaiInfo module

### 0.4.2 ###

*Released 2012-05-04*

* Fixed issue in assignment-submission for formatting entity dates
* Added status property to quizzes along with interpretation of the value
* Added support for provided users to User object (submitted by Will Humphries)
* Allowed .sakai-info file to point to another location for configuration

### 0.4.1 ###

*Released 2012-04-22*

* Improved MySQL support (from not working at all to mostly working)
* Removed properties performance hack which was inapplicable to MySQL
* Cleaned up site default serialization

### 0.4.0 ###

*Released 2012-04-21*

* CLI access to content
* Content binary entity parsing
* Command line tool name change to "sin"

## 0.3.5 ##

*Released 2012-04-02*

* Basic Forum, ForumThread, and ForumPost support in CLI
* Refactored Forum support in library
* Fixed join_role serialization for Site

## 0.3.4 ##

*Released 2012-03-09*

* Added --dbrow and --mod support to User
* User property lookup performance improvements

## 0.3.3 ##

*Released 2012-03-09*

* Fixed performance bug connecting to the database on every query
* Performance improvements (with possible downsides) in property lookups
* Group supports dbrow, improved serialization
* CLI now supports group objects

## 0.3.2 ##

*Released 2012-03-08*

* Site supports dbrow and ModProps, added published? method
* Page supports dbrow, improved serialization methods
* Tool supports dbrow, improved serialization methods
* CLI now supports page and tool objects

## 0.3.1 ##

*Released 2012-02-29*

* New objects: quiz-attempt, quiz-attempt-item, quiz-attempt-item-attachment
* More new objects: assignment, assignment-submission
* SakaiXMLEntity base class supports ModProps
* New standard CL arguments: --dbrow-only and --mod-details
* First steps towards a sqlite test infrastructure: schema creation
* First steps towards better Sakai DB docs: graphviz file for quiz tables

## 0.3.0 ##

*Released 2012-02-26*

* Support for new object types: question-pool, quiz, quiz-section, quiz-item
* New CLI options for logging and trace-debugging
* New object abstraction patterns allow for --dbrow and --mod options

## 0.2.1 ##

*Released 2012-02-25*

* Bugfix: pending quiz count was reporting incorrect numbers
* Bugfix: published quiz list was actually listing pending quizzes

## 0.2.0 ##

*Released 2012-02-24*

* Sequel now used as the database driver, enabling MySQL and Sqlite support
* Simplified configuration file format
* CLI tool now provides details on user and site objects

## 0.1.0 ##

*Released 2012-02-19*

* Initial release
* Oracle-only support
* Extremely limited CLI functionality

