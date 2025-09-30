cd "../.."          // go up two directories (from stata/ to project/)
cd "result"         // move into result/

ssc install kappaetc

// OXFORD

// inter-rater r1o1_r2o1

import delimited "inter_r1o1_r2o1_ox_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale 

// interrater_r1o1_r2o2

import delimited "inter_r1o1_r2o2_ox_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale 

// interrater_r1o2_r2o1

import delimited "inter_r1o2_r2o1_ox_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale 

// interrater_r1o2_r2o2

import delimited "inter_r1o2_r2o2_ox_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale 



// intra-rater1
import delimited "intra_r1_ox_eligible.csv", clear

label variable r1o1 "Occasion 1"
label variable r1o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1o1 includeexclude
label values r1o2 includeexclude

tab r1o1 r1o2

kappaetc r1o1 r1o2 , benchmark(probabilistic,scale(altman))showscale 

// intra-rater2
import delimited "intra_r2_ox_eligible.csv", clear

label variable r2o1 "Occasion 1"
label variable r2o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r2o1 includeexclude
label values r2o2 includeexclude

tab r2o1 r2o2

kappaetc r2o1 r2o2 , benchmark(probabilistic,scale(altman))showscale 



// EXETER

// inter-rater r1o1_r2o1

import delimited "inter_r1o1_r2o1_ex_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary

// interrater_r1o1_r2o2

import delimited "inter_r1o1_r2o2_ex_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

* kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary

// interrater_r1o2_r2o1

import delimited "inter_r1o2_r2o1_ex_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2

* kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary

// interrater_r1o2_r2o2

import delimited "inter_r1o2_r2o2_ex_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

* kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary



// intra-rater1
import delimited "intra_r1_ex_eligible.csv", clear

label variable r1o1 "Occasion 1"
label variable r1o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1o1 includeexclude
label values r1o2 includeexclude

tab r1o1 r1o2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

* kappaetc r1o1 r1o2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary

// intra-rater2
import delimited "intra_r2_ex_eligible.csv", clear

label variable r2o1 "Occasion 1"
label variable r2o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r2o1 includeexclude
label values r2o2 includeexclude

tab r2o1 r2o2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

* kappaetc r2o1 r2o2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary



// UCL

// inter-rater r1o1_r2o1

import delimited "inter_r1o1_r2o1_ucl_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale

// interrater_r1o1_r2o2

import delimited "inter_r1o1_r2o2_ucl_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale

// interrater_r1o2_r2o1

import delimited "inter_r1o2_r2o1_ucl_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale

// interrater_r1o2_r2o2

import delimited "inter_r1o2_r2o2_ucl_eligible.csv", clear

label variable r1 "Rater 1"
label variable r2 "Rater 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1 includeexclude
label values r2 includeexclude

tab r1 r2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

kappaetc r1 r2 , benchmark(probabilistic,scale(altman))showscale



// intra-rater1
import delimited "intra_r1_ucl_eligible.csv", clear

label variable r1o1 "Occasion 1"
label variable r1o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r1o1 includeexclude
label values r1o2 includeexclude

tab r1o1 r1o2 //STATA did not show categories with decisions equal to 0, so the figure in the thesis was created manually in excel spreadsheet

* kappaetc r1o1 r1o2 , benchmark(probabilistic,scale(altman))showscale //kappaetc command generated an error result because the ratings do not vary

// intra-rater2
import delimited "intra_r2_ucl_eligible.csv", clear

label variable r2o1 "Occasion 1"
label variable r2o2 "Occasion 2"

label define includeexclude 0 "Include" 1 "Exclude"
label values r2o1 includeexclude
label values r2o2 includeexclude

tab r2o1 r2o2

kappaetc r2o1 r2o2 , benchmark(probabilistic,scale(altman))showscale
