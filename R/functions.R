# Minimal-dependency computation; base R implements the statistical core.
construct_names <- c(
  IC = "Institutional collaboration",
  BFD = "Blended finance deployment",
  PRA = "Policy and regulatory alignment",
  TAFU = "Transparency and accountability",
  CFA = "Perceived climate finance architecture"
)
construct_columns <- list(
  IC = paste0("V", 1:7),
  BFD = paste0("V", 8:14),
  PRA = paste0("V", 15:21),
  TAFU = paste0("V", 22:28),
  CFA = paste0("V", 29:32)
)
predictors <- c("IC", "BFD", "PRA", "TAFU")

read_survey <- function(path = "data/raw/survey_responses.csv") {
  x <- utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
  target <- paste0("V", 1:32)
  if (!identical(colnames(x), target)) stop("Source CSV must have exactly V1 ... V32 in order")
  if (nrow(x) != 103L) stop("Unexpected number of rows; investigate provenance")
  if (anyNA(x)) stop("Missing responses require an explicit missing-data protocol")
  if (!all(vapply(x, is.numeric, logical(1)))) stop("All 32 questionnaire columns must be numeric")
  if (any(!as.matrix(x) %in% 1:5)) stop("Survey responses must be integer codes 1..5")
  x
}

composite_scores <- function(x) {
  stopifnot(all(unlist(construct_columns) %in% colnames(x)))
  z <- as.data.frame(lapply(construct_columns, function(ids) rowMeans(x[, ids, drop = FALSE])))
  z
}

alpha_raw <- function(items) {
  # Standard raw-score Cronbach alpha, equivalent to covariance-matrix formula.
  x <- as.matrix(items)
  k <- ncol(x)
  if (k < 2L) stop("Need at least two items")
  total_variance <- stats::var(rowSums(x))
  if (total_variance <= 0) stop("Zero total score variance")
  as.numeric((k / (k - 1)) * (1 - sum(apply(x, 2, stats::var)) / total_variance))
}

fit_ols <- function(scores) {
  stats::lm(CFA ~ IC + BFD + PRA + TAFU, data = scores)
}

report_correlations <- function(scores) {
  out <- lapply(predictors, function(k) {
    res <- stats::cor.test(scores[[k]], scores$CFA, method = "pearson")
    data.frame(construct = k, r = unname(res$estimate),
      p_value = res$p.value,
      ci_low = res$conf.int[1], ci_high = res$conf.int[2],
      n = nrow(scores), stringsAsFactors = FALSE)
  })
  do.call(rbind, out)
}

report_coefficients <- function(fit, scores) {
  sm <- summary(fit)
  co <- sm$coefficients
  ci <- stats::confint(fit)
  rr <- data.frame(term = rownames(co), estimate = unname(co[, 1]),
    standard_error = unname(co[, 2]), t_value = unname(co[, 3]),
    p_value = unname(co[, 4]), ci_low = unname(ci[, 1]),
    ci_high = unname(ci[, 2]), stringsAsFactors = FALSE)
  rr$standardized_beta <- NA_real_
  rr$standardized_ci_low <- NA_real_
  rr$standardized_ci_high <- NA_real_
  for (k in predictors) {
    at <- match(k, rr$term)
    multiplier <- stats::sd(scores[[k]]) / stats::sd(scores$CFA)
    rr$standardized_beta[at] <- rr$estimate[at] * multiplier
    rr$standardized_ci_low[at] <- rr$ci_low[at] * multiplier
    rr$standardized_ci_high[at] <- rr$ci_high[at] * multiplier
  }
  rr
}

report_vif <- function(scores) {
  out <- sapply(predictors, function(k) {
    other <- setdiff(predictors, k)
    reg <- stats::lm(stats::reformulate(other, response = k), data = scores)
    1 / (1 - summary(reg)$r.squared)
  })
  data.frame(construct = names(out), vif = as.numeric(out), row.names = NULL)
}

write_output <- function(x, file) {
  dir.create(dirname(file), recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(x, file, row.names = FALSE, na = "")
  invisible(file)
}

# Registry for source-rounded claims: don't conflate precision with equality.
get_benchmark <- function(metric, construct) {
  s <- utils::read.csv("data/reference/spss_published_benchmarks.csv", stringsAsFactors = FALSE)
  row <- s[s$metric == metric & s$construct_or_variable == construct, ]
  if (nrow(row) != 1L) stop(paste("Reference metric not unique:", metric, construct))
  as.numeric(row$reported_value)
}
