install.packages("DescTools")

library(metafor)
library(tidyverse)
library(DescTools)

df <- read.csv("nox_innoc_magdiff_3sites.csv")

# TYPICAL MAGNITUDES BY STIMULUS TYPES

## Create subgroups of dataset by stimulus types
### Tactile stimulus
tactile <- df[df$event=="Tactile stimulus", ]

### Control lance
cl <- df[df$event=="Control lance", ]
cl_ox <- cl[cl$sites=="Oxford", ]
cl_ex <- cl[cl$sites=="Exeter", ]
cl_ucl <- cl[cl$sites=="UCL", ]

### Immunisation
imm <- df[df$event=="Immunisation", ]

### Cannulation
cann <- df[df$event=="Cannulation", ]

### Heel lance
hl <- df[df$event=="Heel lance", ]
hl_ox <- hl[hl$sites=="Oxford", ]
hl_ex <- hl[hl$sites=="Exeter", ]
hl_ucl <- hl[hl$sites=="UCL", ]

### Magnitude difference heel lance-control lance
hlcl <- df[df$event=="Magdiff heel lance-control lance", ]
hlcl_ox <- hlcl[hlcl$sites=="Oxford", ]
hlcl_ex <- hlcl[hlcl$sites=="Exeter", ]
hlcl_ucl <- hlcl[hlcl$sites=="UCL", ]

## MEMA: for stimulus with data from multiple sites, analysis by site then by stimulus
### Within stimulus 
#### Tactile stimulus
tactile_mema <- rma.uni(yi=tactile$coef,vi=tactile$varcoef,
                      method="REML",test="knha")
sd_tactile_mema <- sqrt(tactile_mema$vb)

#### Control lance
cl_ox_mema <- rma.uni(yi=cl_ox$coef,vi=cl_ox$varcoef,
                   method="REML",test="knha")
cl_ex_mema <- rma.uni(yi=cl_ex$coef,vi=cl_ex$varcoef,
                      method="REML",test="knha")
cl_ucl_mema <- rma.uni(yi=cl_ucl$coef,vi=cl_ucl$varcoef,
                      method="REML",test="knha")
yi_cl <- c(cl_ox_mema$b, cl_ex_mema$b, cl_ucl_mema$b)
sei_cl <- c(cl_ox_mema$se, cl_ex_mema$se, cl_ucl_mema$se)
cl_mema <- rma.uni(yi=yi_cl,sei=sei_cl,
                   method="REML",test="knha")
sd_cl_mema <- sqrt(cl_mema$vb)

#### Immunisation
imm_mema <- rma.uni(yi=imm$coef,vi=imm$varcoef,
                    method="REML",test="knha")
sd_imm_mema <- sqrt(imm_mema$vb)

#### Cannulation
cann_mema <- rma.uni(yi=cann$coef,vi=cann$varcoef,
                     method="REML",test="knha")
sd_cann_mema <- sqrt(cann_mema$vb)

#### Heel lance
hl_ox_mema <- rma.uni(yi=hl_ox$coef,vi=hl_ox$varcoef,
                      method="REML",test="knha")
hl_ex_mema <- rma.uni(yi=hl_ex$coef,vi=hl_ex$varcoef,
                      method="REML",test="knha")
hl_ucl_mema <- rma.uni(yi=hl_ucl$coef,vi=hl_ucl$varcoef,
                       method="REML",test="knha")
yi_hl <- c(hl_ox_mema$b, hl_ex_mema$b, hl_ucl_mema$b)
sei_hl <- c(hl_ox_mema$se, hl_ex_mema$se, hl_ucl_mema$se)
hl_mema <- rma.uni(yi=yi_hl,sei=sei_hl,
                   method="REML",test="knha")
sd_hl_mema <- sqrt(hl_mema$vb)

#### Magnitude difference heel lance-control lance
hlcl_ox_mema <- rma.uni(yi=hlcl_ox$coef,vi=hlcl_ox$varcoef,
                      method="REML",test="knha")
hlcl_ex_mema <- rma.uni(yi=hlcl_ex$coef,vi=hlcl_ex$varcoef,
                      method="REML",test="knha")
hlcl_ucl_mema <- rma.uni(yi=hlcl_ucl$coef,vi=hlcl_ucl$varcoef,
                       method="REML",test="knha")
yi_hlcl <- c(hlcl_ox_mema$b, hlcl_ex_mema$b, hlcl_ucl_mema$b)
sei_hlcl <- c(hlcl_ox_mema$se, hlcl_ex_mema$se, hlcl_ucl_mema$se)
hlcl_mema <- rma.uni(yi=yi_hlcl,sei=sei_hlcl,
                   method="REML",test="knha")
sd_hlcl_mema <- sqrt(hlcl_mema$vb)

### Between stimulus 
yi_all <- c(tactile_mema$b,cl_mema$b,imm_mema$b,cann_mema$b,hl_mema$b,hlcl_mema$b)
sei_all <- c(tactile_mema$se,cl_mema$se,imm_mema$se,cann_mema$se,hl_mema$se,hlcl_mema$se)
ci_lb_all <- c(tactile_mema$ci.lb,cl_mema$ci.lb,imm_mema$ci.lb,cann_mema$ci.lb,
               hl_mema$ci.lb,hlcl_mema$ci.lb)
ci_ub_all <- c(tactile_mema$ci.ub,cl_mema$ci.ub,imm_mema$ci.ub,cann_mema$ci.ub,
               hl_mema$ci.ub,hlcl_mema$ci.ub)
label <- c("Tactile stimulus (n=159)","Control lance (n=414)","Immunisation (n=29)",
           "Cannulation (n=24)","Heel lance (n=402)",
           expression(Delta ~ "Heel lance-control lance (n=385)"))

forest(x=yi_all,ci.lb=ci_lb_all, ci.ub=ci_ub_all,header=c(" ","Magnitude [95% CI]"), 
       slab = label, alim=c(0,2.5), at=c(0,0.5,1,1.5),xlim=c(-5.8,4.7),cex=0.9)



# EFFECT SIZES

