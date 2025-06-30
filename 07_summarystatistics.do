
*****************************************************************************
*     This file creates summary statistics for the LTCI Marriage Study    *
*                      Code written by Chuxuan Sun                        *
*                     Last updated on 10/03/2024                          *
*****************************************************************************

	
	

********************************************************************************
* Summary Statistics for Table 1: (1) At least One Member Eligible (%) *
********************************************************************************
		
use "$createddata\LTCI_couple.dta", clear 

* Suppress two lines of code based on HRS disclosure rules


* Condition 8: Both eligible for LTCI in the base wave
	g disabled_partners = disabled_f+disabled_m	
		recode disabled_partner (0/1=1) (2=0), g(cond8_notdisabled)		
		recode disabled_partner (0=1) (1/2=0), g(cond8_neitherdisabled)	
    keep if cond8_notdisabled==1
	su couple 
	

* LTCI purchase decision 
    g buyfor_neither=(Fltc_ins_m==0 & Fltc_ins_f==0)
    g buyfor_both=(Fltc_ins_m==1 & Fltc_ins_f==1)
	g buyfor_male_only=(Fltc_ins_m==1 & Fltc_ins_f==0)
	g buyfor_female_only=(Fltc_ins_m==0 & Fltc_ins_f==1)
	
	g outcome=0
	    replace outcome=1 if buyfor_male_only==1
		replace outcome=2 if buyfor_female_only==1
		replace outcome=3 if buyfor_both==1
		
		
* Purchases in time t+1
    ta outcome, m
	
	* Purchase Patterns under Unisex Pricing (1996-2012)
	ta outcome if year<=2012, m
	
	* Purchase Patterns under Sex-Specific Pricing (2013-2018)
	ta outcome if year>=2013, m	
	
	
* In Time t+1 -t +10 (Couple Observations)
    g buyfor_neither_never=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==0)
    g buyfor_both_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==1)
	g buyfor_male_only_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==0)
	g buyfor_female_only_sometime=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==1)
	
	g outcome_cum=0
	    replace outcome_cum=1 if buyfor_male_only_sometime==1
		replace outcome_cum=2 if buyfor_female_only_sometime==1
		replace outcome_cum=3 if buyfor_both_sometime==1	
		
    bys couple: gen tag=cond(_N==1,0,_n)
	keep if tag<=1	
	
	ta outcome_cum, m
	
	
	
		
********************************************************************************
* Summary Statistics for Table 1: (2) Both Members Eligible (%) *
********************************************************************************
		
use "$createddata\LTCI_couple.dta", clear 

* Suppress two lines of code based on HRS disclosure rules


* Condition 8: Both eligible for LTCI in the base wave
	g disabled_partners = disabled_f+disabled_m	
		recode disabled_partner (0/1=1) (2=0), g(cond8_notdisabled)		
		recode disabled_partner (0=1) (1/2=0), g(cond8_neitherdisabled)	
    keep if cond8_neitherdisabled==1
	su couple //26,951 couple-wave
	

* LTCI purchase decision 
    g buyfor_neither=(Fltc_ins_m==0 & Fltc_ins_f==0)
    g buyfor_both=(Fltc_ins_m==1 & Fltc_ins_f==1)
	g buyfor_male_only=(Fltc_ins_m==1 & Fltc_ins_f==0)
	g buyfor_female_only=(Fltc_ins_m==0 & Fltc_ins_f==1)
	
	g outcome=0
	    replace outcome=1 if buyfor_male_only==1
		replace outcome=2 if buyfor_female_only==1
		replace outcome=3 if buyfor_both==1
		
		
* Purchases in time t+1
    ta outcome, m
	
	distinct couple if inlist(outcome,1,2)
	
	* Purchase Patterns under Unisex Pricing (1996-2012)
	ta outcome if year<=2012, m
	
	* Purchase Patterns under Sex-Specific Pricing (2013-2018)
	ta outcome if year>=2013, m	
	
	
* In Time t+1 -t +10 (Couple Observations)
    g buyfor_neither_never=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==0)
    g buyfor_both_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==1)
	g buyfor_male_only_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==0)
	g buyfor_female_only_sometime=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==1)
	
	g outcome_cum=0
	    replace outcome_cum=1 if buyfor_male_only_sometime==1
		replace outcome_cum=2 if buyfor_female_only_sometime==1
		replace outcome_cum=3 if buyfor_both_sometime==1	
		
    bys couple: gen tag=cond(_N==1,0,_n)
	keep if tag<=1	
	
	ta outcome_cum, m
	
	
	
	
***********************************************************************************************
* Summary Statistics for Table 1: (3) Both members eligible; woman decision maker (%) *
***********************************************************************************************
		
use "$createddata\LTCI_couple.dta", clear 

* Suppress two lines of code based on HRS disclosure rules


