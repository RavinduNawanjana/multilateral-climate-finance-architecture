# Multilateral Climate Finance Architecture: Reproducible Research

**Institutional collaboration, blended finance, regulation and transparency in the Group of 77 and China**

*R + Quarto reproducible analysis of an MSc study | Ravindu Nawanjana*

> **Research status.** This is a reproducibility portfolio, not a claim of publication, independent verification, causal identification or institutional endorsement. The associated manuscript, *Practitioner perspectives on institutional collaboration and multilateral climate funds in the Group of 77 and China*, is **under revision at Climate and Development**. The manuscript itself is not redistributed in this public repository.

## Research question

How do institutional collaboration, blended finance deployment, policy and regulatory alignment, and transparency/accountability relate to practitioners' perceptions of the operational architecture of multilateral climate funds serving the G77 and China?

## Study at a glance

| Element | Documented basis |
| --- | --- |
| Design | Qualitatively led mixed-methods research |
| Survey | 103 specialist responses to 32 five-point Likert items |
| Constructs | IC (7 items), BFD (7), PRA (7), TAFU (7), CFA (4) |
| Interview material | Eight semi-structured interviews; transcripts and recordings **not publicly released** |
| Original quantitative analysis | IBM SPSS Statistics |
| Reproducible quantitative implementation | R with a Quarto research companion |
| Empirical estimand | Cross-sectional associations among **perception-based composite scores** |
| Theory | Institutional Reinforcement Cycle (IRC): **conceptual, not dynamically estimated** |

The R analysis computes sample descriptives, Cronbach's alpha, Pearson correlations, ordinary least squares regression with unstandardized and standardized slopes, diagnostics, and leave-one-respondent-out sensitivity. These are **reproductions and diagnostics, not new causal findings**. SPSS-reported values are held separately in an immutable benchmark table.

## Published-supplement comparison targets

The supplied S2 reports Pearson correlations with perceived architecture effectiveness of **0.409** (institutional collaboration), **0.214** (blended finance), **−0.005** (policy alignment) and **0.150** (transparency). The reported standardized multiple-regression coefficients are **0.390**, **0.121**, **0.024** and **0.145**, respectively; the reported model has **R² = 0.207**, adjusted R² **0.174**. These are **source-reported** numbers. The repository's `tests/run_tests.R` independently compares R results to those rounded targets. Reproduction is not confused with fitting the IRC's dynamic parameters.

## Start here

1. Install [R](https://www.r-project.org/) and [Quarto](https://quarto.org/). Optional: RStudio.
2. From the **repository root**, install the minimum package requirements:

   ```r
   install.packages(c("ggplot2", "knitr", "rmarkdown", "sandwich"))
   ```

3. Run the complete analysis and built-in statistical checks:

   ```bash
   Rscript analysis/master.R
   ```

4. Render the Quarto website and empirical companion:

   ```bash
   quarto render
   ```

Output tables and figures are regenerated from the uploaded anonymized CSV, not edited by hand. Quarto writes the rendered site to `_site/`. `analysis/master.R` produces `outputs/` and `figures/`. GitHub Actions installs dependencies, validates the required public reproducibility inputs, runs the statistical checks, renders Quarto, and attaches the generated site, aggregate tables, plots, R session information and a fresh SHA-256 manifest as a run artifact. The workflow has **read-only repository permissions** and never commits generated content.

**Verification status:** GitHub Actions runs the R statistical pipeline, benchmark checks and Quarto render in a clean environment. See [`docs/verification-status.md`](docs/verification-status.md) for the current validation record.

## Reproducibility architecture

This repository uses an ordered analysis wrapper, modular R functions, a documented codebook, frozen source-reported statistical benchmarks, automated reconciliation tests and Quarto research narratives. The workflow uses modular R functions, explicit input validation, fixed benchmark tables, automated checks and Quarto reporting. The design and its evidence boundaries are documented in [`docs/research-computing-provenance.md`](docs/research-computing-provenance.md).

## Material you can review

- [`empirical-analysis.qmd`](empirical-analysis.qmd): executed tables/figures and transparent explanations when rendered in an R environment.
- [`theory.qmd`](theory.qmd): the IRC formalisation, its mathematical interpretation and identification boundary.
- [`methods.qmd`](methods.qmd): design, measurement, limitations, ethics and reproducibility.
- [`data/metadata/item_codebook.csv`](data/metadata/item_codebook.csv): the full questionnaire/variable crosswalk.
- [`data/reference/spss_published_benchmarks.csv`](data/reference/spss_published_benchmarks.csv): frozen source-reported rounded coefficients for comparison.

## Repository map

```text
analysis/master.R                  Ordered run-all script
analysis/01_validate.R             Input contract and data integrity
analysis/02_reproduce.R            Reliability, correlation, OLS, diagnostics
analysis/03_sensitivity.R          Leave-one-out robustness; optional HC3
R/functions.R                      Reusable R computation and validation
R/plotting.R                       Original data-based ggplot figures
tests/run_tests.R                  Numeric reconciliation tests
empirical-analysis.qmd             Quarto reproduction narrative
methods.qmd                        Mixed-methods source boundaries
theory.qmd                         IRC conceptual specification
outputs/                            R-generated, ignored derived tables
figures/                            R-generated, ignored figures
data/raw/survey_responses.csv        Original survey CSV, unchanged
```

## Interpretation limits

- Self-reported, cross-sectional respondent perceptions do not identify effects of institutions on actual disbursements or GHG results.
- The study's **G77 and China** framing describes the respondent context; the 103-person sample should not be treated as representative of every member country or financial institution.
- The IRC equation is theoretical and its depreciation, multiplier and synergy parameters **were not estimated** from this dataset.
- SPSS output `.spv` and `.sav` are retained in a **separately packaged private evidence archive**, not silently discarded or recast as R-generated results.
- The associated study reports a qualitative coding summary, but transcripts are not provided and **cannot be independently re-analysed here**.
- The manuscript is intentionally not redistributed here; journal posting permissions and interview-quotation rights remain separate publication decisions.

## Attribution and rights

Research author: **Ravindu Nawanjana**. No MIT or other blanket software licence has been added. See [`RIGHTS_AND_PUBLICATION.md`](RIGHTS_AND_PUBLICATION.md), including the file-level licensing and publication notes. The repository does not claim endorsement by the journal, participating institutions or any other organisation.
