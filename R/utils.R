
#' Checks If Filepath is Valid, Optionally Fixes It.
#'
#' @param filepath Character vector of filepaths to check.
#' @importFrom cli cli_abort cli_warn
#' @importFrom rlang set_names global_env as_function
#' @return filepath as a named character vector
#'
check_filepath <- function(filepath = filepath) {

  csv_names <- c("dataset", "structure", "labels")
  csv_files <- paste0(csv_names, ".csv")

  if (!inherits(x = filepath, what = "character")) {
    cli::cli_abort(c("{.arg filepath} must be of type `character` or `fs_path` vector.",
      x = "You supplied a {.cls {class(filepath}}"
    ))
  }
  files_exist <- file.exists(filepath)
  if (!all(files_exist)) {
    cli::cli_abort(c("{length(files_exist[!files_exist])} file{?s} not found:",
                     "!" = "{.file {filepath[!files_exist]}}"))
  }

  if (!is.null(names(filepath))) {
    names(filepath) <- tolower(names(filepath))
  }

  if (length(filepath) == 1L && grepl("\\.xlsx", filepath, ignore.case = TRUE)) {
    names(filepath) <- "excel"
    return(filepath)
  }
  if (length(filepath) == 3L && all(grepl("\\.csv", filepath, ignore.case = TRUE))) {
    if (!is.null(names(filepath)) &&
      all(names(filepath) %in% csv_names)) {
      return(filepath)
    } else if (is.null(names(filepath))) {
      cli::cli_warn(
        message =
          c("{.arg filepath} is unnamed.",
            i = "Guessing roles from filenames..."
          )
      )

      filepath <-
        c(
          grep("dataset\\.csv", filepath, ignore.case = TRUE, value = TRUE),
          grep("structure\\.csv", filepath, ignore.case = TRUE, value = TRUE),
          grep("labels\\.csv", filepath, ignore.case = TRUE, value = TRUE)
        )
      filepath <- rlang::set_names(filepath, csv_names)

      if (any(nchar(filepath) == 0L)) {
        cli::cli_abort(c("Unable to guess roles from filenames.",
          x = "Problem with {.file {filepath[nchar(filepath) == 0L]}}"
        ))
      }
      return(filepath)
    }
  } else {

    cli::cli_abort(c("Invalid {.arg filepath}:",
      i = "{.arg filepath} must be one of the following:",
      i = "1) a string pointing to an xlsx-file,",
      i = "2) a length-3 character vector with named elements {.var {csv_names}},",
      i = "3) a length-3 character vector to CSV-files named {.file {csv_files}}.",
      x = "{.arg filepath} is currently a {.cls {class(filepath)[1]}} of length {.val {length(filepath)}}."
    ))
  }
}


map <- function(.x, .f, ...) {
  .f <- rlang::as_function(.f, env = rlang::global_env())
  lapply(.x, .f, ...)
}


reduce <- function(.x, .f, ..., .init) {
  f <- function(x, y) .f(x, y, ...)
  Reduce(f, .x, init = .init)
}
