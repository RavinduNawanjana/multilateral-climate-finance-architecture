source("R/functions.R")
z <- composite_scores(read_survey())
all_ols <- fit_ols(z)
all_coef <- stats::coef(all_ols)[predictors]
loo <- do.call(rbind, lapply(seq_len(nrow(z)), function(i) {
  sm <- stats::coef(fit_ols(z[-i, , drop = FALSE]))[predictors]
  data.frame(omit_row_index_1_based = i, construct = predictors,
    unstandardized_slope = as.numeric(sm),
    difference_from_full_model = as.numeric(sm - all_coef), row.names = NULL)
}))
# Row-level sensitivity file stays local; do not publish inferred respondent signatures.
write_output(loo, "outputs/restricted/leave_one_out_rows.csv")
sensitivity <- do.call(rbind, lapply(predictors, function(k) {
  ss <- loo[loo$construct == k, ]
  data.frame(construct = k, full_sample_slope = as.numeric(all_coef[k]),
    min_leave_one_out_slope = min(ss$unstandardized_slope),
    max_leave_one_out_slope = max(ss$unstandardized_slope),
    max_abs_change = max(abs(ss$difference_from_full_model)))
}))
write_output(sensitivity, "outputs/tables/leave_one_out_summary.csv")
cat("Leave-one-respondent-out sensitivity summary complete (descriptive, not causal).\n")