## MAGNITUDE DIFFERENCE HEEL LANCE-CONTROL LANCE
### UNWEIGHTED
coef_hlcl_ox <- hlcl_ox$coef
unweightedmean_hlcl_ox <- mean(coef_hlcl_ox)
unweightedsd_hlcl_ox <- sd(coef_hlcl_ox)

coef_hlcl_ex <- hlcl_ex$coef
unweightedmean_hlcl_ex <- mean(coef_hlcl_ex)
unweightedsd_hlcl_ex <- sd(coef_hlcl_ex)

coef_hlcl_ucl <- hlcl_ucl$coef
unweightedmean_hlcl_ucl <- mean(coef_hlcl_ucl)
unweightedsd_hlcl_ucl <- sd(coef_hlcl_ucl)

mean_hlcl_all <- c(unweightedmean_hlcl_ox,unweightedmean_hlcl_ex,unweightedmean_hlcl_ucl)
unweightedmean_hlcl_all <- mean(mean_hlcl_all)
sd_hlcl_all <- c(unweightedsd_hlcl_ox,unweightedsd_hlcl_ex,unweightedsd_hlcl_ucl)
unweightedsd_hlcl_all <- mean(sd_hlcl_all)
cohensd_unweighted_hlcl_all <- unweightedmean_hlcl_all/unweightedsd_hlcl_all 

### WEIGHTED
coef_hlcl_ox <- hlcl_ox$coef
weights_hlcl_ox <- hlcl_ox$inv_var
weightedmean_hlcl_ox <- weighted.mean(coef_hlcl_ox,weights_hlcl_ox)
weightedsd_hlcl_ox <- SD(coef_hlcl_ox,weights=weights_hlcl_ox)

coef_hlcl_ex <- hlcl_ex$coef
weights_hlcl_ex <- hlcl_ex$inv_var
weightedmean_hlcl_ex <- weighted.mean(coef_hlcl_ex,weights_hlcl_ex)
weightedsd_hlcl_ex <- SD(coef_hlcl_ex,weights=weights_hlcl_ex)

coef_hlcl_ucl <- hlcl_ucl$coef
weights_hlcl_ucl <- hlcl_ucl$inv_var
weightedmean_hlcl_ucl <- weighted.mean(coef_hlcl_ucl,weights_hlcl_ucl)
weightedsd_hlcl_ucl <- SD(coef_hlcl_ucl,weights=weights_hlcl_ucl)

mean_hlcl_all <- c(weightedmean_hlcl_ox,weightedmean_hlcl_ex,weightedmean_hlcl_ucl)
weightedmean_hlcl_all <- mean(mean_hlcl_all)
sd_hlcl_all <- c(weightedsd_hlcl_ox,weightedsd_hlcl_ex,weightedsd_hlcl_ucl)
weightedsd_hlcl_all <- mean(sd_hlcl_all)
cohensd_weighted_hlcl_all <- weightedmean_hlcl_all/weightedsd_hlcl_all 



## NOXIOUS
df_es <- read.csv("nox_innoc_3sites_withbg.csv")
nox <- subset(df_es, event %in% c("Immunisation", "Cannulation", "Heel lance"))

### UNWEIGHTED
#### Uncorrected
mean_nox_ox <- mean(nox_ox$coef)
sd_nox_ox <- sd(nox_ox$coef)

mean_nox_ex <- mean(nox_ex$coef)
sd_nox_ex <- sd(nox_ex$coef)

mean_nox_ucl <- mean(nox_ucl$coef)
sd_nox_ucl <- sd(nox_ucl$coef)

mean_nox_all <- c(mean_nox_ox,mean_nox_ex,mean_nox_ucl)
unweightedmean_nox_all <- mean(mean_nox_all)
sd_nox_all <- c(sd_nox_ox,sd_nox_ex,sd_nox_ucl)
unweightedsd_nox_all <- mean(sd_nox_all)

ucohensd_unweighted_nox_all <- unweightedmean_nox_all/unweightedsd_nox_all


#### Corrected
##### unweighted average of background magnitudes of noxious event
nox_ox<-nox[nox$sites=="Oxford", ]
mean_bg_nox_ox= mean(nox_ox$coef_bg)
nox$mean_bg[nox$sites == "Oxford"] = mean_bg_nox_ox

nox_ucl<-nox[nox$sites=="UCL", ]
mean_bg_nox_ucl= mean(nox_ucl$coef_bg)
nox$mean_bg[nox$sites == "UCL"] = mean_bg_nox_ucl

nox_ex<-nox[nox$sites=="Exeter", ]
mean_bg_nox_ex= mean(nox_ex$coef_bg)
nox$mean_bg[nox$sites == "Exeter"] = mean_bg_nox_ex

bgnox_allsites <- c(mean_bg_nox_ox,mean_bg_nox_ex,mean_bg_nox_ucl)
mean_bgnox_allsites <- mean(bgnox_allsites)

##### unweighted average of adjusted noxious magnitudes
nox$coef_adj_unweighted = nox$coef-nox$mean_bg

nox_ox<-nox[nox$sites=="Oxford", ]
coef_adj_nox_ox <- nox_ox$coef_adj_unweighted

mean_coefadj_nox_ox <- mean(coef_adj_nox_ox)
sd_nox_ox <- sd(nox_ox$coef)

nox_ucl<-nox[nox$sites=="UCL", ]
coef_adj_nox_ucl <- nox_ucl$coef_adj_unweighted

mean_coefadj_nox_ucl <- mean(coef_adj_nox_ucl)
sd_nox_ucl <- sd(nox_ucl$coef)

nox_ex<-nox[nox$sites=="Exeter", ]
coef_adj_nox_ex <- nox_ex$coef_adj_unweighted

mean_coefadj_nox_ex <- mean(coef_adj_nox_ex)
sd_nox_ex <- sd(nox_ex$coef)

coefadj_allsites <- c(mean_coefadj_nox_ox,mean_coefadj_nox_ucl,mean_coefadj_nox_ex)
mean_coefadj_allsites <- mean(coefadj_allsites)

sd_coefadj_allsites <- c(sd_nox_ox,sd_nox_ex,sd_nox_ucl)
mean_sd_coefadj_allsites <- mean(sd_coefadj_allsites)

##### unweighted corrected cohens d
corrected_cohensd_nox <- mean_coefadj_allsites/mean_sd_coefadj_allsites


