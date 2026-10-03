# Research-computing design and provenance boundaries

## Scope

This research companion is an independent implementation using the author's MSc survey data, measurement documentation, source-reported SPSS summary statistics, and writing sample. It does not contain transplanted third-party scripts, datasets, graphics, exercises, or instructional text.

## Reproducibility design decisions

| Research requirement | Implementation | Audit boundary |
| --- | --- | --- |
| Repeatable execution | `analysis/master.R` runs input validation, numerical reproduction, sensitivity analysis, and reconciliation tests in an explicit order. | Success requires execution in an R-enabled environment. |
| Transparent transformations | `R/functions.R` defines input and composite scoring rules; `data/metadata/` documents question-to-construct assignments. | The original respondent CSV is not silently modified. |
| Traceability to reported results | `data/reference/spss_published_benchmarks.csv` freezes source-reported rounded values. | Matching reported rounding does not verify every proprietary SPSS setting. |
| Testable statistical claims | `tests/run_tests.R` checks alphas, correlations, regression coefficients, and model fit. | Results describe cross-sectional associations, not causal effects. |
| Inspectable research narrative | Quarto pages display methodology, limitations, empirical analysis, and a separately marked theoretical specification. | Dynamic theory parameters are not fitted from these survey responses. |
| Publication boundaries | Ethics, consent, journal rights, and public data release require review before changing repository visibility. | This repository is not an institutional or journal-endorsed resource. |

## Attribution policy

The analytical code and explanatory text were independently authored for this repository. External literature and source evidence remain attributable through ordinary academic citation practices. A reproducibility design does not establish collaboration with, or approval from, any external research group.
