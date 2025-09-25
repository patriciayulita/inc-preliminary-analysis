library(metafor)
library(tidyverse)

# noxious ----------------------------------
# Oxford----
nox <- read.csv("dataframe_ox_nox.csv")

# drop lumbar puncture
nox <- nox[nox$Event !="lp", ]

# averaging within site: mixed, REML, knha
  yi <- nox$Coef
  vi <- nox$VarCoef
  
  nox_ox_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
  ox_coefmag_mema <- nox_ox_mema$beta[1]
  ox_semag_mema <- nox_ox_mema$se[1]

# Exeter----
nox <- read.csv("dataframe_ex_heellance.csv")

# averaging within site: mixed, REML, knha
yi <- nox$Coef
vi <- nox$VarCoef

nox_ex_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ex_coefmag_mema <- nox_ex_mema$beta[1]
ex_semag_mema <- nox_ex_mema$se[1]

# UCL----
nox <- read.csv("dataframe_ucl_heellance.csv")

# averaging within site: mixed, REML, knha
yi <- nox$Coef
vi <- nox$VarCoef

nox_ucl_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ucl_coefmag_mema <- nox_ucl_mema$beta[1]
ucl_semag_mema <- nox_ucl_mema$se[1]

## averaging between sites_MEMA_MEMA
yi <- c(ox_coefmag_mema,ex_coefmag_mema,ucl_coefmag_mema)
sei <- c(ox_semag_mema,ex_semag_mema,ucl_semag_mema)
label <- c("Oxford (n=341)","Exeter (n=28)","UCL (n=86)")

res <- rma.uni(yi=yi,sei=sei,method="REML",test="knha")
sd_nox <- sqrt(res$vb)

mlabfun <- function(text, x) {
  list(bquote(paste(.(text),
                    " (",
                    .(fmtp2(x$QEp)), "; ",
                    I^2, " = ", .(fmtx(x$I2, digits=1)), "%, ",
                    tau^2, " = ", .(fmtx(x$tau2, digits=2)), ")")))}

forest(res, header=c("Sites","Magnitude noxious [95% CI]"), 
       order="yi", slab = label, alim=c(0.5,2.5), at=c(0.5,1,1.5),xlim=c(-5.8,4.7),
       mlab=mlabfun("RE", res))



# innocuous ----------------------------------
# Oxford----
innoc_ox <- read.csv("dataframe_ox_innoc.csv")
innoc_ox$Sites <- "Oxford"
innoc_ox_tf <- innoc_ox[innoc_ox$Event=="tf", ]

# averaging within site: mixed, REML, knha
yi <- innoc_ox$Coef
vi <- innoc_ox$VarCoef

innoc_ox_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ox_coefinnoc_mema <- innoc_ox_mema$beta[1]
ox_seinnoc_mema <- innoc_ox_mema$se[1]

# Exeter----
innoc_ex <- read.csv("dataframe_ex_innoc.csv")
innoc_ex$Sites <- "Exeter"
innoc_ex_tf <- innoc_ex[innoc_ex$Event=="tf", ]

# averaging within site: mixed, REML, knha
yi <- innoc_ex$Coef
vi <- innoc_ex$VarCoef

innoc_ex_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ex_coefinnoc_mema <- innoc_ex_mema$beta[1]
ex_seinnoc_mema <- innoc_ex_mema$se[1]

# UCL----
innoc_ucl <- read.csv("dataframe_ucl_controllance.csv")
innoc_ucl$Sites <- "UCL"

# averaging within site: mixed, REML, knha
yi <- innoc_ucl$Coef
vi <- innoc_ucl$VarCoef

innoc_ucl_mema <- rma.uni(yi=yi,vi=vi,method="REML",test="knha")
ucl_coefinnoc_mema <- innoc_ucl_mema$beta[1]
ucl_seinnoc_mema <- innoc_ucl_mema$se[1]

## averaging between sites_MEMA_MEMA
yi <- c(ox_coefinnoc_mema,ex_coefinnoc_mema,ucl_coefinnoc_mema)
sei <- c(ox_seinnoc_mema,ex_seinnoc_mema,ucl_seinnoc_mema)
label <- c("Oxford (n=470)","Exeter (n=29)","UCL (n=74)")

res <- rma.uni(yi=yi,sei=sei,method="REML",test="knha")
sd_innoc <- sqrt(res$vb)

mlabfun <- function(text, x) {
  list(bquote(paste(.(text),
                    " (",
                    .(fmtp2(x$QEp)), "; ",
                    I^2, " = ", .(fmtx(x$I2, digits=1)), "%, ",
                    tau^2, " = ", .(fmtx(x$tau2, digits=2)), ")")))}

forest(res, header=c("Sites","Magnitude innocuous [95% CI]"), 
       slab = label, alim=c(-1,2), at=c(0,0.5,1),xlim=c(-9,6), 
       mlab=mlabfun("RE", res))
