
#' Checks If Filepath is Valid, Optionally Fixes It.
#'
#' @param filepath Character vector of filepaths to check.
#' @importFrom cli cli_abort cli_warn
#' @return filepath as named character vector
#'
check_filepath <- function(filepath = filepath) {
  if (!inherits(x = filepath, what = "character")) {
    cli::cli_abort(c("{.arg filepath} must be of type `character` or `fs_path` vector.",
      x = "You supplied a {.cls {class(filepath}}"
    ))
  }
  files_exist <- file.exists(filepath)
  if (!all(files_exist)) {
    cli::cli_abort(c("File{?s} not found:", filepath[files_exist]))
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
      all(names(filepath) %in% c("dataset", "structure", "labels"))) {
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
          dataset = grep("dataset\\.csv", filepath, ignore.case = TRUE, value = TRUE),
          structure = grep("structure\\.csv", filepath, ignore.case = TRUE, value = TRUE),
          labels = grep("labels\\.csv", filepath, ignore.case = TRUE, value = TRUE)
        )

      if (any(nchar(filepath) == 0L)) {
        cli::cli_abort(c("Unable to guess roles from filenames.",
          x = "Problem with",
          filepath[nchar(filepath) == 0L]
        ))
      }
      return(filepath)
    }
  } else {
    cli::cli_abort(c("Invalid {.arg filepath}:",
      i = "{.arg filepath} must be either:",
      i = "1) a string pointing to an xlsx-file,",
      i = "2) a character vector of length 3 with the names c('dataset', 'labels', 'structure'), or",
      i = "3) a character vector of length 3 with CSV-files dataset.csv, structure.csv and labels.csv.",
      x = paste0("{.arg filepath} is currently a {.cla class(filepath)[1]} of length ", paste0(length(filepath), collapse = ","))
    ))
  }
}


map <- function(.x, .f, ...) {
  .f <- as_function(.f, env = global_env())
  lapply(.x, .f, ...)
}


reduce <- function(.x, .f, ..., .init) {
  f <- function(x, y) .f(x, y, ...)
  Reduce(f, .x, init = .init)
}
