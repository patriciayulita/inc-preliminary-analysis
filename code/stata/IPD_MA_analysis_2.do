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



/// noxious

* Oxford
import delimited "dataframe_ox_nox.csv", clear

gen sites = "Oxford"

rename file setname

save "nox_ox.dta", replace

* Exeter
import delimited "dataframe_ex_heellance.csv", clear

gen sites = "Exeter"

rename file setname

save "nox_ex.dta", replace

* UCL
import delimited "dataframe_ucl_heellance.csv", clear

gen sites = "UCL"

drop file

tostring setname, replace 

save "nox_ucl.dta", replace

append using nox_ex nox_ox

replace event = subinstr(event,"hl","Heel lance",.)
replace event = subinstr(event,"cn","Cannulation",.)
replace event = subinstr(event,"imm","Immunisation",.)
replace event = subinstr(event,"lp","Lumbar puncture",.)

gen secoef = sqrt(varcoef)

label variable event "Stimulus types"

* drop lumbar puncture
drop if event =="Lumbar puncture"

save "nox_3sites", replace

*sort_event
gen study_id = .
replace study_id = 1 if event == "Cannulation"
replace study_id = 2 if event == "Immunisation"
replace study_id = 3 if event == "Heel lance"

label define event_lbl 1 "Cannulation" 2 "Immunisation" 3 "Heel lance", replace
label values study_id event_lbl

label variable study_id "Stimulus types"

*sort_sites
gen sites_id = .
replace sites_id = 1 if sites == "Exeter"
replace sites_id = 2 if sites == "Oxford"
replace sites_id = 3 if sites == "UCL"

label define sites_lbl 1 "Exeter" 2 "Oxford" 3 "UCL"
label values sites_id sites_lbl

label variable sites_id "Sites"

ipdmetan, study(sites_id) by(study_id, force) effect(Noxious magnitude) re(reml, hksj): mixed coef, reml

* save
graph export "nox_bysites_withinstims.png", replace


/// innocuous

* Oxford
import delimited "dataframe_ox_innoc.csv", clear

gen sites = "Oxford"

rename file setname

save "innoc_ox.dta", replace

* Exeter
import delimited "dataframe_ex_innoc.csv", clear

gen sites = "Exeter"

rename file setname

save "innoc_ex.dta", replace

* UCL
import delimited "dataframe_ucl_controllance.csv", clear

gen sites = "UCL"

drop file

tostring setname, replace 

save "innoc_ucl.dta", replace

append using innoc_ex innoc_ox

replace event = subinstr(event,"cl","Control lance",.)
replace event = subinstr(event,"tf","Tactile stimulus",.)

gen secoef = sqrt(varcoef)

save "innoc_3sites", replace

label variable event "Stimulus types"

*sort_event
gen study_id = .
replace study_id = 1 if event == "Tactile stimulus"
replace study_id = 2 if event == "Control lance"

label define event_lbl 1 "Tactile stimulus" 2 "Control lance"
label values study_id event_lbl

label variable study_id "Stimulus types"

*sort_sites
gen sites_id = .
replace sites_id = 1 if sites == "UCL"
replace sites_id = 2 if sites == "Exeter"
replace sites_id = 3 if sites == "Oxford"

label define sites_lbl 1 "UCL" 2 "Exeter" 3 "Oxford"
label values sites_id sites_lbl

label variable sites_id "Sites"

ipdmetan, study(sites_id) by(study_id, force) effect(Innocuous magnitude) re(reml, hksj): mixed coef, reml

* save
graph export "innoc_bysites_withinstims.png", replace


/// noxious and innocuous together

append using nox_3sites
gen inv_var = 1/varcoef
save nox_innoc_3sites, replace

import delimited "dataframe_ox_bg.csv", clear
gen sites = "Oxford"
save bg_ox, replace

import delimited "dataframe_ex_bg.csv", clear
gen sites = "Exeter"
save bg_ex, replace

import delimited "dataframe_ucl_bg.csv", clear
keep file epoch event coef varcoef
gen sites = "UCL"
tostring file, replace
save bg_ucl, replace


append using bg_ex
append using bg_ox
rename file setname
rename coef coef_bg
rename varcoef varcoef_bg
drop event
save bg_allsites, replace

*remove duplicates in background (only use the first epoch of each setname)
sort setname epoch
duplicates drop setname, force 
save bg_allsites_unique, replace

joinby setname using nox_innoc_3sites, unmatched(using)

* to save .dta into .csv
export delimited nox_innoc_3sites_withbg.csv, replace


use hl_cl_NRFtable_3sites, clear
gen event="Magdiff heel lance-control lance"
rename coef_mag_diff coef
rename var_diff varcoef
rename se_diff secoef
append using nox_innoc_3sites

*sort
replace study_id = 1 if event == "Touch"
replace study_id = 2 if event == "Control lance"
replace study_id = 3 if event == "Immunisation"
replace study_id = 4 if event == "Cannulation"
replace study_id = 5 if event == "Heel lance"
replace study_id = 6 if event == "Magdiff heel lance-control lance"

label define event_lbl 1 "Touch" 2 "Control lance" 3 "Immunisation" 4 "Cannulation" 5 "Heel lance" 6 "Difference between heel lance and control lance", modify

label values study_id event_lbl

label variable study_id "Stimulus type"

* save .dta
save nox_innoc_magdiff_3sites, replace

* to save .dta into .csv
export delimited nox_innoc_magdiff_3sites.csv, replace
