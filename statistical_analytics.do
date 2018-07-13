** capstone do file data analysis_spring semester

clear all
prog drop _all
capture log close
set more off

global datadir "C:\Users\hw1220\Desktop\codes"
global logdir "C:\Users\hw1220\Desktop\codes"

use "${datadir}\in_use.dta", clear
log using "${logdir}\capstone_log_file_may01.smcl", replace

drop if year==1987 | year==1988 | year==2014
drop treat_post treat2_post treat3_post m_ast ngo1 ngo2 ngo3 ngo4
rename ntee nteefinal
drop fips
drop outnccs
drop outreas
drop subseccd 
drop ntmaj5 ntmaj10 ntmaj12
drop doccd coresrc

drop if exps<0
drop if totrev<0
drop if ass_boy<0
drop if ass_eoy<0
drop if liab_boy<0
drop if liab_eoy<0

* sort exps
drop if ein==941340523
drop if ein==136022042
drop if ein==941105628
drop if ein==131624203
drop if ein==132655001

* plot
twoway scatter exps_cpi year

sum exps, d
gen keep = inrange(exps, `r(p5)', `r(p95)')
sum exps if keep

* xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi i.level4 i.year, r
* xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi i.level4 i.year if year<=2000 & year>=1994, r

* recode year into continuous variables
gen year2=0 if year<=1997
replace year2 = year-1997 if year>1997

* create post97
gen post97=0
replace post97=1 if year>1997

* year into continuous variable 1, 2, 3...
gen year3=year-1988

* tech sector
gen tech=0
replace tech=1 if nteefinal=="A02"
replace tech=1 if nteefinal=="A57"
replace tech=1 if nteefinal=="B02"
replace tech=1 if nteefinal=="B30"
replace tech=1 if nteefinal=="C02"
replace tech=1 if nteefinal=="D02"
replace tech=1 if nteefinal=="E02"
replace tech=1 if nteefinal=="F02"
replace tech=1 if nteefinal=="G02"
replace tech=1 if nteefinal=="H02"
replace tech=1 if nteefinal=="I02"
replace tech=1 if nteefinal=="J02"
replace tech=1 if nteefinal=="K02"
replace tech=1 if nteefinal=="L02"
replace tech=1 if nteefinal=="N02"
replace tech=1 if nteefinal=="O02"
replace tech=1 if nteefinal=="P02"
replace tech=1 if nteefinal=="R02"
replace tech=1 if nteefinal=="S02"
replace tech=1 if nteefinal=="U02"
replace tech=1 if nteefinal=="U40"
replace tech=1 if nteefinal=="U42"
replace tech=1 if nteefinal=="U99"
replace tech=1 if nteefinal=="V02"
replace tech=1 if nteefinal=="W02"
replace tech=1 if nteefinal=="Y02"
replace tech=1 if nteefinal=="M02"
replace tech=1 if nteefinal=="Q02"
replace tech=1 if nteefinal=="Q36"

save "${datadir}\in_use.dta", replace

/* sort ein fisyr
drop id

codebook nteefinal fisyr
rename fisyr year

label variable cont "total contributions"
label variable fundinc "net income from special events and activities"
label variable totrev "total revenue"
label variable exps "total expense"
label variable year "fiscal year"
label variable netinc "net income"
label variable fundbal "net assets EOY"
label variable ass_eoy "total assets EOY"
label variable liab_eoy "total liability EOY"

* original version
gen treat=0
replace treat=1 if nteefinal=="A02"
replace treat=1 if nteefinal=="A23"
replace treat=1 if nteefinal=="A30"
replace treat=1 if nteefinal=="A31"
replace treat=1 if nteefinal=="A32"
replace treat=1 if nteefinal=="A40"
replace treat=1 if nteefinal=="A56"
replace treat=1 if nteefinal=="A57"
replace treat=1 if nteefinal=="B02"
replace treat=1 if nteefinal=="B20"
replace treat=1 if nteefinal=="B21"
replace treat=1 if nteefinal=="B25"
replace treat=1 if nteefinal=="B28"
replace treat=1 if nteefinal=="B29"
replace treat=1 if nteefinal=="B60"
replace treat=1 if nteefinal=="B80"
replace treat=1 if nteefinal=="B90"
replace treat=1 if nteefinal=="B92"
replace treat=1 if nteefinal=="C02"
replace treat=1 if nteefinal=="C03"
replace treat=1 if nteefinal=="C11"
replace treat=1 if nteefinal=="C30"
replace treat=1 if nteefinal=="C32"
replace treat=1 if nteefinal=="C34"
replace treat=1 if nteefinal=="C35"
replace treat=1 if nteefinal=="C36"
replace treat=1 if nteefinal=="D02"
replace treat=1 if nteefinal=="D30"
replace treat=1 if nteefinal=="D32"
replace treat=1 if nteefinal=="D33"
replace treat=1 if nteefinal=="D34"
replace treat=1 if nteefinal=="E02"
replace treat=1 if nteefinal=="E20"
replace treat=1 if nteefinal=="E21"
replace treat=1 if nteefinal=="E24"
replace treat=1 if nteefinal=="E30"
replace treat=1 if nteefinal=="E32"
replace treat=1 if nteefinal=="E40"
replace treat=1 if nteefinal=="E50"
replace treat=1 if nteefinal=="E70"
replace treat=1 if nteefinal=="E86"
replace treat=1 if nteefinal=="E90"
replace treat=1 if nteefinal=="E91"
replace treat=1 if nteefinal=="F02"
replace treat=1 if nteefinal=="F20"
replace treat=1 if nteefinal=="F21"
replace treat=1 if nteefinal=="F22"
replace treat=1 if nteefinal=="F33"
replace treat=1 if nteefinal=="F40"
replace treat=1 if nteefinal=="F52"
replace treat=1 if nteefinal=="G02"
replace treat=1 if nteefinal=="G40"
replace treat=1 if nteefinal=="G41"
replace treat=1 if nteefinal=="G42"
replace treat=1 if nteefinal=="G43"
replace treat=1 if nteefinal=="G45"
replace treat=1 if nteefinal=="G48"
replace treat=1 if nteefinal=="G50"
replace treat=1 if nteefinal=="G70"
replace treat=1 if nteefinal=="G80"
replace treat=1 if nteefinal=="G81"
replace treat=1 if nteefinal=="G90"
replace treat=1 if nteefinal=="G92"
replace treat=1 if nteefinal=="G98"
replace treat=1 if nteefinal=="H02"
replace treat=1 if nteefinal=="H40"
replace treat=1 if nteefinal=="H41"
replace treat=1 if nteefinal=="H42"
replace treat=1 if nteefinal=="H45"
replace treat=1 if nteefinal=="H50"
replace treat=1 if nteefinal=="H70"
replace treat=1 if nteefinal=="H80"
replace treat=1 if nteefinal=="H81"
replace treat=1 if nteefinal=="H89"
replace treat=1 if nteefinal=="I31"
replace treat=1 if nteefinal=="I40"
replace treat=1 if nteefinal=="I70"
replace treat=1 if nteefinal=="I72"
replace treat=1 if nteefinal=="J02"
replace treat=1 if nteefinal=="J21"
replace treat=1 if nteefinal=="J22"
replace treat=1 if nteefinal=="J30"
replace treat=1 if nteefinal=="J33"
replace treat=1 if nteefinal=="K02"
replace treat=1 if nteefinal=="K20"
replace treat=1 if nteefinal=="K26"
replace treat=1 if nteefinal=="K30"
replace treat=1 if nteefinal=="K35"
replace treat=1 if nteefinal=="K36"
replace treat=1 if nteefinal=="K40"
replace treat=1 if nteefinal=="L20"
replace treat=1 if nteefinal=="L21"
replace treat=1 if nteefinal=="L22"
replace treat=1 if nteefinal=="L30"
replace treat=1 if nteefinal=="L40"
replace treat=1 if nteefinal=="L50"
replace treat=1 if nteefinal=="L80"
replace treat=1 if nteefinal=="L81"
replace treat=1 if nteefinal=="L82"
replace treat=1 if nteefinal=="M02"
replace treat=1 if nteefinal=="M20"
replace treat=1 if nteefinal=="M40"
replace treat=1 if nteefinal=="M42"
replace treat=1 if nteefinal=="M60"
replace treat=1 if nteefinal=="N02"
replace treat=1 if nteefinal=="N50"
replace treat=1 if nteefinal=="N63"
replace treat=1 if nteefinal=="N64"
replace treat=1 if nteefinal=="N65"
replace treat=1 if nteefinal=="N66"
replace treat=1 if nteefinal=="N67"
replace treat=1 if nteefinal=="N68"
replace treat=1 if nteefinal=="N69"
replace treat=1 if nteefinal=="N71"
replace treat=1 if nteefinal=="N72"
replace treat=1 if nteefinal=="N80"
replace treat=1 if nteefinal=="O02"
replace treat=1 if nteefinal=="O03"
replace treat=1 if nteefinal=="O05"
replace treat=1 if nteefinal=="O11"
replace treat=1 if nteefinal=="O19"
replace treat=1 if nteefinal=="O20"
replace treat=1 if nteefinal=="O30"
replace treat=1 if nteefinal=="O40"
replace treat=1 if nteefinal=="O50"
replace treat=1 if nteefinal=="O52"
replace treat=1 if nteefinal=="O53"
replace treat=1 if nteefinal=="O54"
replace treat=1 if nteefinal=="O55"
replace treat=1 if nteefinal=="P02"
replace treat=1 if nteefinal=="P03"
replace treat=1 if nteefinal=="P05"
replace treat=1 if nteefinal=="P11"
replace treat=1 if nteefinal=="P19"
replace treat=1 if nteefinal=="P30"
replace treat=1 if nteefinal=="P31"
replace treat=1 if nteefinal=="P33"
replace treat=1 if nteefinal=="P40"
replace treat=1 if nteefinal=="P50"
replace treat=1 if nteefinal=="P51"
replace treat=1 if nteefinal=="P52"
replace treat=1 if nteefinal=="P60"
replace treat=1 if nteefinal=="P70"
replace treat=1 if nteefinal=="P71"
replace treat=1 if nteefinal=="P73"
replace treat=1 if nteefinal=="P74"
replace treat=1 if nteefinal=="P75"
replace treat=1 if nteefinal=="P80"
replace treat=1 if nteefinal=="P84"
replace treat=1 if nteefinal=="P88"
replace treat=1 if nteefinal=="P99"
replace treat=1 if nteefinal=="Q01"
replace treat=1 if nteefinal=="Q02"
replace treat=1 if nteefinal=="Q03"
replace treat=1 if nteefinal=="Q05"
replace treat=1 if nteefinal=="Q12"
replace treat=1 if nteefinal=="Q19"
replace treat=1 if nteefinal=="Q20"
replace treat=1 if nteefinal=="Q21"
replace treat=1 if nteefinal=="Q22"
replace treat=1 if nteefinal=="Q30"
replace treat=1 if nteefinal=="Q31"
replace treat=1 if nteefinal=="Q32"
replace treat=1 if nteefinal=="Q33"
replace treat=1 if nteefinal=="Q34"
replace treat=1 if nteefinal=="Q35"
replace treat=1 if nteefinal=="Q36"
replace treat=1 if nteefinal=="Q38"
replace treat=1 if nteefinal=="Q39"
replace treat=1 if nteefinal=="Q40"
replace treat=1 if nteefinal=="Q42"
replace treat=1 if nteefinal=="Q43"
replace treat=1 if nteefinal=="Q50"
replace treat=1 if nteefinal=="Q51"
replace treat=1 if nteefinal=="Q70"
replace treat=1 if nteefinal=="Q71"
replace treat=1 if nteefinal=="Q99"
replace treat=1 if nteefinal=="R02"
replace treat=1 if nteefinal=="R03"
replace treat=1 if nteefinal=="R05"
replace treat=1 if nteefinal=="R11"
replace treat=1 if nteefinal=="R12"
replace treat=1 if nteefinal=="R20"
replace treat=1 if nteefinal=="R22"
replace treat=1 if nteefinal=="R23"
replace treat=1 if nteefinal=="R24"
replace treat=1 if nteefinal=="R25"
replace treat=1 if nteefinal=="R26"
replace treat=1 if nteefinal=="R28"
replace treat=1 if nteefinal=="R29"
replace treat=1 if nteefinal=="R40"
replace treat=1 if nteefinal=="R60"
replace treat=1 if nteefinal=="R63"
replace treat=1 if nteefinal=="R65"
replace treat=1 if nteefinal=="S02"
replace treat=1 if nteefinal=="S20"
replace treat=1 if nteefinal=="S22"
replace treat=1 if nteefinal=="S30"
replace treat=1 if nteefinal=="S31"
replace treat=1 if nteefinal=="S32"
replace treat=1 if nteefinal=="S43"
replace treat=1 if nteefinal=="S50"
replace treat=1 if nteefinal=="T02"
replace treat=1 if nteefinal=="T22"
replace treat=1 if nteefinal=="T70"
replace treat=1 if nteefinal=="U02"
replace treat=1 if nteefinal=="U40"
replace treat=1 if nteefinal=="U42"
replace treat=1 if nteefinal=="U50"
replace treat=1 if nteefinal=="V02"
replace treat=1 if nteefinal=="V21"
replace treat=1 if nteefinal=="V23"
replace treat=1 if nteefinal=="V24"
replace treat=1 if nteefinal=="V30"
replace treat=1 if nteefinal=="V31"
replace treat=1 if nteefinal=="V33"
replace treat=1 if nteefinal=="V34"
replace treat=1 if nteefinal=="V35"
replace treat=1 if nteefinal=="V36"
replace treat=1 if nteefinal=="W02"
replace treat=1 if nteefinal=="W20"
replace treat=1 if nteefinal=="W24"
replace treat=1 if nteefinal=="W30"
replace treat=1 if nteefinal=="W61"
replace treat=1 if nteefinal=="W70"
replace treat=1 if nteefinal=="W80"
replace treat=1 if nteefinal=="W90"
replace treat=1 if nteefinal=="X01"
replace treat=1 if nteefinal=="X03"
replace treat=1 if nteefinal=="X05"
replace treat=1 if nteefinal=="X19"
replace treat=1 if nteefinal=="X21"
replace treat=1 if nteefinal=="X80"
replace treat=1 if nteefinal=="X90"
replace treat=1 if nteefinal=="Y35"

label variable treat "MDG-aligned NGO"
label define treat 1 "yes" 0 "no"
label values treat
* codebook treat

gen treat2 = treat
replace treat2=0 if nteefinal=="A02"
replace treat2=0 if nteefinal=="A02"
replace treat2=0 if nteefinal=="A23"
replace treat2=0 if nteefinal=="A30"
replace treat2=0 if nteefinal=="A31"
replace treat2=0 if nteefinal=="A32"
replace treat2=0 if nteefinal=="A40"
replace treat2=0 if nteefinal=="A57"
replace treat2=0 if nteefinal=="B29"
replace treat2=0 if nteefinal=="B60"
replace treat2=0 if nteefinal=="B80"
replace treat2=0 if nteefinal=="B90"
replace treat2=0 if nteefinal=="B92"
replace treat2=0 if nteefinal=="E86"
replace treat2=0 if nteefinal=="E90"
replace treat2=0 if nteefinal=="E91"
replace treat2=0 if nteefinal=="F02"
replace treat2=0 if nteefinal=="F20"
replace treat2=0 if nteefinal=="F21"
replace treat2=0 if nteefinal=="F22"
replace treat2=0 if nteefinal=="F33"
replace treat2=0 if nteefinal=="F40"
replace treat2=0 if nteefinal=="F52"
replace treat2=0 if nteefinal=="G41"
replace treat2=0 if nteefinal=="G42"
replace treat2=0 if nteefinal=="G43"
replace treat2=0 if nteefinal=="G48"
replace treat2=0 if nteefinal=="G50"
replace treat2=0 if nteefinal=="G70"
replace treat2=0 if nteefinal=="G92"
replace treat2=0 if nteefinal=="H41"
replace treat2=0 if nteefinal=="H42"
replace treat2=0 if nteefinal=="H50"
replace treat2=0 if nteefinal=="H70"
replace treat2=0 if nteefinal=="I31"
replace treat2=0 if nteefinal=="I40"
replace treat2=0 if nteefinal=="I70"
replace treat2=0 if nteefinal=="L02"
replace treat2=0 if nteefinal=="L20"
replace treat2=0 if nteefinal=="L21"
replace treat2=0 if nteefinal=="L22"
replace treat2=0 if nteefinal=="L30"
replace treat2=0 if nteefinal=="L40"
replace treat2=0 if nteefinal=="L50"
replace treat2=0 if nteefinal=="L80"
replace treat2=0 if nteefinal=="L81"
replace treat2=0 if nteefinal=="L82"
replace treat2=0 if nteefinal=="M40"
replace treat2=0 if nteefinal=="M42"
replace treat2=0 if nteefinal=="N02"
replace treat2=0 if nteefinal=="N50"
replace treat2=0 if nteefinal=="N63"
replace treat2=0 if nteefinal=="N64"
replace treat2=0 if nteefinal=="N65"
replace treat2=0 if nteefinal=="N66"
replace treat2=0 if nteefinal=="N67"
replace treat2=0 if nteefinal=="N68"
replace treat2=0 if nteefinal=="N69"
replace treat2=0 if nteefinal=="N71"
replace treat2=0 if nteefinal=="N72"
replace treat2=0 if nteefinal=="N80"
replace treat2=0 if nteefinal=="O20"
replace treat2=0 if nteefinal=="O30"
replace treat2=0 if nteefinal=="O40"
replace treat2=0 if nteefinal=="O50"
replace treat2=0 if nteefinal=="O52"
replace treat2=0 if nteefinal=="O53"
replace treat2=0 if nteefinal=="O54"
replace treat2=0 if nteefinal=="O55"
replace treat2=0 if nteefinal=="P02"
replace treat2=0 if nteefinal=="P03"
replace treat2=0 if nteefinal=="P05"
replace treat2=0 if nteefinal=="P11"
replace treat2=0 if nteefinal=="P19"
replace treat2=0 if nteefinal=="P31"
replace treat2=0 if nteefinal=="P33"
replace treat2=0 if nteefinal=="P40"
replace treat2=0 if nteefinal=="P50"
replace treat2=0 if nteefinal=="P51"
replace treat2=0 if nteefinal=="P52"
replace treat2=0 if nteefinal=="P70"
replace treat2=0 if nteefinal=="P71"
replace treat2=0 if nteefinal=="P73"
replace treat2=0 if nteefinal=="P74"
replace treat2=0 if nteefinal=="P75"
replace treat2=0 if nteefinal=="P80"
replace treat2=0 if nteefinal=="P84"
replace treat2=0 if nteefinal=="P88"
replace treat2=0 if nteefinal=="P99"
replace treat2=0 if nteefinal=="Q20"
replace treat2=0 if nteefinal=="Q21"
replace treat2=0 if nteefinal=="Q22"
replace treat2=0 if nteefinal=="Q43"
replace treat2=0 if nteefinal=="Q71"
replace treat2=0 if nteefinal=="Q99"
replace treat2=0 if nteefinal=="R22"
replace treat2=0 if nteefinal=="R23"
replace treat2=0 if nteefinal=="R25"
replace treat2=0 if nteefinal=="R26"
replace treat2=0 if nteefinal=="R29"
replace treat2=0 if nteefinal=="R40"
replace treat2=0 if nteefinal=="R60"
replace treat2=0 if nteefinal=="R63"
replace treat2=0 if nteefinal=="R65"
replace treat2=0 if nteefinal=="S02"
replace treat2=0 if nteefinal=="S20"
replace treat2=0 if nteefinal=="S22"
replace treat2=0 if nteefinal=="S43"
replace treat2=0 if nteefinal=="T22"
replace treat2=0 if nteefinal=="T70"
replace treat2=0 if nteefinal=="U02"
replace treat2=0 if nteefinal=="U40"
replace treat2=0 if nteefinal=="U42"
replace treat2=0 if nteefinal=="V02"
replace treat2=0 if nteefinal=="V21"
replace treat2=0 if nteefinal=="V23"
replace treat2=0 if nteefinal=="V24"
replace treat2=0 if nteefinal=="V30"
replace treat2=0 if nteefinal=="V31"
replace treat2=0 if nteefinal=="V33"
replace treat2=0 if nteefinal=="V34"
replace treat2=0 if nteefinal=="V36"
replace treat2=0 if nteefinal=="W02"
replace treat2=0 if nteefinal=="W24"
replace treat2=0 if nteefinal=="W30"
replace treat2=0 if nteefinal=="W61"
replace treat2=0 if nteefinal=="W70"
replace treat2=0 if nteefinal=="W80"
replace treat2=0 if nteefinal=="W90"
replace treat2=0 if nteefinal=="X01"
replace treat2=0 if nteefinal=="X03"
replace treat2=0 if nteefinal=="X05"
replace treat2=0 if nteefinal=="X19"
replace treat2=0 if nteefinal=="X21"
replace treat2=0 if nteefinal=="X80"
replace treat2=0 if nteefinal=="X90"
replace treat2=0 if nteefinal=="Y35"

* 85% accuracy
gen treat3=0
replace treat3=1 if nteefinal=="A03"
replace treat3=1 if nteefinal=="A20"
replace treat3=1 if nteefinal=="A23"
replace treat3=1 if nteefinal=="A31"
replace treat3=1 if nteefinal=="A32"
replace treat3=1 if nteefinal=="A40"
replace treat3=1 if nteefinal=="A52"
replace treat3=1 if nteefinal=="A57"
replace treat3=1 if nteefinal=="A63"
replace treat3=1 if nteefinal=="A68"
replace treat3=1 if nteefinal=="A84"
replace treat3=1 if nteefinal=="B03"
replace treat3=1 if nteefinal=="B20"
replace treat3=1 if nteefinal=="B21"
replace treat3=1 if nteefinal=="B28"
replace treat3=1 if nteefinal=="B30"
replace treat3=1 if nteefinal=="B60"
replace treat3=1 if nteefinal=="B82"
replace treat3=1 if nteefinal=="B90"
replace treat3=1 if nteefinal=="B92"
replace treat3=1 if nteefinal=="B94"
replace treat3=1 if nteefinal=="C03"
replace treat3=1 if nteefinal=="C30"
replace treat3=1 if nteefinal=="C32"
replace treat3=1 if nteefinal=="C34"
replace treat3=1 if nteefinal=="C36"
replace treat3=1 if nteefinal=="D03"
replace treat3=1 if nteefinal=="D32"
replace treat3=1 if nteefinal=="D34"
replace treat3=1 if nteefinal=="D60"
replace treat3=1 if nteefinal=="E03"
replace treat3=1 if nteefinal=="E21"
replace treat3=1 if nteefinal=="E30"
replace treat3=1 if nteefinal=="E40"
replace treat3=1 if nteefinal=="E61"
replace treat3=1 if nteefinal=="E80"
replace treat3=1 if nteefinal=="E86"
replace treat3=1 if nteefinal=="E92"
replace treat3=1 if nteefinal=="F03"
replace treat3=1 if nteefinal=="F20"
replace treat3=1 if nteefinal=="F21"
replace treat3=1 if nteefinal=="F22"
replace treat3=1 if nteefinal=="F80"
replace treat3=1 if nteefinal=="G03"
replace treat3=1 if nteefinal=="G60"
replace treat3=1 if nteefinal=="G80"
replace treat3=1 if nteefinal=="G81"
replace treat3=1 if nteefinal=="G84"
replace treat3=1 if nteefinal=="G98"
replace treat3=1 if nteefinal=="H03"
replace treat3=1 if nteefinal=="H81"
replace treat3=1 if nteefinal=="H98"
replace treat3=1 if nteefinal=="I23"
replace treat3=1 if nteefinal=="I31"
replace treat3=1 if nteefinal=="I51"
replace treat3=1 if nteefinal=="I70"
replace treat3=1 if nteefinal=="I72"
replace treat3=1 if nteefinal=="I73"
replace treat3=1 if nteefinal=="J03"
replace treat3=1 if nteefinal=="J22"
replace treat3=1 if nteefinal=="J33"
replace treat3=1 if nteefinal=="K03"
replace treat3=1 if nteefinal=="K30"
replace treat3=1 if nteefinal=="K34"
replace treat3=1 if nteefinal=="K36"
replace treat3=1 if nteefinal=="K40"
replace treat3=1 if nteefinal=="K50"
replace treat3=1 if nteefinal=="L03"
replace treat3=1 if nteefinal=="L20"
replace treat3=1 if nteefinal=="L21"
replace treat3=1 if nteefinal=="L22"
replace treat3=1 if nteefinal=="L24"
replace treat3=1 if nteefinal=="L50"
replace treat3=1 if nteefinal=="L81"
replace treat3=1 if nteefinal=="L82"
replace treat3=1 if nteefinal=="M03"
replace treat3=1 if nteefinal=="M42"
replace treat3=1 if nteefinal=="N03"
replace treat3=1 if nteefinal=="N20"
replace treat3=1 if nteefinal=="N40"
replace treat3=1 if nteefinal=="N50"
replace treat3=1 if nteefinal=="N63"
replace treat3=1 if nteefinal=="N64"
replace treat3=1 if nteefinal=="N65"
replace treat3=1 if nteefinal=="N66"
replace treat3=1 if nteefinal=="N67"
replace treat3=1 if nteefinal=="N68"
replace treat3=1 if nteefinal=="N69"
replace treat3=1 if nteefinal=="N71"
replace treat3=1 if nteefinal=="N72"
replace treat3=1 if nteefinal=="N80"
replace treat3=1 if nteefinal=="O03"
replace treat3=1 if nteefinal=="O20"
replace treat3=1 if nteefinal=="O21"
replace treat3=1 if nteefinal=="O22"
replace treat3=1 if nteefinal=="O23"
replace treat3=1 if nteefinal=="O30"
replace treat3=1 if nteefinal=="O31"
replace treat3=1 if nteefinal=="O40"
replace treat3=1 if nteefinal=="O50"
replace treat3=1 if nteefinal=="O51"
replace treat3=1 if nteefinal=="O52"
replace treat3=1 if nteefinal=="O53"
replace treat3=1 if nteefinal=="O54"
replace treat3=1 if nteefinal=="P02"
replace treat3=1 if nteefinal=="P03"
replace treat3=1 if nteefinal=="P05"
replace treat3=1 if nteefinal=="P11"
replace treat3=1 if nteefinal=="P12"
replace treat3=1 if nteefinal=="P19"
replace treat3=1 if nteefinal=="P28"
replace treat3=1 if nteefinal=="P30"
replace treat3=1 if nteefinal=="P31"
replace treat3=1 if nteefinal=="P33"
replace treat3=1 if nteefinal=="P40"
replace treat3=1 if nteefinal=="P43"
replace treat3=1 if nteefinal=="P44"
replace treat3=1 if nteefinal=="P46"
replace treat3=1 if nteefinal=="P51"
replace treat3=1 if nteefinal=="P52"
replace treat3=1 if nteefinal=="P60"
replace treat3=1 if nteefinal=="P71"
replace treat3=1 if nteefinal=="P73"
replace treat3=1 if nteefinal=="P80"
replace treat3=1 if nteefinal=="P81"
replace treat3=1 if nteefinal=="P84"
replace treat3=1 if nteefinal=="P85"
replace treat3=1 if nteefinal=="P88"
replace treat3=1 if nteefinal=="P99"
replace treat3=1 if nteefinal=="Q03"
replace treat3=1 if nteefinal=="Q20"
replace treat3=1 if nteefinal=="Q33"
replace treat3=1 if nteefinal=="Q36"
replace treat3=1 if nteefinal=="Q38"
replace treat3=1 if nteefinal=="Q51"
replace treat3=1 if nteefinal=="Q70"
replace treat3=1 if nteefinal=="R03"
replace treat3=1 if nteefinal=="R12"
replace treat3=1 if nteefinal=="R20"
replace treat3=1 if nteefinal=="R22"
replace treat3=1 if nteefinal=="R23"
replace treat3=1 if nteefinal=="R24"
replace treat3=1 if nteefinal=="R25"
replace treat3=1 if nteefinal=="R26"
replace treat3=1 if nteefinal=="R28"
replace treat3=1 if nteefinal=="R29"
replace treat3=1 if nteefinal=="R40"
replace treat3=1 if nteefinal=="R60"
replace treat3=1 if nteefinal=="R63"
replace treat3=1 if nteefinal=="R65"
replace treat3=1 if nteefinal=="R67"
replace treat3=1 if nteefinal=="S03"
replace treat3=1 if nteefinal=="S20"
replace treat3=1 if nteefinal=="S30"
replace treat3=1 if nteefinal=="S31"
replace treat3=1 if nteefinal=="S47"
replace treat3=1 if nteefinal=="S50"
replace treat3=1 if nteefinal=="S81"
replace treat3=1 if nteefinal=="S82"
replace treat3=1 if nteefinal=="T03"
replace treat3=1 if nteefinal=="T20"
replace treat3=1 if nteefinal=="T22"
replace treat3=1 if nteefinal=="U03"
replace treat3=1 if nteefinal=="U50"
replace treat3=1 if nteefinal=="V03"
replace treat3=1 if nteefinal=="V21"
replace treat3=1 if nteefinal=="V33"
replace treat3=1 if nteefinal=="V35"
replace treat3=1 if nteefinal=="V36"
replace treat3=1 if nteefinal=="W03"
replace treat3=1 if nteefinal=="W24"
replace treat3=1 if nteefinal=="X03"
replace treat3=1 if nteefinal=="X80"
replace treat3=1 if nteefinal=="X90"
replace treat3=1 if nteefinal=="Y03"

** create new variables
gen ln_exps=ln(exps)
gen ln_ast=ln(ass_eoy)

* creating CPI index to 2000
gen cpi=0
replace cpi=113.6 if year==1987
replace cpi=118.3 if year==1988
replace cpi=124 if year==1989
replace cpi=130.7 if year==1990
replace cpi=136.2 if year==1991
replace cpi=140.3 if year==1992
replace cpi=144.5 if year==1993
replace cpi=148.2 if year==1994
replace cpi=152.4 if year==1995
replace cpi=156.9 if year==1996
replace cpi=160.5 if year==1997
replace cpi=163 if year==1998
replace cpi=166.6 if year==1999
replace cpi=172.2 if year==2000
replace cpi=177.1 if year==2001
replace cpi=179.9 if year==2002
replace cpi=184 if year==2003
replace cpi=188.9 if year==2004
replace cpi=195.3 if year==2005
replace cpi=201.6 if year==2006
replace cpi=207.3 if year==2007
replace cpi=215.303 if year==2008
replace cpi=214.537 if year==2009
replace cpi=218.056 if year==2010
replace cpi=224.939 if year==2011
replace cpi=229.594 if year==2012
replace cpi=232.957 if year==2013
replace cpi=236.736 if year==2014
replace cpi=237.017 if year==2015

* adjust expenditure and create log form
gen exps_cpi=exps*cpi/172.2
gen ast_cpi=ass_eoy*cpi/172.2

gen ln_exps_cpi=ln(exps_cpi)
gen ln_ast_cpi=ln(ast_cpi)

*** use total revenue as control
gen ln_rev = ln(totrev)

*** adjust revenue to cpi and log
gen rev_cpi=totrev*cpi/172.2
gen ln_rev_cpi=ln(rev_cpi)

** interaction
gen post=1
replace post=0 if year <=2000

gen treat_post = treat*post
gen treat2_post = treat2*post
gen treat3_post = treat3*post

* 10:33 am - 12:03 pm no responses
/* reg ln_exps_cpi treat treat_post ln_rev_cpi
xi: reg ln_exps_cpi treat treat_post ln_rev_cpi i.year
xi: reg ln_exps_cpi treat treat_post ln_rev_cpi i.ein
xi: reg ln_exps_cpi treat treat_post ln_rev_cpi i.year i.ein

set more off
reg ln_exps_cpi treat2 treat2_post ln_rev_cpi
xi: reg ln_exps_cpi treat2 treat2_post ln_rev_cpi i.year
xi: reg ln_exps_cpi treat2 treat2_post ln_rev_cpi i.ein
xi: reg ln_exps_cpi treat2 treat2_post ln_rev_cpi i.year i.ein

reg ln_exps_cpi treat3 treat3_post ln_rev_cpi
xi: reg ln_exps_cpi treat3 treat3_post ln_rev_cpi i.year
xi: reg ln_exps_cpi treat3 treat3_post ln_rev_cpi i.ein
xi: reg ln_exps_cpi treat3 treat3_post ln_rev_cpi i.year i.ein */

* divide NGO quartiles
bys ein: egen m_ast=mean(ast_cpi)
sort ein
sum m_ast, d

gen ngo=1 if m_ast<= 51354.04
replace ngo=2 if m_ast> 51354.04 & m_ast<=241874.3
replace ngo=3 if m_ast>241874.3 & m_ast<=1255711
replace ngo=4 if m_ast>1255711

label variable ngo "NGO quartile"
label define ngo 1 "bottom quartile" 2 "lower quartile" 3 "higher quartile" 4 "top quartile"
label values ngo
codebook ngo

gen ngo1=1 if ngo==1
replace ngo1=0 if ngo!=1

gen ngo2=1 if ngo==2
replace ngo2=0 if ngo!=2

gen ngo3=1 if ngo==3
replace ngo3=0 if ngo!=3

gen ngo4=1 if ngo==4
replace ngo4=0 if ngo!=4

save "${logdir}\master_svm_updated1.dta", replace

use "${logdir}\master_svm_updated1.dta", clear */

* rvfplot, yline(0)
* graph save "${logdir}\residual_fe.gph", replace

* april 30 12:57
set more off
eststo clear
* post97
eststo: xi: reg ln_exps_cpi treat3 treat3##i.post97 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat3 treat3##i.post97 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat3 treat3##i.post97 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat3 treat3##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat3 treat3##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* post97 continuous
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* year continuous
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year3 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year3 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year3 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat3 treat3##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
esttab using "${logdir}\reg_table_svm3.rtf", ar2 b(3) se(2) replace

********************* robustness check *****************************************
***** for SVM original
set more off
eststo clear
* post97
eststo: xi: reg ln_exps_cpi treat treat##i.post97 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat treat##i.post97 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat treat##i.post97 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat treat##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat treat##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* post97 continuous
eststo: xi: reg ln_exps_cpi treat treat##c.year2 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat treat##c.year2 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat treat##c.year2 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat treat##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat treat##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* year continuous
eststo: xi: reg ln_exps_cpi treat treat##c.year3 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat treat##c.year3 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat treat##c.year3 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat treat##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat treat##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
esttab using "${logdir}\reg_table_svm1.rtf", ar2 b(3) se(2) replace

***** for SVM manual
set more off
eststo clear
* post97
eststo: xi: reg ln_exps_cpi treat2 treat2##i.post97 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat2 treat2##i.post97 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat2 treat2##i.post97 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat2 treat2##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat2 treat2##i.post97 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* post97 continuous
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year2 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year2 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year2 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year2 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
* year continuous
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year3 ln_rev_cpi ln_ast_cpi
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year3 ln_rev_cpi ln_ast_cpi i.level4
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year3 ln_rev_cpi ln_ast_cpi i.year
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year, r
eststo: xi: reg ln_exps_cpi treat2 treat2##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year if (year>=1994 & year<=2000), r
esttab using "${logdir}\reg_table_svm2.rtf", ar2 b(3) se(2) replace


**************************** tech sector ***************************************
findit nnmatch
ssc install psmatch2

* isolate California
gen CA=0
replace CA=1 if state=="CA"
save "${datadir}\in_use.dta", replace
use "${datadir}\in_use.dta", clear

/* gen net_cpi=netinc*cpi/172.2
gen ln_net_cpi=ln(net_cpi)

gen prog_cpi=totrev*cpi/172.2
gen ln_prog_cpi=ln(prog_cpi)

gen liab_cpi=liab_eoy*cpi/172.2
gen ln_liab_cpi=ln(liab_cpi) */

* data 94-97
keep if year<=1997 & year>=1994
save "${datadir}\in_use_pre.dta", replace

* data 98-02
use "${datadir}\in_use.dta", clear
keep if year>=1998 & year<=2002
save "${datadir}\in_use_post.dta", replace

use "${datadir}\in_use_pre.dta", clear
* pscore to match
psmatch2 tech ln_rev_cpi ln_ast_cpi CA i.year, out(ln_exps_cpi) logit ate
* check balance
pstest ln_rev_cpi ln_ast_cpi CA i.year, treated(tech)
* graph
psgraph, saving("pre match.gph", replace)

use "${datadir}\in_use_post.dta", clear
* pscore to match
psmatch2 tech ln_rev_cpi ln_ast_cpi CA i.year, out(ln_exps_cpi) logit ate
* check balance
pstest ln_rev_cpi ln_ast_cpi CA i.year, treated(tech)
* graph
psgraph, saving("post match.gph", replace)

clear all

/* use "${datadir}\in_use_pre.dta", clear
psmatch2 tech ln_rev_cpi ln_net_cpi ln_prog_cpi ln_ast_cpi ln_liab_cpi CA i.year, out(ln_exps_cpi) logit ate
pstest ln_rev_cpi ln_net_cpi ln_prog_cpi ln_ast_cpi ln_liab_cpi CA i.year, treated(tech)
psgraph, saving("pre match_1.gph", replace)

use "${datadir}\in_use_post.dta", clear
psmatch2 tech ln_rev_cpi ln_net_cpi ln_prog_cpi ln_ast_cpi ln_liab_cpi CA i.year, out(ln_exps_cpi) logit ate
pstest ln_rev_cpi ln_net_cpi ln_prog_cpi ln_ast_cpi ln_liab_cpi CA i.year, treated(tech)
psgraph, saving("pre match_1.gph", replace) */

* nnmatch ln_exps_cpi tech ln_rev_cpi ln_ast_cpi level4 state year, robust(1) pop m(1) keep(match1) replace

/************* PSM method 2 *****************************************************
* Regression with a dummy variable for treatment (t-test)
reg ln_exps_cpi tech

* Regression with a dummy variable for treatment controlling for x
xi: reg ln_exps_cpi tech tech##c.year3 ln_rev_cpi ln_ast_cpi i.level4 i.year, r

findit pscore

* Propensity score matching with common support
pscore tech ln_rev_cpi ln_ast_cpi CA year if year<=1997, pscore(pre_score) blockid(pre_block) comsup
pscore tech ln_rev_cpi ln_ast_cpi CA year if year>1997 & year<=2000, pscore(post_score) blockid(post_block) comsup


* Nearest neighbor matching
attnd ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year if year<=1997, pscore(pre_score) comsup boot reps(5) dots
attnd ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year if year>1997 & year<=2000, pscore(post_score) comsup boot reps(5) dots 


* Stratification Matching
atts ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year id year<=1997, pscore(pre_score) blockid(post_block) comsup boot reps(5) dots
atts ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year if year>1997 & year<=2000, pscore(pre_score) blockid(post_block) comsup boot reps(5) dots */




/** data before year 1997
use "${datadir}\in_use.dta", clear
keep if year<=1997 & year>=1994
save "${datadir}\in_use_9497.dta", replace

use "${datadir}\in_use_9497.dta", clear
use "${datadir}\in_use.dta", clear

by year ein, sort: egen m_exps=mean(exps_cpi) if year>=1994 & year<=1997
by year ein, sort: egen m_rev=mean(rev_cpi) if year>=1994 & year<=1997
by year ein, sort: egen m_ast=mean(ast_cpi) if year>=1994 & year<=1997

* Propensity score matching with common support
pscore tech m_rev m_ast CA year, pscore(p_score) blockid(p_block) comsup
drop p_score
drop p_block

* Nearest neighbor matching
attnd ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year, pscore(p_score) comsup boot reps(5) dots 

* Stratification Matching
atts ln_exps_cpi tech ln_rev_cpi ln_ast_cpi state level4 year, pscore(p_score) blockid(p_block) comsup boot reps(5) dots */









* graph
xi: reg ln_exps_cpi treat3 treat3##c.year2 ln_rev_cpi i.level4 i.year, r
margins, dydx(treat3) at(year2=(0(1)"maximum"))
marginsplot

/****** RD
* linear fit p=1
reg ln_exps_cpi post97 year3 if treat3==1
predict ln_exps_cpi_hat
label var ln_exps_cpi_hat "linear fit"
twoway (scatter ln_exps_cpi year3 if treat3==1) (line ln_exps_cpi_hat year3 if trea3==1), title("RD Linear Fit") saving("rd1_linear.gph", replace)
* drop ln_exps_cpi_hat

* quardratic
gen year3_qua = year3^2
reg ln_exps_cpi post97 year3 year3_qua if treat3==1
predict ln_exps_cpi_hat2
label var ln_exps_cpi_hat2 "quadratic fit"
twoway (scatter ln_exps_cpi year3 if treat3==1, msize(small)) (line ln_exps_cpi_hat2 year3 if treat3==1), title("RD Quadratic Fit") saving("rd1_quadratic.gph", replace)

* quardratic interaction
reg ln_exps_cpi post97 year3 year3_qua i.post97##c.year3 i.post97##c.year3_qua if treat3==1
predict ln_exps_cpi_hat2int
label var ln_exps_cpi_hat2 "quadratic interaction fit"
twoway (scatter ln_exps_cpi year3 if treat3==1 & ln_exps_cpi>=10.5 & ln_exps_cpi<=14, msize(small)) (line ln_exps_cpi_hat2int year3 if treat3==1), title("RD Quadratic Interaction") saving("rd1_qua_int.gph", replace)

* cubic interaction
gen year3_cb = year3^3
reg ln_exps_cpi post97 year3 year3_qua year3_cb post97##c.year3 post97##c.year3_qua post97##c.year3_cb if treat3==1

* linear
xi: reg ln_exps_cpi post97 year3 ln_rev_cpi i.level4 i.year if treat3==1 & year>=1994 & year<=2000, r
* simple quadratic term
xi: reg ln_exps_cpi post97 year3 year3_qua ln_rev_cpi i.level4 i.year if treat3==1 & year>=1994 & year<=2000, r
* quadratic interaction
xi: reg ln_exps_cpi post97 year3 year3_qua post97##c.year3 post97##c.year3_qua ln_rev_cpi i.level4 i.year if treat3==1 & year>=1994 & year<=2000, r


reg exps_cpi post97 year3 year3_qua i.post97##c.year3 i.post97##c.year3_qua if treat3==1
predict exps_cpi_hat2int
label var exps_cpi_hat2int "quadratic interaction fit"
twoway (scatter exps_cpi year3 if treat3==1, msize(small)) (line exps_cpi_hat2int year3 if treat3==1 & year<=1997) (line ln_exps_cpi_hat2int year3 if treat3==1 & year>=1997), title("RD Quadratic Interaction") saving("rd1_qua_int1.gph", replace)
drop ln_exps_cpi_hat2int */

log close
