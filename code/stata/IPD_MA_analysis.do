cd "../.."              // go up two directories (from stata/ to project/)
cd "result"            // move into result/

//oxford
import delimited "dataframe_ox_heellance", clear
rename (coef varcoef) (coef_hl varcoef_hl) 

save "heellance_NRFtable_ox.dta", replace

import delimited "dataframe_ox_controllance", clear
rename (coef varcoef) (coef_cl varcoef_cl)

save "controllance_NRFtable_ox.dta", replace

joinby file using "heellance_NRFtable_ox.dta"
keep file coef_hl varcoef_hl coef_cl varcoef_cl
order file coef_hl varcoef_hl coef_cl varcoef_cl

* create a new variable of magnitude difference between noxious and innocuous
gen mag_diff = coef_hl - coef_cl
export delimited hl_cl_NRFtable_ox.csv, replace

//exeter
import delimited "dataframe_ex_heellance", clear
rename (coef varcoef) (coef_hl varcoef_hl) 

save "heellance_NRFtable_ex.dta", replace

import delimited "dataframe_ex_controllance", clear
rename (coef varcoef) (coef_cl varcoef_cl)

save "controllance_NRFtable_ex.dta", replace

joinby file using "heellance_NRFtable_ex.dta"
keep file coef_hl varcoef_hl coef_cl varcoef_cl
order file coef_hl varcoef_hl coef_cl varcoef_cl

* create a new variable of magnitude difference between noxious and innocuous
gen mag_diff = coef_hl - coef_cl
export delimited hl_cl_NRFtable_ex.csv, replace

//ucl
import delimited "dataframe_ucl_heellance", clear
rename (coef varcoef) (coef_hl varcoef_hl) 

save "heellance_NRFtable_ucl.dta", replace

import delimited "dataframe_ucl_controllance", clear
rename (coef varcoef) (coef_cl varcoef_cl)

save "controllance_NRFtable_ucl.dta", replace

joinby setname using "heellance_NRFtable_ucl.dta"
keep file setname coef_hl varcoef_hl coef_cl varcoef_cl
order file setname coef_hl varcoef_hl coef_cl varcoef_cl

* create a new variable of magnitude difference between noxious and innocuous
gen mag_diff = coef_hl - coef_cl
export delimited hl_cl_NRFtable_ucl.csv, replace
	   