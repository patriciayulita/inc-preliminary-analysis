library(irrCAC)
library(psych)
library(metafor)
library(ggplot2)
library(gridExtra)

# note: there seems to be a bug in the gwet.ac1.raw command, 
# that is all standard error of 0 (no variation between responses) comes out as NaN. 
# CumProb of 1 also comes out as NaN. 

# Likewise, there seems to be a bug in the cohen.kappa command,
# that is all coefficient of 1 (100% agreement between responses) comes out as NA.
# CumProb of 1 also comes out as NaN.

col_extract <- c("r1","r2")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(file.path("..", "..", "data"))
id_exclude2 <- read.csv("pma_below34_reliability.csv")
id_ex <- id_exclude2[,1]

# inter_r1o1_r2o1

setwd(file.path("..", "result"))

raw_inter_r1o1_r2o1 <- read.csv("epoch_id_responses_interrater_r1o1_r2o1_ex.csv")
inter_r1o1_r2o1_in <-subset(raw_inter_r1o1_r2o1, ! (epoch %in% id_ex))
inter_r1o1_r2o1 <- inter_r1o1_r2o1_in[,col_extract]
write.csv(inter_r1o1_r2o1,"inter_r1o1_r2o1_ex_eligible.csv", row.names = FALSE)

# calculate gwet's ac1
ac1_inter_r1o1_r2o1 <- gwet.ac1.raw(inter_r1o1_r2o1)$est

# set-up for Altman function
ac1coeff_inter_r1o1_r2o1 <- ac1_inter_r1o1_r2o1$coeff.val
ac1coeff_inter_r1o1_r2o1[is.na(ac1coeff_inter_r1o1_r2o1)] <- 1 #replace all NA with 1

ac1se_inter_r1o1_r2o1 <- ac1_inter_r1o1_r2o1$coeff.se
ac1se_inter_r1o1_r2o1[is.nan(ac1se_inter_r1o1_r2o1)] <- 0 #replace all NaN with 0

gwet_inter_r1o1_r2o1_altman_ex <- altman.bf(ac1coeff_inter_r1o1_r2o1, ac1se_inter_r1o1_r2o1)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(inter_r1o1_r2o1)
ckappacoeff_inter_r1o1_r2o1 <- ckappa$kappa
ckappacoeff_inter_r1o1_r2o1[is.na(ckappacoeff_inter_r1o1_r2o1)] <- 1 #replace all NA with 1
ckappase_inter_r1o1_r2o1 <- sqrt(ckappa$var.kappa)

ckappa_inter_r1o1_r2o1_altman_ex <- altman.bf(ckappacoeff_inter_r1o1_r2o1, ckappase_inter_r1o1_r2o1)

# inter_r1o1_r2o2

raw_inter_r1o1_r2o2 <- read.csv("epoch_id_responses_interrater_r1o1_r2o2_ex.csv")
inter_r1o1_r2o2_in <-subset(raw_inter_r1o1_r2o2, ! (epoch %in% id_ex))
inter_r1o1_r2o2 <- inter_r1o1_r2o2_in[,col_extract]
write.csv(inter_r1o1_r2o2,"inter_r1o1_r2o2_ex_eligible.csv", row.names = FALSE)

ac1_inter_r1o1_r2o2 <- gwet.ac1.raw(inter_r1o1_r2o2)$est

# set-up for Altman function
ac1coeff_inter_r1o1_r2o2 <- ac1_inter_r1o1_r2o2$coeff.val
ac1se_inter_r1o1_r2o2 <- ac1_inter_r1o1_r2o2$coeff.se
ac1se_inter_r1o1_r2o2[is.nan(ac1se_inter_r1o1_r2o2)] <- 0 #replace all NaN with 0

gwet_inter_r1o1_r2o2_altman_ex <- altman.bf(ac1coeff_inter_r1o1_r2o2, ac1se_inter_r1o1_r2o2)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(inter_r1o1_r2o2)
ckappacoeff_inter_r1o1_r2o2 <- ckappa$kappa
ckappacoeff_inter_r1o1_r2o2[is.na(ckappacoeff_inter_r1o1_r2o2)] <- 1 #replace all NA with 1
ckappase_inter_r1o1_r2o2 <- sqrt(ckappa$var.kappa)

ckappa_inter_r1o1_r2o2_altman_ex <- altman.bf(ckappacoeff_inter_r1o1_r2o2, ckappase_inter_r1o1_r2o2)

# inter_r1o2_r2o1

