
*****************************************************************************
*        This file runs estimation for the LTCI Marriage Study            *
*                      Code written by Chuxuan Sun                        *
*               Program is based off Melissa Oney's codes                 *
*               Output table: Appendix Table 9                            *
*                     Last updated on 10/03/2024                          *
*****************************************************************************



capture program drop conditions


	loc table9 "$output/LTCI_M_Table9.rtf"
	
	
	
	
	loc format3 "mtitles("Reference" "Purchased for man only" "Purchased for woman only" "Purchased for both") addnote("Notes: We present marginal effects from multinomial logistic regressions, standard errors are reported in parentheses. Models are unweighted. Significance denoted as follows: * p < 0.05, ** p < 0.01, *** p < 0.001. Sample is couples with both partners eligible to purchase LTCI in the baseline periods. Reference category - purchased for neither. ")"
	loc format4 "mtitles("Purchased for myself vs. Purchased for my partner.") addnote("Notes: Coefficients are marginal effects from a logistic model. All models control for year fixed effects. Standard errors are reported in parentheses. Models are unweighted. Significance denoted as follows: * p < 0.05, ** p < 0.01, *** p < 0.001. Reference category - purchased for neither.")"
	
	
* Create program for estimation

prog conditions
		
	* Has will and/or trust at household level
	g has_will_andor_trust_hh=(has_will_andor_trust_f==1 | has_will_andor_trust_m==1)
	    replace has_will_andor_trust_hh=. if has_will_andor_trust_f==. & has_will_andor_trust_m==.
	    replace has_will_andor_trust_hh=. if has_will_andor_trust_f==. & has_will_andor_trust_m==0
	    replace has_will_andor_trust_hh=. if has_will_andor_trust_f==0 & has_will_andor_trust_m==.
		
	* Has provided LTC at household level
	g any_ltc_ever_hh=(any_ltc_ever_f==1 | any_ltc_ever_m==1)
	    replace any_ltc_ever_hh=. if any_ltc_ever_f==. & any_ltc_ever_m==.
	    replace any_ltc_ever_hh=. if any_ltc_ever_f==. & any_ltc_ever_m==0
	    replace any_ltc_ever_hh=. if any_ltc_ever_f==0 & any_ltc_ever_m==.
		
		
	* Code specific variables at couple level
		
		* Race discordance 
	    g race_discordance = 0
		    replace race_discordance=1 if (caucasian_m!=caucasian_f|africanameric_m!=africanameric_f|other_race_m!=other_race_f)
		    replace race_discordance=. if (caucasian_m==. & africanameric_m==. & other_race_m==.)|(caucasian_f==. & africanameric_f==. & other_race_f==.)
			
		* Woman is at least as educated as man 
	    g educ_dif_f = 0
		    replace educ_dif_f=1 if (lt_hs_f==1 & lt_hs_m==1) | (hs_or_ged_f==1 & atleastsome_college_m==0) | (atleastsome_college_f==1)
		    replace educ_dif_f=. if (lt_hs_f==. & hs_or_ged_f==. & atleastsome_college_f==.)|(lt_hs_m==. & hs_or_ged_m==. & atleastsome_college_m==.)
			
		* First time married
		g firsttime_marriedhh = (firsttime_married_f==1 & firsttime_married_m==1)
	        replace firsttime_marriedhh=. if firsttime_married_f==. & firsttime_married_m==.
	        replace firsttime_marriedhh=. if firsttime_married_f==. & firsttime_married_m==0
	        replace firsttime_marriedhh=. if firsttime_married_f==0 & firsttime_married_m==.
		
		* Has children gender concordance
	    recode haveson_m (0=0) (1=1), g(man_has_sons)
	    recode havedau_f (0=0) (1=1), g(woman_has_daughters)
		
		* HH children 19+ coreside
        g havecores19_hh = (havecores19_f==1 & havecores19_m==1)
	        replace havecores19_hh=. if havecores19_f==. & havecores19_m==.
	        replace havecores19_hh=. if havecores19_f==. & havecores19_m==0
	        replace havecores19_hh=. if havecores19_f==0 & havecores19_m==.		    
	
	    * Fair/poor health 
	    g fair_poor_m = (fair_health_m==1|poor_health_m==1)
		    replace fair_poor_m=. if (fair_health_m==. & poor_health_m==.)
			replace fair_poor_m=. if (fair_health_m==. & poor_health_m==0)
			replace fair_poor_m=. if (fair_health_m==0 & poor_health_m==.)
			
	    g fair_poor_f = (fair_health_f==1|poor_health_f==1)
		    replace fair_poor_f=. if (fair_health_f==. & poor_health_f==.)
			replace fair_poor_f=. if (fair_health_f==. & poor_health_f==0)
			replace fair_poor_f=. if (fair_health_f==0 & poor_health_f==.)
			
		g fair_poor_rel = fair_poor_m-fair_poor_f
		    replace fair_poor_rel=. if (fair_poor_m==.|fair_poor_f==.)
		
		* Relative age: man's age-woman's age		
		g age_rel = agey_e_m-agey_e_f
		    replace age_rel=. if (agey_e_m==.|agey_e_f==.)
			
			
	
	* Label variables 
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
	
			
end



**************
* Regression *
**************

* Mutlinomial logit - 4 outcomes
	clear
	eststo clear
	
	use "$createddata/LTCI_couple_regression.dta"
	
	* Dummy for 2013+
    gen ind2013=(year>=2013)
	
    * Suppress 2 lines of code based on HRS disclosure rules
	
	
	* Drop if woman and man contradict (both said they had the final say)
	drop if ptr_finlsy_hlthins_max_m==1 & ptr_finlsy_hlthins_max_f==1
	
	
    conditions

loc vars ptr_finlsy_hlthins_max_f ///
income networth_quart1 networth_quart2 networth_quart3 owns_home has_will_andor_trust_hh ///
numkidshh18udr havecores19_hh any_ltc_ever_hh ///
africanameric_m other_race_m atleastsome_college_m hs_or_ged_m agey_e_m race_discordance educ_dif_f age_rel ///
smokes_m fair_poor_m smokes_f fair_poor_f ///
risk_av_sum_m risk_av_sum_f ///
havestepkids_m havestepkids_f man_has_sons woman_has_daughters 

		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple) 
		margins, dydx(*) predict(outcome(0)) post
			est sto table1
			g sample=e(sample)
			
			
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(1)) post
			est sto table2
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(2)) post
			est sto table3		
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(3)) post
			est sto table4

	esttab table1 table2 table3 table4 using `table9', se `format3' ti("Table 9. LTCI Purchase- Drop Contradictions") label replace 