### WEIGHTED
#### Uncorrected
nox_ox<-nox[nox$sites=="Oxford", ]
coef_nox_ox <- nox_ox$coef
weights_nox_ox <- nox_ox$inv_var

mean_coef_nox_ox <- weighted.mean(coef_nox_ox,weights_nox_ox)
weightedsd_nox_ox <- SD(coef_nox_ox,weights=weights_nox_ox)

nox_ucl<-nox[nox$sites=="UCL", ]
coef_nox_ucl <- nox_ucl$coef
weights_nox_ucl <- nox_ucl$inv_var

mean_coef_nox_ucl <- weighted.mean(coef_nox_ucl,weights_nox_ucl)
weightedsd_nox_ucl <- SD(coef_nox_ucl,weights=weights_nox_ucl)

nox_ex<-nox[nox$sites=="Exeter", ]
coef_nox_ex <- nox_ex$coef
weights_nox_ex <- nox_ex$inv_var

mean_coef_nox_ex <- weighted.mean(coef_nox_ex,weights_nox_ex)
weightedsd_nox_ex <- SD(coef_nox_ex,weights=weights_nox_ex)

weightedcoefnox_allsites <- c(mean_coef_nox_ox,mean_coef_nox_ucl,mean_coef_nox_ex)
mean_weightedcoefnox_allsites <- mean(weightedcoefnox_allsites)

weightedsd_coef_allsites <- c(weightedsd_nox_ox,weightedsd_nox_ucl,weightedsd_nox_ex)
mean_weightedsd_coef_allsites <- mean(weightedsd_coef_allsites)

ucohensd_weighted_nox_all <- mean_weightedcoefnox_allsites/mean_weightedsd_coef_allsites


#### Corrected

##### weighted average of background magnitudes of noxious event
nox_ox<-nox[nox$sites=="Oxford", ]
nox_ox$inv_var_bg = 1/nox_ox$varcoef_bg
coefbg_nox_ox <- nox_ox$coef_bg
weightsbg_nox_ox <- nox_ox$inv_var_bg
weightedmean_bgnox_ox <- weighted.mean(coefbg_nox_ox,weightsbg_nox_ox)
weightedsd_bgnox_ox <- SD(coefbg_nox_ox,weights=weightsbg_nox_ox)
nox$weightedmean_bg[nox$sites == "Oxford"] = weightedmean_bgnox_ox

nox_ucl<-nox[nox$sites=="UCL", ]
nox_ucl$inv_var_bg = 1/nox_ucl$varcoef_bg
coefbg_nox_ucl <- nox_ucl$coef_bg
weightsbg_nox_ucl <- nox_ucl$inv_var_bg
weightedmean_bgnox_ucl <- weighted.mean(coefbg_nox_ucl,weightsbg_nox_ucl)
weightedsd_bgnox_ucl <- SD(coefbg_nox_ucl,weights=weightsbg_nox_ucl)
nox$weightedmean_bg[nox$sites == "UCL"] = weightedmean_bgnox_ucl

nox_ex<-nox[nox$sites=="Exeter", ]
nox_ex$inv_var_bg = 1/nox_ex$varcoef_bg
coefbg_nox_ex <- nox_ex$coef_bg
weightsbg_nox_ex <- nox_ex$inv_var_bg
weightedmean_bgnox_ex <- weighted.mean(coefbg_nox_ex,weightsbg_nox_ex)
weightedsd_bgnox_ex <- SD(coefbg_nox_ex,weights=weightsbg_nox_ex)
nox$weightedmean_bg[nox$sites == "Exeter"] = weightedmean_bgnox_ex

weightedbgnox_allsites <- c(weightedsd_bgnox_ox,weightedsd_bgnox_ucl,weightedmean_bgnox_ex)
mean_weightedbgnox_allsites <- mean(weightedbgnox_allsites)

##### weighted mean of adjusted noxious magnitudes
nox$coef_adj_weighted = nox$coef-nox$weightedmean_bg

nox_ox<-nox[nox$sites=="Oxford", ]
coef_adj_weighted_nox_ox <- nox_ox$coef_adj_weighted
weights_nox_ox <- nox_ox$inv_var

weightedmean_coefadj_nox_ox <- weighted.mean(coef_adj_weighted_nox_ox,weights_nox_ox)
weightedsd_nox_ox <- SD(coef_adj_weighted_nox_ox,weights=weights_nox_ox)

nox_ucl<-nox[nox$sites=="UCL", ]
coef_adj_weighted_nox_ucl <- nox_ucl$coef_adj_weighted
weights_nox_ucl <- nox_ucl$inv_var

weightedmean_coefadj_nox_ucl <- weighted.mean(coef_adj_weighted_nox_ucl,weights_nox_ucl)
weightedsd_nox_ucl <- SD(coef_adj_weighted_nox_ucl,weights=weights_nox_ucl)

nox_ex<-nox[nox$sites=="Exeter", ]
coef_adj_weighted_nox_ex <- nox_ex$coef_adj_weighted
weights_nox_ex <- nox_ex$inv_var

weightedmean_coefadj_nox_ex <- weighted.mean(coef_adj_weighted_nox_ex,weights_nox_ex)
weightedsd_nox_ex <- SD(coef_adj_weighted_nox_ex,weights=weights_nox_ex)

weightedcoefadj_allsites <- c(weightedmean_coefadj_nox_ox,weightedmean_coefadj_nox_ucl,weightedmean_coefadj_nox_ex)
mean_weightedcoefadj_allsites <- mean(weightedcoefadj_allsites)

weightedsd_coefadj_allsites <- c(weightedsd_nox_ox,weightedsd_nox_ucl,weightedsd_nox_ex)
mean_weightedsd_coefadj_allsites <- mean(weightedsd_coefadj_allsites)

##### weighted corrected cohens d
corrected_cohensd_weighted_nox <- mean_weightedcoefadj_allsites/mean_weightedsd_coefadj_allsites


# INNOCUOUS
innoc <- subset(df_es, event %in% c("Tactile", "Control lance"))

