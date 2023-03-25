## code to prepare `ex_survey2` dataset goes here
ex_survey2_xlsx <-
      readSX::read_surveyxact(filepath =
                      system.file("extdata", "ex_survey2.xlsx",
                      package = "readSX", mustWork = TRUE))
usethis::use_data(ex_survey2_xlsx, overwrite = TRUE)
