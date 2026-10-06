# Verification status

## Independent preparation-stage validation

The source CSV contains **103 rows and 32 items**, in the original `V1`–`V32` order. All responses are integers between 1 and 5, with no missing cells. The questionnaire mapping was extracted from the author's Excel workbook, and an independent numerical audit reproduced the five reported reliability coefficients, four Pearson correlations, four standardized OLS slopes, model R-squared and adjusted R-squared to the source's published rounding.

## GitHub Actions execution (2026-10-03)

The first two GitHub Actions attempts **successfully completed** the following live R steps:
- survey and codebook validation;
- descriptive, reliability, correlation and OLS reproduction;
- leave-one-respondent-out sensitivity analysis;
- source-reported SPSS benchmark comparisons via `tests/run_tests.R`.

The GitHub job logs explicitly reported: `All R data/alpha/correlation/regression reconciliation checks passed.` Those first two jobs nevertheless **failed while rendering Quarto**, because `rmarkdown` was absent from the installed R package list. A later workflow revision installed `rmarkdown` and successfully completed the full R/Quarto build. After the writing-sample directory was intentionally removed on 2026-10-06, run #5 failed only because the workflow still required that deleted PDF. The workflow now validates the required public data/code inputs instead of requiring a manuscript file. **The latest GitHub Actions run is the authoritative source for current render status**, not this static document.

## What this repository does not verify

- The original SPSS `.spv` was not re-executed in IBM SPSS; only a precisely identified subset of source-reported numerical results was checked independently.
- Factor-analysis settings, marker-variable analyses, and SPSS bootstrap configurations were not replicated.
- Interview transcripts and recordings were not independently re-coded, and they are intentionally not part of the public-facing research companion.
- The theoretical Institutional Reinforcement Cycle parameters were not estimated.
- Journal posting permissions, interview quotation rights and ethics permission for publishing respondent-level data require review before changing the GitHub repository's visibility.

## Data integrity

Every GitHub Actions execution creates `outputs/integrity/MANIFEST.sha256`, covering all tracked input/code/document files in the commit being tested. The fresh manifest is available in the workflow's downloadable artifact after the run; no workflow step should rewrite author-controlled research files or push commits.