### UNWEIGHTED
#### Uncorrected
mean_innoc_ox = mean(innoc$coef[innoc$sites == "Oxford"])
mean_innoc_ex = mean(innoc$coef[innoc$sites == "Exeter"])
mean_innoc_ucl = mean(innoc$coef[innoc$sites == "UCL"])
innoc_all <- c(mean_innoc_ox,mean_innoc_ex,mean_innoc_ucl)
mean_innoc <- mean(innoc_all)
ucohensd_innoc_unweighted = mean_innoc/mean_sdinnoc

#### Corrected

##### unweighted average of background magnitude of noxious events
mean_bg_innoc_ox= mean(innoc$coef_bg[innoc$sites == "Oxford"])
innoc$mean_bg[innoc$sites == "Oxford"] = mean_bg_innoc_ox

mean_bg_innoc_ucl= mean(innoc$coef_bg[innoc$sites == "UCL"])
innoc$mean_bg[innoc$sites == "UCL"] = mean_bg_innoc_ucl

mean_bg_innoc_ex= mean(innoc$coef_bg[innoc$sites == "Exeter"])
innoc$mean_bg[innoc$sites == "Exeter"] = mean_bg_innoc_ex

bginnoc_allsites <- c(mean_bg_innoc_ox,mean_bg_innoc_ex,mean_bg_innoc_ucl)
mean_bginnoc_allsites <- mean(bginnoc_allsites)

##### unweighted corrected cohens d
innoc$coef_adj_unweighted = innoc$coef-innoc$mean_bg

mean_innoc_ox = mean(innoc$coef_adj_unweighted[innoc$sites == "Oxford"])
mean_innoc_ex = mean(innoc$coef_adj_unweighted[innoc$sites == "Exeter"])
mean_innoc_ucl = mean(innoc$coef_adj_unweighted[innoc$sites == "UCL"])
innoc_all <- c(mean_innoc_ox,mean_innoc_ex,mean_innoc_ucl)
mean_innoc <- mean(innoc_all)

sd_innoc_ox = sd(innoc$coef[innoc$sites == "Oxford"])
sd_innoc_ex = sd(innoc$coef[innoc$sites == "Exeter"])
sd_innoc_ucl = sd(innoc$coef[innoc$sites == "UCL"])
sd_innoc_all <- c(sd_innoc_ox,sd_innoc_ex,sd_innoc_ucl)
mean_sdinnoc = mean(sd_innoc_all)

cohensd_innoc_unweighted = mean_innoc/mean_sdinnoc

### WEIGHTED
#### Uncorrected
##### weighted mean of unadjusted innocuous magnitudes
innoc_ox<-innoc[innoc$sites=="Oxford", ]
coef_innoc_ox <- innoc_ox$coef
weights_innoc_ox <- innoc_ox$inv_var

mean_coef_innoc_ox <- weighted.mean(coef_innoc_ox,weights_innoc_ox)
weightedsd_innoc_ox <- SD(coef_innoc_ox,weights=weights_innoc_ox)

innoc_ucl<-innoc[innoc$sites=="UCL", ]
coef_innoc_ucl <- innoc_ucl$coef
weights_innoc_ucl <- innoc_ucl$inv_var

mean_coef_innoc_ucl <- weighted.mean(coef_innoc_ucl,weights_innoc_ucl)
weightedsd_innoc_ucl <- SD(coef_innoc_ucl,weights=weights_innoc_ucl)

innoc_ex<-innoc[innoc$sites=="Exeter", ]
coef_innoc_ex <- innoc_ex$coef
weights_innoc_ex <- innoc_ex$inv_var

mean_coef_innoc_ex <- weighted.mean(coef_innoc_ex,weights_innoc_ex)
weightedsd_innoc_ex <- SD(coef_innoc_ex,weights=weights_innoc_ex)

weightedcoefinnoc_allsites <- c(mean_coef_innoc_ox,mean_coef_innoc_ucl,mean_coef_innoc_ex)
mean_weightedcoefinnoc_allsites <- mean(weightedcoefinnoc_allsites)

weightedsd_coef_allsites <- c(weightedsd_innoc_ox,weightedsd_innoc_ucl,weightedsd_innoc_ex)
mean_weightedsd_coef_allsites <- mean(weightedsd_coef_allsites)

##### weighted uncorrected cohens d
ucohensd_weighted_innoc_all <- mean_weightedcoefinnoc_allsites/mean_weightedsd_coef_allsites


#### Corrected

##### weighted average of background magnitudes of innoc event
innoc_ox<-innoc[innoc$sites=="Oxford", ]
innoc_ox$inv_var_bg = 1/innoc_ox$varcoef_bg
coefbg_innoc_ox <- innoc_ox$coef_bg
weightsbg_innoc_ox <- innoc_ox$inv_var_bg
weightedmean_bginnoc_ox <- weighted.mean(coefbg_innoc_ox,weightsbg_innoc_ox)
weightedsd_bginnoc_ox <- SD(coefbg_innoc_ox,weights=weightsbg_innoc_ox)
innoc$weightedmean_bg[innoc$sites == "Oxford"] = weightedmean_bginnoc_ox

innoc_ucl<-innoc[innoc$sites=="UCL", ]
innoc_ucl$inv_var_bg = 1/innoc_ucl$varcoef_bg
coefbg_innoc_ucl <- innoc_ucl$coef_bg
weightsbg_innoc_ucl <- innoc_ucl$inv_var_bg
weightedmean_bginnoc_ucl <- weighted.mean(coefbg_innoc_ucl,weightsbg_innoc_ucl)
weightedsd_bginnoc_ucl <- SD(coefbg_innoc_ucl,weights=weightsbg_innoc_ucl)
innoc$weightedmean_bg[innoc$sites == "UCL"] = weightedmean_bginnoc_ucl

innoc_ex<-innoc[innoc$sites=="Exeter", ]
innoc_ex$inv_var_bg = 1/innoc_ex$varcoef_bg
coefbg_innoc_ex <- innoc_ex$coef_bg
weightsbg_innoc_ex <- innoc_ex$inv_var_bg
weightedmean_bginnoc_ex <- weighted.mean(coefbg_innoc_ex,weightsbg_innoc_ex)
weightedsd_bginnoc_ex <- SD(coefbg_innoc_ex,weights=weightsbg_innoc_ex)
innoc$weightedmean_bg[innoc$sites == "Exeter"] = weightedmean_bginnoc_ex

