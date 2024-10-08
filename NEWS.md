# readSX 0.8.7
* Internal refactoring to reduce duplication.
* Updated roxygen2 to 7.3.0.
* Minor CRAN fixes for Mac M1.

# readSX 0.8.5
* Minor fix for CRAN

# readSX 0.8.4

* Added wrapper function write_data_for_sx() for easily importing respondent lists into SurveyXact.

# readSX 0.8.3

* CRAN release version.
* Removed dependence on labelled-package.
* Added more tests: CSV in encodings utf16, ansi, and utf8, semicolon and comma-separated
* Fixed bugs where named character vector filepaths would not be processed.
* More checks and better error messages if files not found or strange formats.
* Refactored code into smaller internal functions.
* cli-based condition messages rather than rlang.
* Added test coverage and associated badges to readme
