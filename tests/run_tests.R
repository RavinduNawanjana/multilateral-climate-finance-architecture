# Numeric regression checks target supplement rounding, not exact float equality.
source("R/functions.R")
x <- read_survey()
z <- composite_scores(x)
stopifnot(nrow(x) == 103L, ncol(x) == 32L, !anyNA(x))
stopifnot(identical(colnames(x), paste0("V", 1:32)))
stopifnot(nrow(z) == 103L, ncol(z) == 5L)

for (k in names(construct_columns)) {
  a <- alpha_raw(x[, construct_columns[[k]], drop = FALSE])
  b <- get_benchmark("cronbach_alpha", k)
  if (!is.finite(a) || abs(a - b) >= 0.00051) {
    stop(sprintf("alpha mismatch: %s R=%.6f reference=%.3f", k, a, b))
  }
}
for (k in predictors) {
  a <- stats::cor(z[[k]], z$CFA)
  b <- get_benchmark("pearson_r", k)
  if (!is.finite(a) || abs(a - b) >= 0.00051) {
    stop(sprintf("correlation mismatch: %s R=%.6f reference=%.3f", k, a, b))
  }
}
fit <- fit_ols(z)
co <- report_coefficients(fit, z)
for (k in predictors) {
  a <- co$standardized_beta[co$term == k]
  b <- get_benchmark("standardized_beta", k)
  if (length(a) != 1L || abs(a - b) >= 0.00051) {
    stop(sprintf("standardized beta mismatch: %s R=%.6f reference=%.3f", k, a, b))
  }
}
stopifnot(abs(summary(fit)$r.squared - get_benchmark("model_r_squared", "full")) < 0.00051)
stopifnot(abs(summary(fit)$adj.r.squared - get_benchmark("model_adjusted_r_squared", "full")) < 0.00051)
# A substantive sign/definition guard rather than relying only on a number.
stopifnot(all(names(construct_columns) == c("IC", "BFD", "PRA", "TAFU", "CFA")))
cat("All R data/alpha/correlation/regression reconciliation checks passed.\n")