weightedbginnoc_allsites <- c(weightedsd_bginnoc_ox,weightedsd_bginnoc_ucl,weightedmean_bginnoc_ex)
mean_weightedbginnoc_allsites <- mean(weightedbginnoc_allsites)

##### weighted mean of adjusted innocuous magnitudes
innoc$coef_adj_weighted = innoc$coef-innoc$weightedmean_bg

innoc_ox<-innoc[innoc$sites=="Oxford", ]
coef_adj_weighted_innoc_ox <- innoc_ox$coef_adj_weighted
weights_innoc_ox <- innoc_ox$inv_var

weightedmean_coefadj_innoc_ox <- weighted.mean(coef_adj_weighted_innoc_ox,weights_innoc_ox)
weightedsd_innoc_ox <- SD(coef_adj_weighted_innoc_ox,weights=weights_innoc_ox)

innoc_ucl<-innoc[innoc$sites=="UCL", ]
coef_adj_weighted_innoc_ucl <- innoc_ucl$coef_adj_weighted
weights_innoc_ucl <- innoc_ucl$inv_var

weightedmean_coefadj_innoc_ucl <- weighted.mean(coef_adj_weighted_innoc_ucl,weights_innoc_ucl)
weightedsd_innoc_ucl <- SD(coef_adj_weighted_innoc_ucl,weights=weights_innoc_ucl)

innoc_ex<-innoc[innoc$sites=="Exeter", ]
coef_adj_weighted_innoc_ex <- innoc_ex$coef_adj_weighted
weights_innoc_ex <- innoc_ex$inv_var

weightedmean_coefadj_innoc_ex <- weighted.mean(coef_adj_weighted_innoc_ex,weights_innoc_ex)
weightedsd_innoc_ex <- SD(coef_adj_weighted_innoc_ex,weights=weights_innoc_ex)

weightedcoefadj_allsites <- c(weightedmean_coefadj_innoc_ox,weightedmean_coefadj_innoc_ucl,weightedmean_coefadj_innoc_ex)
mean_weightedcoefadj_allsites <- mean(weightedcoefadj_allsites)

weightedsd_coefadj_allsites <- c(weightedsd_innoc_ox,weightedsd_innoc_ucl,weightedsd_innoc_ex)
mean_weightedsd_coefadj_allsites <- mean(weightedsd_coefadj_allsites)

##### weighted corrected cohens d
corrected_cohensd_weighted_innoc <- mean_weightedcoefadj_allsites/mean_weightedsd_coefadj_allsites



# HEEL LANCE
hl <- df_es[df_es$event == "Heel lance", ]

### UNWEIGHTED
#### Uncorrected
# Unweighted uncorrected cohens d, by averaged mean/averaged SD
mean_hl_ox = mean(hl$coef[hl$sites == "Oxford"])
mean_hl_ex = mean(hl$coef[hl$sites == "Exeter"])
mean_hl_ucl = mean(hl$coef[hl$sites == "UCL"])
hl_all <- c(mean_hl_ox,mean_hl_ex,mean_hl_ucl)
mean_hl <- mean(hl_all)
ucohensd_hl_unweighted = mean_hl/mean_sd_hl

#### Corrected

##### Unweighted average of background magnitudes of noxious events
mean_bg_hl_ox= mean(hl$coef_bg[hl$sites == "Oxford"])
hl$mean_bg[hl$sites == "Oxford"] = mean_bg_hl_ox

mean_bg_hl_ucl= mean(hl$coef_bg[hl$sites == "UCL"])
hl$mean_bg[hl$sites == "UCL"] = mean_bg_hl_ucl

mean_bg_hl_ex= mean(hl$coef_bg[hl$sites == "Exeter"])
hl$mean_bg[hl$sites == "Exeter"] = mean_bg_hl_ex

bghl_allsites <- c(mean_bg_hl_ox,mean_bg_hl_ex,mean_bg_hl_ucl)
mean_bghl_allsites <- mean(bghl_allsites)

hl$coef_adj_unweighted = hl$coef-hl$mean_bg

sd_hl_ox = sd(hl$coef[hl$sites == "Oxford"])
sd_hl_ex = sd(hl$coef[hl$sites == "Exeter"])
sd_hl_ucl = sd(hl$coef[hl$sites == "UCL"])
sd_hl_allsites <- c(sd_hl_ox,sd_hl_ucl,sd_hl_ex)
mean_sd_hl = mean(sd_hl_allsites)

##### Unweighted corrected cohens d, by averaged mean/averaged SD
mean_hl_ox = mean(hl$coef_adj_unweighted[hl$sites == "Oxford"])
mean_hl_ex = mean(hl$coef_adj_unweighted[hl$sites == "Exeter"])
mean_hl_ucl = mean(hl$coef_adj_unweighted[hl$sites == "UCL"])
hl_all <- c(mean_hl_ox,mean_hl_ex,mean_hl_ucl)
mean_hl <- mean(hl_all)
cohensd_hl_unweighted = mean_hl/mean_sd_hl


### WEIGHTED
#### Uncorrected
coef_hl_ox <- hl_ox$coef
weights_hl_ox <- hl_ox$inv_var
weightedmean_hl_ox <- weighted.mean(coef_hl_ox,weights_hl_ox)
weightedsd_hl_ox <- SD(coef_hl_ox,weights=weights_hl_ox)

coef_hl_ex <- hl_ex$coef
weights_hl_ex <- hl_ex$inv_var
weightedmean_hl_ex <- weighted.mean(coef_hl_ex,weights_hl_ex)
weightedsd_hl_ex <- SD(coef_hl_ex,weights=weights_hl_ex)

coef_hl_ucl <- hl_ucl$coef
weights_hl_ucl <- hl_ucl$inv_var
weightedmean_hl_ucl <- weighted.mean(coef_hl_ucl,weights_hl_ucl)
weightedsd_hl_ucl <- SD(coef_hl_ucl,weights=weights_hl_ucl)

