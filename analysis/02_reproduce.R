source("R/functions.R")
x <- read_survey()
scores <- composite_scores(x)
fit <- fit_ols(scores)

rel <- do.call(rbind, lapply(names(construct_columns), function(k) {
  data.frame(construct = k, items = length(construct_columns[[k]]),
             n = nrow(x), cronbach_alpha = alpha_raw(x[, construct_columns[[k]], drop = FALSE]))
}))
write_output(rel, "outputs/tables/reliability.csv")

item_stats <- data.frame(item = colnames(x), mean = vapply(x, mean, 0.0),
  sd = vapply(x, stats::sd, 0.0), n = nrow(x), row.names = NULL)
write_output(item_stats, "outputs/tables/item_descriptives.csv")

summary_stats <- data.frame(construct = names(scores), n = nrow(scores),
  mean = vapply(scores, mean, 0.0), sd = vapply(scores, stats::sd, 0.0), row.names = NULL)
write_output(summary_stats, "outputs/tables/construct_descriptives.csv")

write_output(report_correlations(scores), "outputs/tables/pearson_correlations.csv")
write_output(report_coefficients(fit, scores), "outputs/tables/ols_coefficients.csv")
model_summary <- summary(fit)
write_output(data.frame(n = stats::nobs(fit), residual_df = stats::df.residual(fit),
  r_squared = model_summary$r.squared, adjusted_r_squared = model_summary$adj.r.squared,
  model_f = unname(model_summary$fstatistic[1]),
  f_p_value = stats::pf(model_summary$fstatistic[1], model_summary$fstatistic[2],
    model_summary$fstatistic[3], lower.tail = FALSE)), "outputs/tables/model_summary.csv")
write_output(report_vif(scores), "outputs/tables/vif.csv")

influence <- data.frame(row_index_1_based = seq_len(nrow(x)),
  studentized_residual = stats::rstudent(fit),
  cooks_distance = stats::cooks.distance(fit), leverage = stats::hatvalues(fit),
  stringsAsFactors = FALSE)
influence$cooks_gt_4_over_n <- influence$cooks_distance > (4 / nrow(x))
influence$leverage_gt_2p_over_n <- influence$leverage >
  (2 * length(stats::coef(fit)) / nrow(x))
# Internal sensitivity/QA only; not committed to git: see .gitignore.
write_output(influence, "outputs/restricted/influence_diagnostics.csv")
write_output(data.frame(
  diagnostic = c("count_cooks_gt_4_over_n", "count_leverage_gt_2p_over_n"),
  count = c(sum(influence$cooks_gt_4_over_n), sum(influence$leverage_gt_2p_over_n))),
  "outputs/tables/diagnostic_summary.csv")

if (requireNamespace("sandwich", quietly = TRUE)) {
  X <- stats::model.matrix(fit)
  vcv <- sandwich::vcovHC(fit, type = "HC3")
  se <- sqrt(diag(vcv))
  b <- stats::coef(fit)
  tvals <- b / se
  p <- 2 * stats::pt(abs(tvals), df = stats::df.residual(fit), lower.tail = FALSE)
  write_output(data.frame(term = names(b), estimate = as.numeric(b),
    hc3_se = unname(se), hc3_t = unname(tvals), hc3_p = unname(p)),
    "outputs/tables/exploratory_hc3.csv")
} else {
  cat("Optional package 'sandwich' not found. HC3 robustness table omitted; OLS intact.\n")
}
if (requireNamespace("ggplot2", quietly = TRUE)) {
  source("R/plotting.R")
  create_plots(x, scores, report_coefficients(fit, scores))
} else {
  cat("Package ggplot2 missing. Numeric results complete; plot generation skipped.\n")
}
cat("Core source-data reproduction completed.\n")