* Condition 8: Both eligible for LTCI in the base wave
	g disabled_partners = disabled_f+disabled_m	
		recode disabled_partner (0/1=1) (2=0), g(cond8_notdisabled)		
		recode disabled_partner (0=1) (1/2=0), g(cond8_neitherdisabled)	
    keep if cond8_neitherdisabled==1
	su couple //26,951 couple-wave
	
	
    keep if ptr_finlsy_hlthins_max_f==1
	su couple 
	distinct couple 
	

* LTCI purchase decision 
    g buyfor_neither=(Fltc_ins_m==0 & Fltc_ins_f==0)
    g buyfor_both=(Fltc_ins_m==1 & Fltc_ins_f==1)
	g buyfor_male_only=(Fltc_ins_m==1 & Fltc_ins_f==0)
	g buyfor_female_only=(Fltc_ins_m==0 & Fltc_ins_f==1)
	
	g outcome=0
	    replace outcome=1 if buyfor_male_only==1
		replace outcome=2 if buyfor_female_only==1
		replace outcome=3 if buyfor_both==1
		
		
* Purchases in time t+1
    ta outcome, m
	
	* Purchase Patterns under Unisex Pricing (1996-2012)
	ta outcome if year<=2012, m
	
	* Purchase Patterns under Sex-Specific Pricing (2013-2018)
	ta outcome if year>=2013, m	
	
	
* In Time t+1 -t +10 (Couple Observations)
    g buyfor_neither_never=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==0)
    g buyfor_both_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==1)
	g buyfor_male_only_sometime=(Fltc_ins_ever_m==1 & Fltc_ins_ever_f==0)
	g buyfor_female_only_sometime=(Fltc_ins_ever_m==0 & Fltc_ins_ever_f==1)
	
	g outcome_cum=0
	    replace outcome_cum=1 if buyfor_male_only_sometime==1
		replace outcome_cum=2 if buyfor_female_only_sometime==1
		replace outcome_cum=3 if buyfor_both_sometime==1	
		
    bys couple: gen tag=cond(_N==1,0,_n)
	keep if tag<=1	
	
	ta outcome_cum, m

	
	
	
*************************************
* Table 2A *
*************************************

	loc table2a "$output/LTCI_M_Table2A.rtf"
	loc table2b "$output/LTCI_M_Table2B.rtf"
	
	
	clear
	eststo clear
    use "$createddata/LTCI_couple_sumstats.dta", clear 
    keep if sample==1
	
	lab var ptr_finlsy_hlthins_max_f    "Woman has the final say of what health insurance to buy"
	lab var rfinr_f                     "Woman is the financial respondent"
	lab var income                      "Total household income (in 2018 dollars/thousands)"
	lab var networth_quart1             "Net worth (1st quartile)"
	lab var networth_quart2             "Net worth (2nd quartile)"
	lab var networth_quart3             "Net worth (3rd quartile)"
	lab var networth_quart4             "Net worth (4th quartile)"
	lab var owns_home                   "Owns a home"
	lab var has_will_andor_trust_hh     "Has a will/trust"
    lab var numkidshh18udr              "Number of children (<18) in the household"
	lab var havecores19_hh              "Couple has coresidential children 19+"
	lab var any_ltc_ever_hh             "Couple has experience providing LTC"
    lab var caucasian_m                 "Man is White"
	lab var africanameric_m             "Man is African American"
	lab var other_race_m                "Man is other race"
	lab var atleastsome_college_m       "Man has at least some college degree"
	lab var hs_or_ged_m                 "Man has GED or high school degree"
	lab var lt_hs_m                     "Man has less than high school degree"
	lab var agey_e_m                    "Man's age"
	lab var race_discordance            "Woman is not the same race"
	lab var educ_dif_f                  "Woman is at least as educated as man"
	lab var age_rel                     "Relative age (Man's age-woman's age)"
    lab var smokes_m                    "Man currently smokes"
	lab var fair_poor_m                 "Man reported fair/poor health"
	lab var smokes_f                    "Woman currently smokes"
	lab var fair_poor_f                 "Woman reported fair/poor health"
    lab var risk_av_sum_m               "Man's risk aversion score"
	lab var risk_av_sum_f               "Woman's risk aversion score"
    lab var havestepkids_m              "Man has stepchildren"
	lab var havestepkids_f              "Woman has stepchildren"
	lab var man_has_sons                "Man has sons"
	lab var woman_has_daughters         "Woman has daughters"
	
	
