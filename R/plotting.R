create_plots <- function(items, scores, coefficient_table) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Install ggplot2 to create figures")
  }
  gg <- asNamespace("ggplot2")
  dir.create("figures", recursive = TRUE, showWarnings = FALSE)
  # Figure 1: actual sample distribution of constructed scores, no truncation of Likert range.
  vals <- stack(scores)
  colnames(vals) <- c("score", "construct")
  vals$construct <- factor(vals$construct, levels = names(construct_names),
    labels = unname(construct_names))
  g1 <- ggplot2::ggplot(vals, ggplot2::aes(x = construct, y = score)) +
    ggplot2::geom_boxplot(outlier.alpha = 0.30, width = 0.52, fill = "#b6c9d6", color = "#29495e") +
    ggplot2::coord_cartesian(ylim = c(1, 5)) +
    ggplot2::labs(x = NULL, y = "Composite mean (1–5)",
      title = "Observed distribution of construct scores",
      subtitle = "103 specialist responses; means of their stated Likert items",
      caption = "Descriptive sample evidence, not population estimates") +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 28, hjust = 1),
      panel.grid.minor.x = ggplot2::element_blank())
  ggplot2::ggsave("figures/construct_distributions.png", g1,
    width = 10, height = 5.8, dpi = 250)
  ggplot2::ggsave("figures/construct_distributions.pdf", g1,
    width = 10, height = 5.8)

  b <- coefficient_table[coefficient_table$term %in% predictors, , drop = FALSE]
  b$term <- factor(b$term, levels = predictors,
    labels = unname(construct_names[predictors]))
  g2 <- ggplot2::ggplot(b, ggplot2::aes(x = term, y = standardized_beta)) +
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "#808080") +
    ggplot2::geom_pointrange(ggplot2::aes(ymin = standardized_ci_low,
      ymax = standardized_ci_high), size = 0.48, color = "#29495e") +
    ggplot2::coord_flip() +
    ggplot2::labs(x = NULL, y = "Standardized OLS coefficient; conventional 95% CI",
      title = "Partial associations with perceived architecture",
      subtitle = "Cross-sectional associations; no causal interpretation",
      caption = "Intervals use conventional OLS assumptions; see robust-check note") +
    ggplot2::theme_minimal(base_size = 12)
  ggplot2::ggsave("figures/standardized_associations.png", g2,
    width = 9.4, height = 5.2, dpi = 250)
  ggplot2::ggsave("figures/standardized_associations.pdf", g2,
    width = 9.4, height = 5.2)
}
