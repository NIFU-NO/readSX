testthat::test_that(desc="Read in XLSX", code = {
  ex_survey2_xlsx <-
          readSX::read_surveyxact(filepath =
                          system.file("extdata", "ex_survey2.xlsx",
                          package = "readSX", mustWork = TRUE))
  testthat::expect_equal(dim(ex_survey2_xlsx), c(999,244))
})
