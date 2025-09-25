cd "../.."              // go up two directories (from stata/ to project/)
cd "result"            // move into result/

* Oxford
import delimited "hl_cl_NRFtable_ox.csv", clear

gen sites = "Oxford"

rename file setname

save "hl_cl_NRFtable_ox.dta", replace

* Exeter
import delimited "hl_cl_NRFtable_ex.csv", clear

gen sites = "Exeter"

rename file setname

save "hl_cl_NRFtable_ex.dta", replace

* UCL
import delimited "hl_cl_NRFtable_ucl.csv", clear

gen sites = "UCL"

drop file

tostring setname, replace 

save "hl_cl_NRFtable_ucl.dta", replace

append using hl_cl_NRFtable_ex hl_cl_NRFtable_ox

gen var_diff = varcoef_hl + varcoef_cl
gen se_diff = sqrt(var_diff)
gen inv_var = 1/var_diff

save "hl_cl_NRFtable_3sites", replace
