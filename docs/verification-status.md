# Verification status — 2026-10-04

## Completed independent checks (Python numerical audit during packaging)

- Source CSV contains **103 rows × 32 columns**, named V1..V32.
- Responses are all integer **1..5**, without missing cells.
- Codebook was read from the actual Excel sheet names `Codebook` and `SPSS Variable Names`, not manually inferred.
- Independent calculations of the five raw-score Cronbach alphas, Pearson correlations, standardized OLS betas and model R²/adjusted R² match the rounded values used as reference targets.
- The author-provided DOCX writing sample was exported to a **25-page** PDF, and the first and last pages were checked for text completeness.

## Not run in the packaging environment

**R and Quarto executables are unavailable in the artifact-generation environment**, and external package installation is blocked. Therefore no claim is made that the R master script or Quarto site was rendered there. The source files include real executable R code, quantitative tests and GitHub Actions configuration to run them in an R-enabled environment.

When publishing, inspect the GitHub Actions check and preserve `outputs/session_info.txt` and the generated tables. The R test suite has not been passed until it actually runs.

## What this package never verifies

- The full SPSS `.spv` file was preserved byte-for-byte in the private evidence ZIP; it was **not re-executed in SPSS**.
- Exploratory factor analysis, marker-variable bias procedures, and SPSS bootstrap configurations have **not** been replicated.
- Interviews cannot be independently re-coded without transcripts (which are intentionally withheld).
- No IRC structural parameters were estimated.