loc vars_ss ptr_finlsy_hlthins_max_f rfinr_f ///
income networth_quart1 networth_quart2 networth_quart3 networth_quart4 owns_home has_will_andor_trust_hh ///
numkidshh18udr havecores19_hh any_ltc_ever_hh ///
caucasian_m africanameric_m other_race_m atleastsome_college_m hs_or_ged_m lt_hs_m agey_e_m race_discordance educ_dif_f age_rel ///
smokes_m fair_poor_m smokes_f fair_poor_f ///
risk_av_sum_m risk_av_sum_f ///
havestepkids_m havestepkids_f man_has_sons woman_has_daughters


	estpost su `vars_ss' if buyfor_neither==1
	est sto table4	
	estpost su `vars_ss' if buyfor_male_only==1
	est sto table5
	estpost su `vars_ss' if buyfor_female_only==1
	est sto table6
	estpost su `vars_ss' if buyfor_both==1
	est sto table7
	
	esttab table4 table5 table6 table7 using `table2a', ti("Table 2A. Summary Statistics by Purchasing Decision at the Couple Level, with Both Partners Eligible: First Period") mtitles("Purchased for neither" "Purchased for man only" "Purchase for woman only" "Purchased for both") addnote("Notes: All variables are at the household level and unweighted. Income is reported in 2018 dollars, adjusted for inflation using the Consumer Price Index (CPI). All individual level variables have been recoded to represent whether either partner has the characteristic (e.g., whether either partner has a will/trust, whether either partner's mother is still living, etc.).") cells("mean(fmt(a3))") l replace
	
	
	
*************************************
* Table 2B *
*************************************
	
	clear
	eststo clear
    use "$createddata/LTCI_couple_sumstats.dta", clear 
    keep if sample==1
	keep if ptr_finlsy_hlthins_max_f==1
	
	lab var ptr_finlsy_hlthins_max_f    "Woman has the final say of what health insurance to buy"
	lab var rfinr_f                     "Woman is the financial respondent"
	lab var income                      "Total household income (in 2018 dollars/thousands)"
	lab var networth_quart1             "Net worth (1st quartile)"
	lab var networth_quart2             "Net worth (2nd quartile)"
	lab var networth_quart3             "Net worth (3rd quartile)"
	lab var networth_quart4             "Net worth (4th quartile)"
	lab var owns_home                   "Owns a home"
	lab var has_will_andor_trust_hh     "Has a will/trust"
    lab var numkidshh18udr              "Number of children (<18) in the household"
	lab var havecores19_hh              "Couple has coresidential children 19+"
	lab var any_ltc_ever_hh             "Couple has experience providing LTC"
    lab var caucasian_m                 "Man is White"
	lab var africanameric_m             "Man is African American"
	lab var other_race_m                "Man is other race"
	lab var atleastsome_college_m       "Man has at least some college degree"
	lab var hs_or_ged_m                 "Man has GED or high school degree"
	lab var lt_hs_m                     "Man has less than high school degree"
	lab var agey_e_m                    "Man's age"
	lab var race_discordance            "Woman is not the same race"
	lab var educ_dif_f                  "Woman is at least as educated as man"
	lab var age_rel                     "Relative age (Man's age-woman's age)"
    lab var smokes_m                    "Man currently smokes"
	lab var fair_poor_m                 "Man reported fair/poor health"
	lab var smokes_f                    "Woman currently smokes"
	lab var fair_poor_f                 "Woman reported fair/poor health"
    lab var risk_av_sum_m               "Man's risk aversion score"
	lab var risk_av_sum_f               "Woman's risk aversion score"
    lab var havestepkids_m              "Man has stepchildren"
	lab var havestepkids_f              "Woman has stepchildren"
	lab var man_has_sons                "Man has sons"
	lab var woman_has_daughters         "Woman has daughters"
	
	
loc vars_ss ptr_finlsy_hlthins_max_f rfinr_f ///
income networth_quart1 networth_quart2 networth_quart3 networth_quart4 owns_home has_will_andor_trust_hh ///
numkidshh18udr havecores19_hh any_ltc_ever_hh ///
caucasian_m africanameric_m other_race_m atleastsome_college_m hs_or_ged_m lt_hs_m agey_e_m race_discordance educ_dif_f age_rel ///
smokes_m fair_poor_m smokes_f fair_poor_f ///
risk_av_sum_m risk_av_sum_f ///
havestepkids_m havestepkids_f man_has_sons woman_has_daughters


	estpost su `vars_ss' if buyfor_neither==1
	est sto table4	
	estpost su `vars_ss' if buyfor_male_only==1
	est sto table5
	estpost su `vars_ss' if buyfor_female_only==1
	est sto table6
	estpost su `vars_ss' if buyfor_both==1
	est sto table7
	
	esttab table4 table5 table6 table7 using `table2b', ti("Table 2B. Summary Statistics by Purchasing Decision at the Couple Level, with Both Partners Eligible: First Period") mtitles("Purchased for neither" "Purchased for man only" "Purchase for woman only" "Purchased for both") addnote("Notes: All variables are at the household level and unweighted. Income is reported in 2018 dollars, adjusted for inflation using the Consumer Price Index (CPI). All individual level variables have been recoded to represent whether either partner has the characteristic (e.g., whether either partner has a will/trust, whether either partner's mother is still living, etc.).") cells("mean(fmt(a3))") l replace	
