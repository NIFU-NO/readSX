# Writes Data with Respondents in CSV Format Required for SurveyXact Import

Writes Data with Respondents in CSV Format Required for SurveyXact
Import

## Usage

``` r
write_data_for_sx(data, filepath, overwrite = FALSE)
```

## Arguments

- data:

  Data frame (or tibble).

- filepath:

  Filepath as string

- overwrite:

  Whether to overwrite existing file or not (default).

## Value

Side-effect: writes file. Returns filepath.

## Examples

``` r
tmpfile <- tempfile(fileext = ".csv")
write_data_for_sx(mtcars, filepath=tmpfile)
#> [1] "/tmp/Rtmp5wj7yC/file1cb650eacb42.csv"
unlink(tmpfile)
```
