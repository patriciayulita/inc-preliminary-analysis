install.packages("metafor")
install.packages("tidyverse")

library(metafor)
library(tidyverse)

setwd(file.path("..", "..", "result"))

# averaging within sites --------------------------------------------
# Oxford----
hl_cl <- read.csv("hl_cl_NRFtable_ox.csv")

hl_cl <- hl_cl %>%
  mutate(varcoef_mag_diff = varcoef_hl + varcoef_cl)

# mixed, REML, knha
yi <- hl_cl$coef_mag_diff
vi <- hl_cl$varcoef_mag_diff

hl_cl_ox_reml <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ox_coefmag_reml <- hl_cl_ox_reml$beta[1]
ox_semag_reml <- hl_cl_ox_reml$se[1]

# Exeter----
hl_cl <- read.csv("hl_cl_NRFtable_ex.csv")

hl_cl <- hl_cl %>%
  mutate(varcoef_mag_diff = varcoef_hl + varcoef_cl)

# mixed REML, knha test
yi <- hl_cl$coef_mag_diff
vi <- hl_cl$varcoef_mag_diff

hl_cl_ex_reml <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ex_coefmag_reml <- hl_cl_ex_reml$beta[1]
ex_semag_reml <- hl_cl_ex_reml$se[1]

# UCL----
hl_cl <- read.csv("hl_cl_NRFtable_ucl.csv")

hl_cl <- hl_cl %>%
  mutate(varcoef_mag_diff = varcoef_hl + varcoef_cl)

y <- hl_cl$coef_mag_diff
w <- hl_cl$varcoef_mag_diff

# mixed REML, knha test
yi <- hl_cl$coef_mag_diff
vi <- hl_cl$varcoef_mag_diff

hl_cl_ucl_reml <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ucl_coefmag_reml <- hl_cl_ucl_reml$beta[1]
ucl_semag_reml <- hl_cl_ucl_reml$se[1]

## averaging between sites-------------------------------------------------
yi <- c(ox_coefmag_reml,ex_coefmag_reml,ucl_coefmag_reml)
sei <- c(ox_semag_reml,ex_semag_reml,ucl_semag_reml)
label <- c("Oxford (n=283)","Exeter (n=28)","UCL (n=74)")

res <- rma.uni(yi=yi,sei=sei,method="REML",test="knha")
mlabfun <- function(text, x) {
  list(bquote(paste(.(text),
                    " (",
                    .(fmtp2(x$QEp)), "; ",
                    I^2, " = ", .(fmtx(x$I2, digits=1)), "%, ",
                    tau^2, " = ", .(fmtx(x$tau2, digits=2)), ")")))}

forest(res, header=c("Sites","Mean magnitude difference [95% CI]"), 
       order="yi", slab = label, alim=c(-0.5,2.5), at=c(-0.5,0,0.5,1,1.5),xlim=c(-6,4.5),
       mlab=mlabfun("RE", res),cex=0.9)
