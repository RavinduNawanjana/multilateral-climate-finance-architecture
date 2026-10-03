# Source inspirations, attribution and implementation boundaries

The author supplied four research-code archives as **exemplars of practice**, not data sources for this project. The repo implements original R code for the MSc dataset.

| Supplied reference | What it actually demonstrates | Practice adopted here |
| --- | --- | --- |
| `wns_and_conservation_finance-main.zip` | `master_script.R` executes research scripts for paper figures and supplementary materials in an explicit order. Its README identifies Nakhmurina, Manning and Fenichel and describes reproducibility. | One ordered `analysis/master.R`, research-output traceability, paper-specific tables and plots. |
| `pooled-saliva-testing-master.zip` | `paper_wrapper.R` connects statistical code to analysis and figure outputs; README describes the paper-replication role. | Top-level wrapper, separate computation and plotting, deterministic outputs. |
| `capn_stuff-master.zip` | R/R Markdown computational exercises and groundwater applications; README distinguishes teaching exercises and sources. | Literate research narrative, inspectable functions, no opaque spreadsheet-only reporting. |
| `AMES-master.zip` | R Markdown and project workflow exercises; example `ps1.Rmd`. | Quarto exposition, organized code and reproducible documentation. |

**No reference repository code, figures, datasets, exercises or writing have been transplanted into this package.** The source archives are not bundled. Their attribution is included solely to document research-computing design influences. This repository does not imply collaboration or endorsement.
