cd "../.."          // go up two directories (from stata/ to project/)
cd "data"         // move into data/

// unique participants (demographics across sites)
import delimited "interpretability_database.csv", clear

//Shapiro-Wilk W test for data normality
//interpretation: p<0.05 = unlikely to come from normal distribution
by sites, sort: swilk ga_wk pma_wk 

kwallis ga_wk, by(sites)
kwallis pma_wk, by(sites) 
//chi-square with ties is for ordinal data. standard chi-square is for non-ordinal data. thus, in this case, standard chi-square should be used for interpretation.

by sites, sort: sum(ga_wk), detail //summary for each site
sum(ga_wk), detail //summary for all sites
by sites, sort: sum(pma_wk), detail //summary for each site
sum(pma_wk), detail //summary for all sites

tabulate sex sites, expected
tabulate sex sites, chi2

by sites, sort: tab sex
tab sex


// participants of all events (demographics across stimulus types)
import delimited "interpretability_database_allEvents.csv", clear

drop if event == "Magdiff heel lance-control lance"

by event, sort: count

//Shapiro-Wilk W test for data normality
//interpretation: p<0.05 = unlikely to come from normal distribution
by event, sort: swilk ga_wk pma_wk

kwallis ga_wk, by(event)
kwallis pma_wk, by(event)
//chi-square with ties is for ordinal data. standard chi-square is for non-ordinal data. thus, in this case, standard chi-square should be used for interpretation.

tabulate sex event, expected
tabulate sex event, chi2

by event, sort: sum ga_wk, detail
by event, sort: sum pma_wk, detail
by event, sort: tab sex