raw_inter_r1o2_r2o1 <- read.csv("epoch_id_responses_interrater_r1o2_r2o1_ex.csv")
inter_r1o2_r2o1_in <-subset(raw_inter_r1o2_r2o1, ! (epoch %in% id_ex))
inter_r1o2_r2o1 <- inter_r1o2_r2o1_in[,col_extract]
write.csv(inter_r1o2_r2o1,"inter_r1o2_r2o1_ex_eligible.csv", row.names = FALSE)

ac1_inter_r1o2_r2o1 <- gwet.ac1.raw(inter_r1o2_r2o1)$est

# set-up for Altman function
ac1coeff_inter_r1o2_r2o1 <- ac1_inter_r1o2_r2o1$coeff.val
ac1se_inter_r1o2_r2o1 <- ac1_inter_r1o2_r2o1$coeff.se
ac1se_inter_r1o2_r2o1[is.nan(ac1se_inter_r1o2_r2o1)] <- 0 #replace all NaN with 0

gwet_inter_r1o2_r2o1_altman_ex <- altman.bf(ac1coeff_inter_r1o2_r2o1, ac1se_inter_r1o2_r2o1)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(inter_r1o2_r2o1)
ckappacoeff_inter_r1o2_r2o1 <- ckappa$kappa
ckappacoeff_inter_r1o2_r2o1[is.na(ckappacoeff_inter_r1o2_r2o1)] <- 1 #replace all NA with 1
ckappase_inter_r1o2_r2o1 <- sqrt(ckappa$var.kappa)

ckappa_inter_r1o2_r2o1_altman_ex <- altman.bf(ckappacoeff_inter_r1o2_r2o1, ckappase_inter_r1o2_r2o1)

# inter_r1o2_r2o2

raw_inter_r1o2_r2o2 <- read.csv("epoch_id_responses_interrater_r1o2_r2o2_ex.csv")
inter_r1o2_r2o2_in <-subset(raw_inter_r1o2_r2o2, ! (epoch %in% id_ex))
inter_r1o2_r2o2 <- inter_r1o2_r2o2_in[,col_extract]
write.csv(inter_r1o2_r2o2,"inter_r1o2_r2o2_ex_eligible.csv", row.names = FALSE)

ac1_inter_r1o2_r2o2 <- gwet.ac1.raw(inter_r1o2_r2o2)$est

# set-up for Altman function
ac1coeff_inter_r1o2_r2o2 <- ac1_inter_r1o2_r2o2$coeff.val
ac1se_inter_r1o2_r2o2 <- ac1_inter_r1o2_r2o2$coeff.se
ac1se_inter_r1o2_r2o2[is.nan(ac1se_inter_r1o2_r2o2)] <- 0 #replace all NaN with 0

gwet_inter_r1o2_r2o2_altman_ex <- altman.bf(ac1coeff_inter_r1o2_r2o2, ac1se_inter_r1o2_r2o2)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(inter_r1o2_r2o2)
ckappacoeff_inter_r1o2_r2o2 <- ckappa$kappa
ckappacoeff_inter_r1o2_r2o2[is.na(ckappacoeff_inter_r1o2_r2o2)] <- 1 #replace all NA with 1
ckappase_inter_r1o2_r2o2 <- sqrt(ckappa$var.kappa)

ckappa_inter_r1o2_r2o2_altman_ex <- altman.bf(ckappacoeff_inter_r1o2_r2o2, ckappase_inter_r1o2_r2o2)

# combine all the inter-rater Gwet's coefs and SEs
gwetcoef_inter_all <- c(ac1coeff_inter_r1o1_r2o1,ac1coeff_inter_r1o1_r2o2,ac1coeff_inter_r1o2_r2o1,ac1coeff_inter_r1o2_r2o2)
gwetse_inter_all <- c(ac1se_inter_r1o1_r2o1,ac1se_inter_r1o1_r2o2,ac1se_inter_r1o2_r2o1,ac1se_inter_r1o2_r2o2)

y <- gwetcoef_inter_all

# OLS Gwet's
inter_reliability_ex <- lm(y~1)
sum_inter_ex <- summary(inter_reliability_ex)

gwet_inter_coef_ex <- sum_inter_ex$coefficients[1, "Estimate"]
gwet_inter_se_ex <- mean(gwetse_inter_all)

inter_altman_ex <- altman.bf(gwet_inter_coef_ex, gwet_inter_se_ex)

# combine all the inter-rater Cohen's coefs and SEs (exploratory)
ckappacoef_inter_all <- c(ckappacoeff_inter_r1o1_r2o1,ckappacoeff_inter_r1o1_r2o2,ckappacoeff_inter_r1o2_r2o1,ckappacoeff_inter_r1o2_r2o2)
ckappase_inter_all <- c(ckappase_inter_r1o1_r2o1,ckappase_inter_r1o1_r2o2,ckappase_inter_r1o2_r2o1,ckappase_inter_r1o2_r2o2)

