test_that("check_filepath", {
  expect_error(readSX:::check_filepath("fakefile.xlsx"),
               regexp = "1 file not found")
  expect_error(readSX:::check_filepath("fakefile.xlsx"),
               regexp = "fakefile\\.xlsx")

  expect_error(readSX:::check_filepath(c("fakefile.xlsx", "fakefile2.xlsx")),
               regexp = "2 files not found")
  expect_error(readSX:::check_filepath(c("fakefile.xlsx", "fakefile2.xlsx", "fakefile3")),
               regexp = "3 files not found")
  expect_match(readSX:::check_filepath(system.file("extdata", "ex_survey2.xlsx",
                                                   package = "readSX", mustWork = TRUE)),
              regexp = "ex_survey2.xlsx", fixed = TRUE)

  expect_named(readSX:::check_filepath(system.file("extdata", "ex_survey2.xlsx",
                                                   package = "readSX", mustWork = TRUE)),
  expected = "excel")
  expect_error(readSX:::check_filepath(system.file("extdata", "ex_survey2_tab_utf16",
                                                   package = "readSX", mustWork = TRUE)),
               regexp = "Invalid `filepath`")
  expect_warning(readSX:::check_filepath(dir(system.file("extdata", "ex_survey2_tab_utf16",
                                                   package = "readSX", mustWork = TRUE),
                                           full.names = T)),
                 regexp = "`filepath` is unnamed.")
  expect_warning(readSX:::check_filepath(dir(system.file("extdata", "ex_survey2_tab_utf16",
                                                         package = "readSX", mustWork = TRUE),
                                             full.names = T)),
                 regexp = "Guessing roles from filenames...")
  files <- dir(system.file("extdata", "ex_survey2_tab_utf16",
                           package = "readSX", mustWork = TRUE),
               full.names = T)
  names(files) <- c("dataset", "labels", "structure")
  expect_named(readSX:::check_filepath(files), c("dataset", "labels", "structure"))

})
