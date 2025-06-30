
*****************************************************************************
*        This file runs estimation for the LTCI Marriage Study            *
*                      Code written by Chuxuan Sun                        *
*               Program is based off Melissa Oney's codes                 *
*               Output table: Main Table 3 ME and Appendix Table 7        *
*                     Last updated on 10/03/2024                          *
*****************************************************************************

capture program drop conditions


	loc table7    "$output/LTCI_M_Table7.rtf"
	
	
	loc format3 "mtitles("Reference" "Purchased for man only" "Purchased for woman only" "Purchased for both") addnote("Notes: We present marginal effects from multinomial logistic regressions, standard errors are reported in parentheses. Models are unweighted. Significance denoted as follows: * p < 0.05, ** p < 0.01, *** p < 0.001. Sample is couples with both partners eligible to purchase LTCI in the baseline periods. Reference category - purchased for neither. ")"
	loc format4 "mtitles("Purchased for myself vs. Purchased for my partner.") addnote("Notes: Coefficients are marginal effects from a logistic model. All models control for year fixed effects. Standard errors are reported in parentheses. Models are unweighted. Significance denoted as follows: * p < 0.05, ** p < 0.01, *** p < 0.001. Reference category - purchased for neither.")"
	


**************
* Regression *
**************

* Mutlinomial logit - 4 outcomes
	clear
	eststo clear
	
	* Run on the main analysis sample
	use "$createddata/LTCI_couple_sumstats.dta"
	keep if sample==1 
	* Suppress one line of code based on HRS disclosure rule


loc vars rfinr_f ///
income networth_quart1 networth_quart2 networth_quart3 owns_home has_will_andor_trust_hh ///
numkidshh18udr havecores19_hh any_ltc_ever_hh ///
africanameric_m other_race_m atleastsome_college_m hs_or_ged_m agey_e_m race_discordance educ_dif_f age_rel ///
smokes_m fair_poor_m smokes_f fair_poor_f ///
risk_av_sum_m risk_av_sum_f ///
havestepkids_m havestepkids_f man_has_sons woman_has_daughters

		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple) 
		margins, dydx(*) predict(outcome(0)) post
			est sto table1
			g sample2=e(sample)
			
			
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(1)) post
			est sto table2
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(2)) post
			est sto table3		
		mlogit outcome `vars' i.wave i.stateid_f i.ind2013, base(0) vce(cluster couple)
		margins, dydx(*) predict(outcome(3)) post
			est sto table4

	esttab table1 table2 table3 table4 using `table7', se `format3' ti("Table 7. LTCI Purchase: Female is the Financial RP") label replace 
