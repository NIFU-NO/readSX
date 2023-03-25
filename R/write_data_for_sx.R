#' Writes Data with Respondents in CSV Format Required for SurveyXact Import
#'
#' @param data Data frame (or tibble).
#' @param filepath Filepath as string
#' @param overwrite Whether to overwrite existing file or not (default).
#' @importFrom utils write.table
#'
#' @return Side-effect: writes file. Returns filepath.
#' @export
#'
#' @examples
#' \dontrun{write_data_for_sx(mtcars, filepath="test.csv")}
write_data_for_sx <- function(data, filepath, overwrite = FALSE) {
  if(!overwrite && file.exists(filepath)) cli::cli_abort("{.arg filepath} {.path {filepath}} already exists. Consider `overwrite = FALSE`")
  data <- data
  data_list <- lapply(names(data), function(col) {
    if(is.character(data[[col]]) || is.factor(data[[col]])) {
      data[[col]] <- gsub(pattern = "[\n\r]", replacement = "", x = data[[col]])
    }
    data[[col]]
    })
  data <- cbind(data_list)

  write.table(x = data, quote = FALSE, sep = "\t", na = "", row.names = F,
              col.names = TRUE, fileEncoding = "UTF-16LE",
              file = filepath)
  filepath
}