mean_hl_all <- c(weightedmean_hl_ox,weightedmean_hl_ex,weightedmean_hl_ucl)
weightedmean_hl_all <- mean(mean_hl_all)
sd_hl_all <- c(weightedsd_hl_ox,weightedsd_hl_ex,weightedsd_hl_ucl)
weightedsd_hl_all <- mean(sd_hl_all)
ucohensd_weighted_hl_all <- weightedmean_hl_all/weightedsd_hl_all

#### Corrected
##### weighted average of background magnitudes of hl event
hl$inv_var_bg <- 1/hl$varcoef_bg
hl_ox<-hl[hl$sites=="Oxford", ]
coefbg_hl_ox <- hl_ox$coef_bg
weightsbg_hl_ox <- hl_ox$inv_var_bg
weightedmean_bghl_ox <- weighted.mean(coefbg_hl_ox,weightsbg_hl_ox)
weightedsd_bghl_ox <- SD(coefbg_hl_ox,weights=weightsbg_hl_ox)
hl$weightedmean_bg[hl$sites == "Oxford"] = weightedmean_bghl_ox

hl_ucl<-hl[hl$sites=="UCL", ]
coefbg_hl_ucl <- hl_ucl$coef_bg
weightsbg_hl_ucl <- hl_ucl$inv_var_bg
weightedmean_bghl_ucl <- weighted.mean(coefbg_hl_ucl,weightsbg_hl_ucl)
weightedsd_bghl_ucl <- SD(coefbg_hl_ucl,weights=weightsbg_hl_ucl)
hl$weightedmean_bg[hl$sites == "UCL"] = weightedmean_bghl_ucl

hl_ex<-hl[hl$sites=="Exeter", ]
coefbg_hl_ex <- hl_ex$coef_bg
weightsbg_hl_ex <- hl_ex$inv_var_bg
weightedmean_bghl_ex <- weighted.mean(coefbg_hl_ex,weightsbg_hl_ex)
weightedsd_bghl_ex <- SD(coefbg_hl_ex,weights=weightsbg_hl_ex)
hl$weightedmean_bg[hl$sites == "Exeter"] = weightedmean_bghl_ex

weightedbghl_allsites <- c(weightedsd_bghl_ox,weightedsd_bghl_ucl,weightedmean_bghl_ex)
mean_weightedbghl_allsites <- mean(weightedbghl_allsites)

##### weighted mean of adjusted hl magnitudes
hl$coef_adj_weighted = hl$coef-hl$weightedmean_bg

hl_ox<-hl[hl$sites=="Oxford", ]
coef_adj_weighted_hl_ox <- hl_ox$coef_adj_weighted
weights_hl_ox <- hl_ox$inv_var

weightedmean_coefadj_hl_ox <- weighted.mean(coef_adj_weighted_hl_ox,weights_hl_ox)
weightedsd_hl_ox <- SD(coef_adj_weighted_hl_ox,weights=weights_hl_ox)

hl_ucl<-hl[hl$sites=="UCL", ]
coef_adj_weighted_hl_ucl <- hl_ucl$coef_adj_weighted
weights_hl_ucl <- hl_ucl$inv_var

weightedmean_coefadj_hl_ucl <- weighted.mean(coef_adj_weighted_hl_ucl,weights_hl_ucl)
weightedsd_hl_ucl <- SD(coef_adj_weighted_hl_ucl,weights=weights_hl_ucl)

hl_ex<-hl[hl$sites=="Exeter", ]
coef_adj_weighted_hl_ex <- hl_ex$coef_adj_weighted
weights_hl_ex <- hl_ex$inv_var

weightedmean_coefadj_hl_ex <- weighted.mean(coef_adj_weighted_hl_ex,weights_hl_ex)
weightedsd_hl_ex <- SD(coef_adj_weighted_hl_ex,weights=weights_hl_ex)

weightedcoefadj_allsites <- c(weightedmean_coefadj_hl_ox,weightedmean_coefadj_hl_ucl,weightedmean_coefadj_hl_ex)
mean_weightedcoefadj_allsites <- mean(weightedcoefadj_allsites)

weightedsd_coefadj_allsites <- c(weightedsd_hl_ox,weightedsd_hl_ucl,weightedsd_hl_ex)
mean_weightedsd_coefadj_allsites <- mean(weightedsd_coefadj_allsites)

# weighted corrected cohens d
corrected_cohensd_weighted_hl <- mean_weightedcoefadj_allsites/mean_weightedsd_coefadj_allsites



# CANNULATION
cann <- df_es[df_es$event == "Cannulation", ]

### UNWEIGHTED
#### Uncorrected
coef_cann <- cann$coef
unweightedmean_cann <- mean(coef_cann)
unweightedsd_cann <- sd(coef_cann)
ucohensd_unweighted_cann <- unweightedmean_cann/unweightedsd_cann

#### Corrected
##### unweighted average of background magnitudes of cannulation event
mean_bg_cann = mean(cann$coef_bg)
cann$mean_bg = mean_bg_cann

cann$coef_adj_unweighted = cann$coef-cann$mean_bg
sd_cann = sd(cann$coef)

# corrected cohen's d unweighted
cohensd_unweighted_cann = mean(cann$coef_adj_unweighted)/sd_cann


### WEIGHTED
#### Uncorrected
##### unweighted mean and unweighted sd (data is only from a single site)
coef_cann <- cann$coef
weights_cann <- cann$inv_var
weightedmean_cann <- weighted.mean(coef_cann,weights_cann)
weightedsd_cann <- SD(coef_cann,weights=weights_cann)
ucohensd_weighted_cann <- weightedmean_cann/weightedsd_cann

#### Corrected
##### weighted average of background magnitudes of cannulation event
cann$inv_var_bg <- 1/cann$varcoef_bg
coefbg_cann <- cann$coef_bg
weightsbg_cann <- cann$inv_var_bg
weightedmean_bgcann <- weighted.mean(coefbg_cann,weightsbg_cann)
weightedsd_bgcann <- SD(coefbg_cann,weights=weightsbg_cann)
cann$weightedmean_bg = weightedmean_bgcann

cann$coef_adj_weighted = cann$coef - cann$weightedmean_bg
coef_adj_weighted_cann <- cann$coef_adj_weighted
weights_cann <- cann$inv_var
weightedmean_coefadj_cann <- weighted.mean(coef_adj_weighted_cann,weights_cann)
weightedsd_cann <- SD(coef_adj_weighted_cann,weights=weights_cann)