y <- ckappacoef_inter_all

# OLS Cohen's (exploratory)
inter_reliability_ex <- lm(y~1)
sum_inter_ex <- summary(inter_reliability_ex)

cohen_inter_coef_ex <- sum_inter_ex$coefficients[1, "Estimate"]
cohen_inter_se_ex <- mean(ckappase_inter_all)

inter_altman_ex <- altman.bf(cohen_inter_coef_ex, cohen_inter_se_ex)



# intra_rater1
raw_intra_r1 <- read.csv("epoch_id_responses_intrarater1_ex.csv")
intra_r1_in <-subset(raw_intra_r1, ! (epoch %in% id_ex))

col_extract_intra <- c("r1o1","r1o2")
intra_r1 <- intra_r1_in[,col_extract_intra]
write.csv(intra_r1,"intra_r1_ex_eligible.csv", row.names = FALSE)

ac1_intra_r1 <- gwet.ac1.raw(intra_r1)$est

# set-up for Altman function
ac1coeff_intra_r1 <- ac1_intra_r1$coeff.val
ac1se_intra_r1 <- ac1_intra_r1$coeff.se
ac1se_intra_r1[is.nan(ac1se_intra_r1)] <- 0 #replace all NaN with 0

gwet_intra_r1_altman_ex <- altman.bf(ac1coeff_intra_r1, ac1se_intra_r1)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(intra_r1)
ckappacoeff_intra_r1 <- ckappa$kappa
ckappacoeff_intra_r1[is.na(ckappacoeff_intra_r1)] <- 1 #replace all NA with 1
ckappase_intra_r1 <- sqrt(ckappa$var.kappa)

ckappa_intra_r1_altman_ex <- altman.bf(ckappacoeff_intra_r1, ckappase_intra_r1)

# intra_rater2

raw_intra_r2 <- read.csv("epoch_id_responses_intrarater2_ex.csv")
intra_r2_in <-subset(raw_intra_r2, ! (epoch %in% id_ex))

col_extract_intra <- c("r2o1","r2o2")
intra_r2 <- intra_r2_in[,col_extract_intra]
write.csv(intra_r2,"intra_r2_ex_eligible.csv", row.names = FALSE)

ac1_intra_r2 <- gwet.ac1.raw(intra_r2)$est

# set-up for Altman function
ac1coeff_intra_r2 <- ac1_intra_r2$coeff.val
ac1se_intra_r2 <- ac1_intra_r2$coeff.se
ac1se_intra_r2[is.nan(ac1se_intra_r2)] <- 0 #replace all NaN with 0

gwet_intra_r2_altman_ex <- altman.bf(ac1coeff_intra_r2, ac1se_intra_r2)

# calculate cohen's kappa (exploratory)
ckappa <- cohen.kappa(intra_r2)
ckappacoeff_intra_r2 <- ckappa$kappa
ckappacoeff_intra_r2[is.na(ckappacoeff_intra_r2)] <- 1 #replace all NA with 1
ckappase_intra_r2 <- sqrt(ckappa$var.kappa)

ckappa_intra_r2_altman_ex <- altman.bf(ckappacoeff_intra_r2, ckappase_intra_r2)

# combine all the intra-rater Gwet's coefs and SEs
gwetcoef_intra_all <- c(ac1coeff_intra_r1,ac1coeff_intra_r2)
gwetse_intra_all <- c(ac1se_intra_r1,ac1se_intra_r2)

y <- gwetcoef_intra_all

# OLS Gwet's
intra_reliability_ex <- lm(y~1)
sum_intra_ex <- summary(intra_reliability_ex)

gwet_intra_coef_ex <- sum_intra_ex$coefficients[1, "Estimate"]
gwet_intra_se_ex <- mean(gwetse_intra_all)

intra_altman_ex <- altman.bf(gwet_intra_coef_ex, gwet_intra_se_ex)

# combine all the intra-rater Cohen's coefs and SEs (exploratory)
ckappacoef_intra_all <- c(ckappacoeff_intra_r1,ckappacoeff_intra_r2)
ckappase_intra_all <- c(ckappase_intra_r1,ckappase_intra_r2)

y <- ckappacoef_intra_all

# OLS Cohen's (exploratory)
intra_reliability_ex <- lm(y~1)
sum_intra_ex <- summary(intra_reliability_ex)

cohen_intra_coef_ex <- sum_intra_ex$coefficients[1, "Estimate"]
cohen_intra_se_ex <- mean(ckappase_intra_all)

intra_altman_ex <- altman.bf(cohen_intra_coef_ex, cohen_intra_se_ex)
