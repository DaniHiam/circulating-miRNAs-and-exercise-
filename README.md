# Response of cell-free miRNAs to acute exercise: A systematic Review and Meta-Analysis

Code Files:
#### 1) Data Imputation_Github: Imputation of baseline SD if not available
#### 2) Meta Analysis_Loop_GitHub: Meta-analysis of each miRNA (include meta, heterogeneity checks, publication bias and diagnostics, Leave-one-out sensitivity analysis
#### 3) Meta Analysis_Moderator_GitHub: Exploratory/Meta-regression of moderators


## Detailed Methodology:
For each study, we computed the mean and standard deviation (SD) of the log fold-change (logFC) in miRNA expression, calculated via the delta-Ct method and expressed in arbitrary units, between the baseline and the relevant post-exercise timepoints. To retain as much data as possible, time points were sorted into windows based on the following timepoints post-acute exercise: 0HP, 1–2HP, 2–6HP, 6–24HP, > 24HP. Missing SD at baseline were imputed using k-nearest neighbours method implemented in the VIM package. We restricted analyses to miRNAs assessed in at least five studies per time window to minimise false-positive findings. Timepoints were not evenly spaced and therefore we undertook sensitivity analysis to determine best-fitting correlation structure using a decay function that reduces correlation with increasing time lag. The variance-covariance matrix used in the meta-analysis was constructed using the best-fitting correlation parameters (ρ=0.6, decay rate=0.2). This matrix encodes the within-cohort covariance structure accounting for the decaying correlation between effect sizes measured at different timepoints. We then compared four different random-effects structures to identify the best model for capturing study- and cohort-level variability in miRNA responses to exercise using the metafor package.
1.	Random Intercept Only: random = ~ 1 | Study_ID. 
2.	Nested cohort model: random = ~ 1 | Study_ID/cohort_id. 
3.	Random Slope Model (by Time) = ~ Timepoint | Study_ID. 
4.	Nested Cohorts + Random Time Slopes =~ 1 | Study_ID/cohort and ~Timepoint | Study_ID
The best fit model was based on the lowest AIC. This was followed by cluster-robust estimate using the “sandwich” estimator to account for any misspecification of the model. Statistical heterogeneity at each level of the meta-analysis was assessed via I2 which gives the proportion of total variability that is attributable to between-study heterogeneity rather than sampling error. Tau2 (τ²) estimated the variability between studies, and 95% prediction intervals (PIs) were reported to reflect the expected range of true effects in future individual studies.

Publication Bias and diagnostics: Publication bias was assessed visually via funnel plot asymmetry and tested using Egger’s regression was used to confirm the findings. Influential studies were identified through Cook’s distance and outliers detected with studentised deleted residuals.
Leave-One-Out and Sensitivity Analysis: Leave-One-Out (loo) and sensitivity analysis was conducted to assess the robustness of the meta-analysis findings.
Exploratory/Meta-regression: To explore sources of heterogeneity, we examined eight moderators related to methodology, exercise modality, sample size, and participant sex. A machine-learning random forest approach (metaForest) to minimise the risk of overfitting the model to identify key moderators. MetaForest models were built with 10,000 trees using random-effects weights clustered by cohort. Moderators with near-zero variance or low representation were excluded. Recursive variable selection via 100 bootstrap replications retained moderators selected in ≥50% of replications. Model convergence and predictive stability were assessed through 100 bootstrapped replications and R² distributions. 