##### corrected cohen's d weighted
cohensd_weighted_cann = mean(weightedmean_coefadj_cann)/weightedsd_cann


# IMMUNISATION
imm <- df_es[df_es$event == "Immunisation", ]

### UNWEIGHTED
#### Uncorrected
##### unweighted mean and unweighted sd (data is only from a single site)
coef_imm <- imm$coef
unweightedmean_imm <- mean(coef_imm)
unweightedsd_imm <- sd(coef_imm)
ucohensd_unweighted_imm <- unweightedmean_imm/unweightedsd_imm

#### Corrected
##### unweighted average of background magnitudes of noxious events
mean_bg_imm= mean(imm$coef_bg)
imm$mean_bg = mean_bg_imm

imm$coef_adj_unweighted = imm$coef-imm$mean_bg
mean_imm = mean(imm$coef)
sd_imm = sd(imm$coef)

cohensd_imm = mean(imm$coef_adj_unweighted)/sd_imm

### WEIGHTED
#### Uncorrected
##### weighted mean and weighted sd (one-stage; data is only from a single site)
coef_imm <- imm$coef
weights_imm <- imm$inv_var
weightedmean_imm <- weighted.mean(coef_imm,weights_imm)
weightedsd_imm <- SD(coef_imm,weights=weights_imm)
ucohensd_weighted_imm <- weightedmean_imm/weightedsd_imm 

#### Corrected

##### weighted average of background magnitudes of immmunisation events 
imm$inv_var_bg <- 1/imm$varcoef_bg
coefbg_imm <- imm$coef_bg
weightsbg_imm <- imm$inv_var_bg
weightedmean_bgimm <- weighted.mean(coefbg_imm,weightsbg_imm)
weightedsd_bgimm <- SD(coefbg_imm,weights=weightsbg_imm)
imm$weightedmean_bg = weightedmean_bgimm

imm$coef_adj_weighted = imm$coef - imm$weightedmean_bg
coef_adj_weighted_imm <- imm$coef_adj_weighted
weights_imm <- imm$inv_var
weightedmean_coefadj_imm <- weighted.mean(coef_adj_weighted_imm,weights_imm)
weightedsd_imm <- SD(coef_adj_weighted_imm,weights=weights_imm)

##### corrected cohen's d weighted
cohensd_imm = mean(weightedmean_coefadj_imm)/weightedsd_imm



# CONTROL LANCE
cl <- df_es[df_es$event == "Control lance", ]

### UNWEIGHTED
#### Uncorrected
mean_cl_ox = mean(cl$coef[cl$sites == "Oxford"])
mean_cl_ex = mean(cl$coef[cl$sites == "Exeter"])
mean_cl_ucl = mean(cl$coef[cl$sites == "UCL"])
cl_all <- c(mean_cl_ox,mean_cl_ex,mean_cl_ucl)
mean_cl <- mean(cl_all)

sd_cl_ox = sd(cl$coef[cl$sites == "Oxford"])
sd_cl_ex = sd(cl$coef[cl$sites == "Exeter"])
sd_cl_ucl = sd(cl$coef[cl$sites == "UCL"])
sd_cl_allsites <- c(sd_cl_ox,sd_cl_ucl,sd_cl_ex)
mean_sd_cl = mean(sd_cl_allsites)

ucohensd_cl_unweighted = mean_cl/mean_sd_cl

#### Corrected
##### unweighted average of background magnitudes of noxious events
mean_bg_cl_ox= mean(cl$coef_bg[cl$sites == "Oxford"])
cl$mean_bg[cl$sites == "Oxford"] = mean_bg_cl_ox

mean_bg_cl_ucl= mean(cl$coef_bg[cl$sites == "UCL"])
cl$mean_bg[cl$sites == "UCL"] = mean_bg_cl_ucl

mean_bg_cl_ex= mean(cl$coef_bg[cl$sites == "Exeter"])
cl$mean_bg[cl$sites == "Exeter"] = mean_bg_cl_ex

bgcl_allsites <- c(mean_bg_cl_ox,mean_bg_cl_ex,mean_bg_cl_ucl)
mean_bgcl_allsites <- mean(bgcl_allsites)

##### unweighted corrected cohens d, by averaged mean/averaged SD
cl$coef_adj_unweighted = cl$coef - cl$mean_bg

mean_cl_ox = mean(cl$coef_adj_unweighted[cl$sites == "Oxford"])
mean_cl_ex = mean(cl$coef_adj_unweighted[cl$sites == "Exeter"])
mean_cl_ucl = mean(cl$coef_adj_unweighted[cl$sites == "UCL"])
cl_all <- c(mean_cl_ox,mean_cl_ex,mean_cl_ucl)
mean_cl <- mean(cl_all)
cohensd_cl_unweighted = mean_cl/mean_sd_cl

### WEIGHTED
#### Uncorrected
coef_cl_ox <- cl_ox$coef
weights_cl_ox <- cl_ox$inv_var
weightedmean_cl_ox <- weighted.mean(coef_cl_ox,weights_cl_ox)
weightedsd_cl_ox <- SD(coef_cl_ox,weights=weights_cl_ox)

coef_cl_ex <- cl_ex$coef
weights_cl_ex <- cl_ex$inv_var
weightedmean_cl_ex <- weighted.mean(coef_cl_ex,weights_cl_ex)
weightedsd_cl_ex <- SD(coef_cl_ex,weights=weights_cl_ex)

coef_cl_ucl <- cl_ucl$coef
weights_cl_ucl <- cl_ucl$inv_var
weightedmean_cl_ucl <- weighted.mean(coef_cl_ucl,weights_cl_ucl)
weightedsd_cl_ucl <- SD(coef_cl_ucl,weights=weights_cl_ucl)

mean_cl_all <- c(weightedmean_cl_ox,weightedmean_cl_ex,weightedmean_cl_ucl)
weightedmean_cl_all <- mean(mean_cl_all)
sd_cl_all <- c(weightedsd_cl_ox,weightedsd_cl_ex,weightedsd_cl_ucl)
weightedsd_cl_all <- mean(sd_cl_all)
ucohensd_weighted_cl_all <- weightedmean_cl_all/weightedsd_cl_all

