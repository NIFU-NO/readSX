testthat::test_that(desc = "Read in XLSX", code = {
  files <- system.file("extdata", "ex_survey2.xlsx",
    package = "readSX", mustWork = TRUE
  )
  ex_survey2 <- readSX::read_surveyxact(filepath = files)


  ex_survey2_i_10a <-
    as.data.frame(table(ex_survey2[["i_10"]], useNA = "a"))
  ex_survey2_i_10a[["Var1"]] <- as.character(ex_survey2_i_10a[["Var1"]])

  truth <-
    readxl::read_excel(
      path = system.file("extdata", "ex_survey2.xlsx",
        package = "readSX", mustWork = TRUE
      ),
      sheet = "Dataset"
    )
  truth_i_10a <- as.data.frame(table(truth[["i_10"]], useNA = "a"))
  truth_i_10a[["Var1"]] <- c("I liten grad", "2", "3", "I stor grad", NA)
  truth_i_10a <- truth_i_10a[c("Var1", "Freq")]

  testthat::expect_equal(truth_i_10a, ex_survey2_i_10a)
  testthat::expect_equal(dim(truth), dim(ex_survey2))
  testthat::expect_equal(
    object = attr(ex_survey2[["i_10"]], "label"),
    expected = "I hvilken grad har du fått inspirasjon eller motivasjon til ditt valg av programområde/programfag fra følgende?  - Populærvitenskapelige bøker og blader"
  )
})


################################################################################
testthat::test_that(desc = "Read in tab_utf16 CSV, unnamed filepaths", code = {
  files <- dir(
    full.names = TRUE,
    path =
      system.file("extdata",
        "ex_survey2_tab_utf16",
        package = "readSX", mustWork = TRUE
      )
  )
  testthat::expect_warning(
    {
      ex_survey2 <-
        readSX::read_surveyxact(filepath = files)
    },
    regexp = "unnamed"
  )

  ex_survey2_i_10a <-
    as.data.frame(table(ex_survey2[["i_10"]], useNA = "a"))
  ex_survey2_i_10a[["Var1"]] <- as.character(ex_survey2_i_10a[["Var1"]])

  truth <-
    readxl::read_excel(
      path = system.file("extdata", "ex_survey2.xlsx",
        package = "readSX", mustWork = TRUE
      ),
      sheet = "Dataset"
    )
  truth_i_10a <- as.data.frame(table(truth[["i_10"]], useNA = "a"))
  truth_i_10a[["Var1"]] <- c("I liten grad", "2", "3", "I stor grad", NA)
  truth_i_10a <- truth_i_10a[c("Var1", "Freq")]

  testthat::expect_equal(truth_i_10a, ex_survey2_i_10a)
  testthat::expect_equal(dim(truth), dim(ex_survey2))
  testthat::expect_equal(
    object = attr(ex_survey2[["i_10"]], "label"),
    expected = "I hvilken grad har du fått inspirasjon eller motivasjon til ditt valg av programområde/programfag fra følgende?  - Populærvitenskapelige bøker og blader"
  )
})


################################################################################
testthat::test_that(desc = "Read in tab_utf16 CSV, named filepaths", code = {
  files <- dir(
    full.names = TRUE,
    path =
      system.file("extdata",
        "ex_survey2_tab_utf16",
        package = "readSX", mustWork = TRUE
      )
  )
  names(files) <- c("dataset", "labels", "structure")
  ex_survey2 <- readSX::read_surveyxact(filepath = files)

  ex_survey2_i_10a <-
    as.data.frame(table(ex_survey2[["i_10"]], useNA = "a"))
  ex_survey2_i_10a[["Var1"]] <- as.character(ex_survey2_i_10a[["Var1"]])

  truth <-
    readxl::read_excel(
      path = system.file("extdata", "ex_survey2.xlsx",
        package = "readSX", mustWork = TRUE
      ),
      sheet = "Dataset"
    )
  truth_i_10a <- as.data.frame(table(truth[["i_10"]], useNA = "a"))
  truth_i_10a[["Var1"]] <- c("I liten grad", "2", "3", "I stor grad", NA)
  truth_i_10a <- truth_i_10a[c("Var1", "Freq")]

  testthat::expect_equal(truth_i_10a, ex_survey2_i_10a)
  testthat::expect_equal(dim(truth), dim(ex_survey2))
  testthat::expect_equal(
    object = attr(ex_survey2[["i_10"]], "label"),
    expected = "I hvilken grad har du fått inspirasjon eller motivasjon til ditt valg av programområde/programfag fra følgende?  - Populærvitenskapelige bøker og blader"
  )
})

#
