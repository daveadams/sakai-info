# sakai-info Change History #

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