#### Corrected
##### weighted average of background magnitudes of cl event
cl$inv_var_bg <- 1/cl$varcoef_bg
cl_ox<-cl[cl$sites=="Oxford", ]
coefbg_cl_ox <- cl_ox$coef_bg
weightsbg_cl_ox <- cl_ox$inv_var_bg
weightedmean_bgcl_ox <- weighted.mean(coefbg_cl_ox,weightsbg_cl_ox)
weightedsd_bgcl_ox <- SD(coefbg_cl_ox,weights=weightsbg_cl_ox)
cl$weightedmean_bg[cl$sites == "Oxford"] = weightedmean_bgcl_ox

cl_ucl<-cl[cl$sites=="UCL", ]
coefbg_cl_ucl <- cl_ucl$coef_bg
weightsbg_cl_ucl <- cl_ucl$inv_var_bg
weightedmean_bgcl_ucl <- weighted.mean(coefbg_cl_ucl,weightsbg_cl_ucl)
weightedsd_bgcl_ucl <- SD(coefbg_cl_ucl,weights=weightsbg_cl_ucl)
cl$weightedmean_bg[cl$sites == "UCL"] = weightedmean_bgcl_ucl

cl_ex<-cl[cl$sites=="Exeter", ]
coefbg_cl_ex <- cl_ex$coef_bg
weightsbg_cl_ex <- cl_ex$inv_var_bg
weightedmean_bgcl_ex <- weighted.mean(coefbg_cl_ex,weightsbg_cl_ex)
weightedsd_bgcl_ex <- SD(coefbg_cl_ex,weights=weightsbg_cl_ex)
cl$weightedmean_bg[cl$sites == "Exeter"] = weightedmean_bgcl_ex

weightedbgcl_allsites <- c(weightedsd_bgcl_ox,weightedsd_bgcl_ucl,weightedmean_bgcl_ex)
mean_weightedbgcl_allsites <- mean(weightedbgcl_allsites)

##### weighted mean of adjusted cl magnitudes
cl$coef_adj_weighted = cl$coef-cl$weightedmean_bg

cl_ox<-cl[cl$sites=="Oxford", ]
coef_adj_weighted_cl_ox <- cl_ox$coef_adj_weighted
weights_cl_ox <- cl_ox$inv_var

weightedmean_coefadj_cl_ox <- weighted.mean(coef_adj_weighted_cl_ox,weights_cl_ox)
weightedsd_cl_ox <- SD(coef_adj_weighted_cl_ox,weights=weights_cl_ox)

cl_ucl<-cl[cl$sites=="UCL", ]
coef_adj_weighted_cl_ucl <- cl_ucl$coef_adj_weighted
weights_cl_ucl <- cl_ucl$inv_var

weightedmean_coefadj_cl_ucl <- weighted.mean(coef_adj_weighted_cl_ucl,weights_cl_ucl)
weightedsd_cl_ucl <- SD(coef_adj_weighted_cl_ucl,weights=weights_cl_ucl)

cl_ex<-cl[cl$sites=="Exeter", ]
coef_adj_weighted_cl_ex <- cl_ex$coef_adj_weighted
weights_cl_ex <- cl_ex$inv_var

weightedmean_coefadj_cl_ex <- weighted.mean(coef_adj_weighted_cl_ex,weights_cl_ex)
weightedsd_cl_ex <- SD(coef_adj_weighted_cl_ex,weights=weights_cl_ex)

weightedcoefadj_allsites <- c(weightedmean_coefadj_cl_ox,weightedmean_coefadj_cl_ucl,weightedmean_coefadj_cl_ex)
mean_weightedcoefadj_allsites <- mean(weightedcoefadj_allsites)

weightedsd_coefadj_allsites <- c(weightedsd_cl_ox,weightedsd_cl_ucl,weightedsd_cl_ex)
mean_weightedsd_coefadj_allsites <- mean(weightedsd_coefadj_allsites)

##### weighted corrected cohens d
corrected_cohensd_weighted_cl <- mean_weightedcoefadj_allsites/mean_weightedsd_coefadj_allsites


# TACTILE
tf <- df_es[df_es$event == "Tactile stimulus", ]

### UNWEIGHTED
#### Uncorrected
mean_tf = mean(tf$coef)
sd_tf = sd(tf$coef)
ucohensd_tf = mean_tf/sd_tf

#### Corrected
##### unweighted average of background magnitudes of noxious event 
mean_bg_tf= mean(tf$coef_bg)
tf$mean_bg = mean_bg_tf

###### ucl: no data
###### exeter: only 1 so was not separately analysed

tf$coef_adj_unweighted = tf$coef-tf$mean_bg

##### unweighted corrected cohen's d
cohensd_tf = mean(tf$coef_adj_unweighted)/sd_tf


### WEIGHTED
#### Uncorrected
coef_tf <- tactile$coef
weights_tf <- tactile$inv_var
weightedmean_tf <- weighted.mean(coef_tf,weights_tf)
weightedsd_tf <- SD(coef_tf,weights=weights_tf)
ucohensd_weighted_tf <- weightedmean_tf/weightedsd_tf #uncorrected cohen's d, weighted

#### Corrected
##### weighted average of background magnitudes of immmunisation event 
tf$inv_var_bg <- 1/tf$varcoef_bg
coefbg_tf <- tf$coef_bg
weightsbg_tf <- tf$inv_var_bg
weightedmean_bgtf <- weighted.mean(coefbg_tf,weightsbg_tf)
weightedsd_bgtf <- SD(coefbg_tf,weights=weightsbg_tf)
tf$weightedmean_bg = weightedmean_bgtf

tf$coef_adj_weighted = tf$coef - tf$weightedmean_bg
coef_adj_weighted_tf <- tf$coef_adj_weighted
weights_tf <- tf$inv_var
weightedmean_coefadj_tf <- weighted.mean(coef_adj_weighted_tf,weights_tf)
weightedsd_tf <- SD(coef_adj_weighted_tf,weights=weights_tf)

##### corrected cohen's d weighted
cohensd_tf = mean(weightedmean_coefadj_tf)/weightedsd_tf
