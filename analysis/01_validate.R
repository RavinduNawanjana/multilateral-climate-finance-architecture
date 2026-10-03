source("R/functions.R")
x <- read_survey()
meta <- utils::read.csv("data/metadata/item_codebook.csv", stringsAsFactors = FALSE,
  check.names = FALSE)
stopifnot(nrow(meta) == 32L)
stopifnot(identical(meta$source_column, colnames(x)))
stopifnot(identical(meta$construct_id, rep(c("IC", "BFD", "PRA", "TAFU", "CFA"),
  times = c(7, 7, 7, 7, 4))))
status <- data.frame(check = c("respondents", "items", "missing_cells", "non_likert_cells",
  "duplicated_complete_response_patterns"),
  value = c(nrow(x), ncol(x), sum(is.na(x)), sum(!as.matrix(x) %in% 1:5),
    sum(duplicated(x))))
write_output(status, "outputs/tables/input_validation.csv")
cat("Validated input survey and complete item-to-construct crosswalk.\n")
