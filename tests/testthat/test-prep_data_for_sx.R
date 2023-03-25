testthat::test_that("write_data_for_sx", {
  tmpfile <- tempfile(pattern = "test", fileext = ".csv")
  write_data_for_sx(mtcars,
                    filepath = tmpfile)
  testthat::expect_true(file.exists(tmpfile))

  testthat::expect_error(
    write_data_for_sx(mtcars,
                    filepath = tmpfile),
  regexp = "already exists\\. Consider `overwrite = FALSE`")
  file.remove(tmpfile)
})
