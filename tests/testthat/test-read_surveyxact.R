testthat::test_that(desc = "Read in XLSX", code = {
  files <- system.file(
    "extdata",
    "ex_survey2.xlsx",
    package = "readSX",
    mustWork = TRUE
  )
  ex_survey2 <- readSX::read_surveyxact(filepath = files)

  ex_survey2_i_10a <-
    as.data.frame(table(ex_survey2[["i_10"]], useNA = "a"))
  ex_survey2_i_10a[["Var1"]] <- as.character(ex_survey2_i_10a[["Var1"]])

  truth <-
    readxl::read_excel(
      path = system.file(
        "extdata",
        "ex_survey2.xlsx",
        package = "readSX",
        mustWork = TRUE
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
    path = system.file(
      "extdata",
      "ex_survey2_tab_utf16",
      package = "readSX",
      mustWork = TRUE
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
      path = system.file(
        "extdata",
        "ex_survey2.xlsx",
        package = "readSX",
        mustWork = TRUE
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
    path = system.file(
      "extdata",
      "ex_survey2_tab_utf16",
      package = "readSX",
      mustWork = TRUE
    )
  )
  names(files) <- c("dataset", "labels", "structure")
  ex_survey2 <- readSX::read_surveyxact(filepath = files)

  ex_survey2_i_10a <-
    as.data.frame(table(ex_survey2[["i_10"]], useNA = "a"))
  ex_survey2_i_10a[["Var1"]] <- as.character(ex_survey2_i_10a[["Var1"]])

  truth <-
    readxl::read_excel(
      path = system.file(
        "extdata",
        "ex_survey2.xlsx",
        package = "readSX",
        mustWork = TRUE
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
testthat::test_that("Warns when Dataset has deleted columns", {
  dataset_path <- system.file(
    "extdata",
    "ex_survey2_tab_utf16",
    "dataset.csv",
    package = "readSX",
    mustWork = TRUE
  )
  labels_path <- system.file(
    "extdata",
    "ex_survey2_tab_utf16",
    "labels.csv",
    package = "readSX",
    mustWork = TRUE
  )
  structure_path <- system.file(
    "extdata",
    "ex_survey2_tab_utf16",
    "structure.csv",
    package = "readSX",
    mustWork = TRUE
  )

  # Read original dataset and drop a column, write to temp file
  tmp_dir <- tempdir()
  tmp_dataset <- file.path(tmp_dir, "dataset.csv")
  file.copy(dataset_path, tmp_dataset, overwrite = TRUE)
  file.copy(labels_path, file.path(tmp_dir, "labels.csv"), overwrite = TRUE)
  file.copy(
    structure_path,
    file.path(tmp_dir, "structure.csv"),
    overwrite = TRUE
  )

  # Read original, drop a column, re-write
  original <- utils::read.delim(
    tmp_dataset,
    fileEncoding = "UTF-16",
    stringsAsFactors = FALSE,
    skipNul = TRUE
  )
  col_to_drop <- "i_10"
  original[[col_to_drop]] <- NULL
  utils::write.table(
    original,
    file = tmp_dataset,
    sep = "\t",
    row.names = FALSE,
    fileEncoding = "UTF-16",
    quote = FALSE
  )

  files <- c(
    dataset = tmp_dataset,
    labels = file.path(tmp_dir, "labels.csv"),
    structure = file.path(tmp_dir, "structure.csv")
  )

  testthat::expect_warning(
    readSX::read_surveyxact(filepath = files),
    regexp = "Structure-variables"
  )

  unlink(file.path(tmp_dir, c("dataset.csv", "labels.csv", "structure.csv")))
})

#
