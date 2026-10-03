# How to compare against the original SPSS files

The separately supplied private archive preserves:

- the SPSS binary viewer output (`Climate_Finance_Architecture_SPSS_Output.spv`);
- the input SPSS dataset (`Climate_Finance_Architecture_Survey_Data.sav`);
- the original questionnaire workbook and source notes;
- the editable author writing sample and two source PDF supplements.

To compare, open the `.spv` in IBM SPSS Statistics/Viewer, identify the **four-predictor regression with the composite CFA dependent variable**, and check the standardized coefficients, Pearson r, model R² and sample size. Compare **model definitions and transformations first**, not just rounded output values.

The public R repository intentionally does **not** claim to reproduce all exploratory SPSS output: factor-analysis extraction/rotation details, marker-variable common-method analysis and bootstrap sampling settings require the original precise SPSS procedures for equivalence. SPSS viewer output alone is not executable syntax.
