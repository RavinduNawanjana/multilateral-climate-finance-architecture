# Changelog

## v1.0.3 — 2026-10-07

- Kept the intentionally deleted writing-sample directory out of the public repository.
- Removed the obsolete CI dependency on `writing-sample/writing_sample.pdf`.
- Replaced PDF-specific verification with checks for the required public data/code inputs plus a fresh tracked-file SHA-256 manifest.
- Removed broken writing-sample links and updated public-facing documentation to reflect the manuscript boundary.
- Retained the read-only R/Quarto reproducibility workflow and benchmark checks.


## v1.0.2 — 2026-10-04

- Restored the original unaltered 25-page PDF with its intended application subtitle from the initial Git commit.
- Replaced the automated PDF rewriting and self-committing workflow with read-only document verification.
- Fixed the missing `rmarkdown` dependency required for Quarto rendering.
- Added tracked-file integrity generation as a GitHub Actions artifact instead of a stale committed checksum snapshot.
- Restored a `.gitignore` for generated analysis, editor state and original private SPSS binaries.
- Updated documentation with R test results observed in GitHub Actions and the distinction from final Quarto render status.

## v1.0.1 — 2026-10-04

- Restored automated R verification and Quarto rendering through GitHub Actions.
- Replaced external affiliation and researcher-name references with independent research-computing documentation.
- Neutralised the first-page application-specific writing-sample subtitle without altering the research findings.
- Rebuilt the SHA-256 file manifest during the workflow run.

## v1.0.0 — 2026-10-04

- Constructed R-first quantitative analysis with ordered master wrapper.
- Extracted full 32-item Excel codebook using spreadsheet API.
- Preserved 103 × 32 respondent CSV without changing values.
- Added R tests against supplied S2-rounded SPSS results.
- Added Quarto narrative pages for results, methods and conceptual IRC.
- Included author writing sample as PDF; isolated source SPSS binaries in private companion.
- Added data provenance, privacy, interpretation and no-new-licence notes.
- Independent cross-language numerical audit completed; R/Quarto execution pending in R-enabled environment.
