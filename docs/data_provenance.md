# Data lineage

1. **Source**: `Climate_Finance_Architecture_Survey_Responses.csv`, provided with `Climate_Finance_Architecture_Codebook_and_Response_Coding.xlsx` and an SPSS `.sav` file. The source README identifies an anonymised 103-person response matrix and a 32-item crosswalk.
2. **Research input**: `data/raw/survey_responses.csv` is a byte-for-byte copy of the submitted CSV; the repository must remain private until the author confirms consent and ethics approval permit respondent-level public disclosure. GitHub Actions generates a SHA-256 list of tracked files as a downloadable workflow artifact rather than keeping a possibly outdated committed manifest.
3. **Codebook**: extracted from *the source Excel workbook* through `artifact_tool` into `data/metadata/item_codebook.csv`; response keys mapped to source groups.
4. **QA**: `analysis/01_validate.R` enforces row/column counts, item range and mapping; missing cells cause a hard failure.
5. **Transformation**: `R/functions.R::composite_scores()` forms five unweighted item means.
6. **Analysis**: `analysis/02_reproduce.R` computes reliability, associations, diagnostics and figure data.
7. **Source reconciliation**: `tests/run_tests.R` checks numerical R output against source-supplement rounded values.
8. **Presentation**: `empirical-analysis.qmd` executes the master script and presents tables and figures.

The original SPSS `.spv`, `.sav`, codebook workbook and editable manuscript are not included in the public repository. Raw data have not been modified to force a match to published figures.
