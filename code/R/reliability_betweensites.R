library(irrCAC)
library(psych)
library(metafor)
library(gridExtra)

# run the code for each site (`reliability_ox`, `reliability_ex`, `reliability_ucl`) beforehand

# Inter-rater
## Gwet's
### combine all the Gwet's inter-rater coefs and SEs
gwetcoef_inter_all <- c(gwet_inter_coef_ox, gwet_inter_coef_ucl, gwet_inter_coef_ex)
gwetse_inter_all <- c(gwet_inter_se_ox, gwet_inter_se_ucl, gwet_inter_se_ex)

y <- gwetcoef_inter_all

### OLS
inter_reliability_avg_ols <- lm(y~1)
sum_inter_avg_ols <- summary(inter_reliability_avg_ols)

gwet_inter_coef_avg_ols <- sum_inter_avg_ols$coefficients[1, "Estimate"]
gwet_inter_se_avg_ols <- mean(gwetse_inter_all)

gwet_inter_altman_avg_ols <- altman.bf(gwet_inter_coef_avg_ols, gwet_inter_se_avg_ols)

### calculating 95% CI
gwet_inter_95ci <- confint(inter_reliability_avg_ols,'(Intercept)')

## Cohen's (exploratory)
### combine all the Cohen's inter-rater coefs and SEs
cohencoef_inter_all <- c(cohen_inter_coef_ox, cohen_inter_coef_ucl, cohen_inter_coef_ex)
cohense_inter_all <- c(cohen_inter_se_ox, cohen_inter_se_ucl, cohen_inter_se_ex)

y <- cohencoef_inter_all

### OLS
inter_reliability_avg_ols <- lm(y~1)
sum_inter_avg_ols <- summary(inter_reliability_avg_ols)

cohen_inter_coef_avg_ols <- sum_inter_avg_ols$coefficients[1, "Estimate"]
cohen_inter_se_avg_ols <- mean(cohense_inter_all)

cohen_inter_altman_avg_ols <- altman.bf(cohen_inter_coef_avg_ols, cohen_inter_se_avg_ols)

### calculating 95% CI
cohen_inter_95ci <- confint(inter_reliability_avg_ols,'(Intercept)')

# Intra-rater
## Gwet's
### combine all the intra-rater coefs and intra-rater SEs
gwetcoef_intra_all <- c(gwet_intra_coef_ox, gwet_intra_coef_ucl, gwet_intra_coef_ex)
gwetse_intra_all <- c(gwet_intra_se_ox, gwet_intra_se_ucl, gwet_intra_se_ex)
gwetse_intra_all[is.nan(gwetse_intra_all)] <- 0 #replace all NaN with 0, to convert it to numeric so can be averaged

y <- gwetcoef_intra_all

### OLS
intra_reliability_avg_ols <- lm(y~1)
sum_intra_avg_ols <- summary(intra_reliability_avg_ols)
gwet_intra_coef_avg_ols <- sum_intra_avg_ols$coefficients[1, "Estimate"]
gwet_intra_se_avg_ols <- mean(gwetse_intra_all)

intra_altman_avg_ols <- altman.bf(gwet_intra_coef_avg_ols, gwet_intra_se_avg_ols)

### calculating 95% CI
gwet_intra_95ci <- confint(intra_reliability_avg_ols,'(Intercept)')

## Cohen's (exploratory)
### combine all the Cohen's intra-rater coefs and SEs
cohencoef_intra_all <- c(cohen_intra_coef_ox, cohen_intra_coef_ucl, cohen_intra_coef_ex)
cohense_intra_all <- c(cohen_intra_se_ox, cohen_intra_se_ucl, cohen_intra_se_ex)

y <- cohencoef_intra_all

### OLS
intra_reliability_avg_ols <- lm(y~1)
sum_intra_avg_ols <- summary(intra_reliability_avg_ols)

cohen_intra_coef_avg_ols <- sum_intra_avg_ols$coefficients[1, "Estimate"]
cohen_intra_se_avg_ols <- mean(ckappase_intra_all)

cohen_intra_altman_avg_ols <- altman.bf(cohen_intra_coef_avg_ols, cohen_intra_se_avg_ols)

### calculating 95% CI
cohen_intra_95ci <- confint(intra_reliability_avg_ols,'(Intercept)')
