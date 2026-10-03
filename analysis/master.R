# Reproduce quantitative study with R, from repository root.
# Wrapper pattern inspired by transparent, ordered research replication repos.
if (!file.exists("data/raw/survey_responses.csv")) {
  stop("Run from the repository root: Rscript analysis/master.R", call. = FALSE)
}
for (file in c("analysis/01_validate.R", "analysis/02_reproduce.R",
               "analysis/03_sensitivity.R", "tests/run_tests.R")) {
  cat("\n=== ", file, " ===\n", sep = "")
  source(file, local = new.env(parent = globalenv()))
}
dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "outputs/session_info.txt")
cat("\nCompleted: quantitative scripts, figures, R tests, session information.\n")
