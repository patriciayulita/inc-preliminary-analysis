cd "../.."          // go up two directories (from stata/ to project/)
cd "data"         // move into data/

import delimited "reliability_level1.csv", clear

gen model_mean = 1
gen weight = 1

label variable reliability_type "Reliability types"
label variable sites "Sites"
replace reliability_type = subinstr(reliability_type,"Inter-rater","raw_inter",.)
replace reliability_type = subinstr(reliability_type,"Intra-rater","raw_intra",.)
replace sites = subinstr(sites,"Oxford","raw_oxford",.)
replace sites = subinstr(sites,"UCL","raw_ucl",.)
replace sites = subinstr(sites,"Exeter","raw_exeter",.)
save "../result/reliability_level1.dta", replace

import delimited "reliability_level2.csv", clear

gen model_mean = 1
gen weight = 1

label variable reliability_type "Reliability types"
label variable sites "Sites"
replace reliability_type = subinstr(reliability_type,"Inter-rater","Inter-rater reliability",.)
replace reliability_type = subinstr(reliability_type,"Intra-rater","Intra-rater reliability",.)
save "../result/reliability_level2.dta", replace

* regress, plot
append using "../result/reliability_level1.dta"

regress ac1coef model_mean if reliability_type=="raw_inter" & sites=="raw_oxford"
est store m1
regress ac1coef model_mean if reliability_type=="raw_inter" & sites=="raw_ucl"
est store m2
regress ac1coef model_mean if reliability_type=="raw_inter" & sites=="raw_exeter"
est store m3
regress ac1coef model_mean if reliability_type=="Inter-rater reliability"
est store m4

regress ac1coef model_mean if reliability_type=="raw_intra" & sites=="raw_oxford"
est store f1
regress ac1coef model_mean if reliability_type=="raw_intra" & sites=="raw_ucl"
est store f2
regress ac1coef model_mean if reliability_type=="raw_intra" & sites=="raw_exeter"
est store f3
regress ac1coef model_mean if reliability_type=="Intra-rater reliability"
est store f4

	coefplot (m1, msymbol(O) mcolor(eltblue) ciopts(bcolor(none)) ) ///
         (m2, msymbol(O) mcolor(eltblue) ciopts(bcolor(none))) ///
         (m3, msymbol(O) mcolor(eltblue) ciopts(bcolor(none))) ///
         (m4, msymbol(D) mcolor(edkblue) ciopts(bcolor(blue))) ///
         (f1, msymbol(O) mcolor(eltblue) ciopts(bcolor(none))) ///
         (f2, msymbol(O) mcolor(eltblue) ciopts(bcolor(none))) ///
         (f3, msymbol(O) mcolor(eltblue) ciopts(bcolor(none))) ///
         (f4, msymbol(D) mcolor(edkblue) ciopts(bcolor(blue))), ///
    asequation swapnames legend(off) ///
    eqrename(m1="Inter-rater, Oxford" m2="Inter-rater, UCL" m3="Inter-rater, Exeter" m4="Average inter-rater reliability" ///
             f1="Intra-rater, Oxford" f2="Intra-rater, UCL" f3="Intra-rater, Exeter" f4="Average intra-rater reliability") ///
    xtitle("Gwet's AC1 [95% CI]") xline(0)

graph export "../result/Reliability_forestplot.png", replace


