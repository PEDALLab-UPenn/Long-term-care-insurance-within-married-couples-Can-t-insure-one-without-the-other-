

*********************************************************************
* This file imports and cleans data for the LTCI Marrieds Study   *
*                     Codes written by CS                         *          
*                   Last updated on 10/03/2024                    *
*********************************************************************



*********************************************************************************
*   SECTION 1  HRS CORE FILES   *
********************************************************************************

clear all

loc u  ad95f2b  h96f4a  hd98f2c  h00f1d  h02f2c  h04f1c  h06f3a  h08f3a  hd10f5f  h12f3a  h14f2b  h16f2c  h18f2b
loc wave = 4
loc n: word count `u'

forv i = 1/`n' {

	loc uu: word `i' of `u'	
	
	use "$data/rand_fat/`uu'.dta", clear
						
	    loc g  d2226   e2226   f2743   g3061   hh004   jh004   kh004   lh004   mh004   nh004   oh004   ph004   qh004
	    loc h  d4768   e4769   f5529   g5882   ht001   jt001   kt001   lt001   mt001   nt001   ot001   pt001   qt001
	    loc j  olb005c6  plb005c6
	    loc k  e1683_1  f2027   g2263   hf119   jf119   kf119   lf119   mf119   nf119   of119   pf119   qf119
	    loc m  e1703_1  f2045   g2281   hf139   jf139   kf139   lf139   mf139   nf139   of139   pf139   qf139
	
	
	    * Rename needed variables 
	    loc g2: word `i' of `g'
		loc h2: word `i' of `h'

		rename `g2' home_ownership
		rename `h2' will_trust
		
		if `i'>1 {		
		    loc i2= `i'-1
		    loc k2: word `i2' of `k'	
		    loc m2: word `i2' of `m'
		    rename `k2' adl_help
		    rename `m2' chores_help
		}
		
		if `i'>=11 & `i'<=12 {		
		    loc i3= `i'-10
		    loc j2: word `i3' of `j'	
		    rename `j2' ptr_finlsy_hlthins
		}
		
		
		* Keep needed variables 
		if `i'==1 {		
		    keep hhidpn home_ownership will_trust 
		}		
		
		if `i'>=2 & `i'<11 {		
		    keep hhidpn home_ownership will_trust adl_help chores_help 
		}	

		if `i'>=11 & `i'<=12 {		
		    keep hhidpn home_ownership will_trust adl_help chores_help ptr_finlsy_hlthins
		}
		
		if `i'==13 {		
		    keep hhidpn home_ownership will_trust adl_help chores_help 
		}	
		
			if `i' < 3 {
			g wave = 3
			}
			else {
			g wave = `wave'
			loc wave = `wave' + 1
			}
				
	tempfile temp`i'
	sa `temp`i''
	clear
}

	use `temp1'
		forv j = 2/13 {
		append using `temp`j''
		}
		
order hhidpn wave home_ownership adl_help chores_help ptr_finlsy_hlthins		
sa "$createddata\HRSCORE", replace 		

clear




********************************************************************************
*   SECTION 2  RAND HRS DATA   *
********************************************************************************

clear all

* RAND HRS longitudinal file
use hhidpn hhid h*itot h*atotb h*child ///
        s*hhidpn s*iwstat ///
        r*iwstat raracem ragender raeduc r*adl5a ///
	    r*hiltc r*agey_e r*shlt r*smoken r*momliv r*dadliv ///
	    r*nrshom r*govmd r*govva r*mstat r*mrct r*stroke ///
		r*cholst r*flusht r*breast r*mammog r*papsm r*prost r*finr r*iwendy using "$data\rand\randhrs1992_2018v2.dta" 
		// Preventive behaviors: Prev Cholesterol; Prev Flu Shot; Prev Breast Check; Prev Mammogram; Prev Pap Smear; Prev Prostate

	* Change variable names to use reshape (wide to long)
	forval x = 3 (1) 14 {
		foreach r_var in iwstat hiltc agey_e shlt smoken nrshom ///
		                 govmd govva mstat mrct stroke adl5a momliv dadliv ///
						 cholst flusht mammog papsm prost finr iwendy {
			rename r`x'`r_var' r`r_var'`x'
			}
		foreach s_var in hhidpn iwstat {
			rename s`x'`s_var' s`s_var'`x'
			}
		foreach h_var in itot atotb child {
			rename h`x'`h_var' h`h_var'`x'
			}
		foreach var in raracem ragender raeduc {
			g `var'`x' = `var'
			}			
	}
	
	drop raracem ragender raeduc
	
	reshape long riwstat rhiltc ragey_e rshlt rsmoken rnrshom ///
	             rgovmd rgovva rmstat rmrct rstroke radl5a rmomliv rdadliv ///
				 shhidpn siwstat ///
				 hitot hatotb hchild raracem ragender raeduc ///
				 rcholst rflusht rmammog rpapsm rprost rfinr riwendy, i(hhidpn) j(wave)

	keep hhid hhidpn wave riwstat rhiltc ragey_e rshlt rsmoken rnrshom ///
	             rgovmd rgovva rmstat rmrct rstroke radl5a rmomliv rdadliv ///
				 shhidpn siwstat ///
				 hitot hatotb hchild raracem ragender raeduc ///
				 rcholst rflusht rmammog rpapsm rprost rfinr riwendy
		 
sa "$createddata\RAND.dta", replace	

clear




********************************************************************************
*   SECTION 3  RAND KIDS FILE   *
********************************************************************************

clear 

use hhidpn hhid opn kagenderbg k*agebg karel k*resd k*stat using"$data\rand\randhrsfamk1992_2018v2.dta"

    * Drop variables not needed
	drop k*mstat kp*

	* Keep only children and step-children	
	keep if karel==1 | karel==2
	
	* Change variable names to use reshape (wide to long)
	forv x = 3/14 {
		foreach var in agebg resd stat {
		rename k`x'`var' `var'`x'
		}
			g kagenderbg`x' = kagenderbg
			g karel`x' = karel
	}

	drop kagenderbg karel k1* k2* kp* *mstat 
			
	* Reshape data from wide to long
	reshape long karel kagenderbg agebg resd stat, i(hhidpn opn) j(wave)
    
	    recode karel      (2=1) (1=0)   (else=.), g(stepkid)
		recode karel      (1=1) (2=0)   (else=.), g(biokid)
		recode kagenderbg (1=1) (2=0) 	(else=.), g(son)
		recode kagenderbg (1=0) (2=1) 	(else=.), g(daughter)				
		recode resd 	  (1=1) (0 2=0) (else=.), g(k_resd)
		
	* Drop children that died, are not in contact, or are not children... 
	keep if stat<=3 | stat==5
	keep hhidpn opn wave agebg son daughter biokid step* k_* 
		
    so hhidpn opn wave 
    order hhidpn opn wave

	* Generate number of kids variable 
	g kids_or_stepkids18 =1 if agebg<=18
	replace kids_or_stepkids18=0 if !mi(agebg) & agebg>18
	bys hhid wave: egen numkidshh18udr    = sum(kids_or_stepkids18), missing

	* Generate the `any' kid variables	
	bys hhidpn wave: egen havedau 	      = max(daughter)
	bys hhidpn wave: egen haveson 		  = max(son)	
	bys hhidpn wave: egen havestepkids 	  = max(stepkid)	
	
	* Ang kids age 19 and above co-reside? Address missingness in age; account for not having any 19+ kids. 
	replace k_resd = .   if agebg<=18 | mi(agebg)		
	bys hhidpn wave: egen havecores19     = max(k_resd)
	
	** Note: alternatively, if chose not to account for not having any 19+ kids, the code would be:
	** replace  k_resd = . if mi(agebg)
	** bys hhidpn wave: egen havecores19     = max(k_resd)
	** Tested both ways, and found the main findings were the same, with slight changes in the 3rd decimal point. 
		
	* Keep the first occurence for each respondent (alternative to collapsing)
	bys hhidpn wave: g val = _n
		keep if val==1
		keep hhidpn wave have* numkidshh18udr 

sa "$createddata/RANDFAMILY.dta", replace

clear




********************************************************************************	

************************
* Pull state_id *
************************	
use "$data/hrsxgeo18v8b_r.dta", clear
    ren *, upper
    rename STATEUSPS state1
	
	rename ZIPCODE, lower
	recode URBRUR2013 (1/3=1)(4/9=0), gen(urban)
	
    g hhidpn = HHID+PN
    destring hhidpn, replace

    g wave=.
        replace wave=1 if regexm(WAVEA,"A")
        replace wave=2 if regexm(WAVEA,"B")|regexm(WAVEA,"C")
        replace wave=3 if regexm(WAVEA,"D")|regexm(WAVEA,"E")
        replace wave=4 if regexm(WAVEA,"F")
        replace wave=5 if regexm(WAVEA,"G")
        replace wave=6 if regexm(WAVEA,"H")
        replace wave=7 if regexm(WAVEA,"J")
        replace wave=8 if regexm(WAVEA,"K")
        replace wave=9 if regexm(WAVEA,"L")
        replace wave=10 if regexm(WAVEA,"M")
        replace wave=11 if regexm(WAVEA,"N")
        replace wave=12 if regexm(WAVEA,"O")
        replace wave=13 if regexm(WAVEA,"P")
        replace wave=14 if regexm(WAVEA,"Q")
	
    so hhidpn wave 
    keep hhidpn wave state1 zipcode urban
    tempfile state
    sa `state'

	
	
	
*************************************************************************
*   SECTION 4  COMBINE ALL FILES   *
*************************************************************************

* Start with the RAND dataset
use "$createddata\RAND.dta", clear
	so hhidpn wave 
	
* Merge in HRS core dataset
merge 1:1 hhidpn wave using "$createddata\HRSCORE.dta", nogen
sa "$createddata\LTCI.dta", replace
	so hhidpn wave 

* Merge in RAND family dataset
merge 1:1 hhidpn wave using "$createddata\RANDFAMILY.dta", nogen
sa "$createddata\LTCI.dta", replace
	so hhidpn wave 
	
* Merge in CPI data
import excel using "$data\cpi.xlsx", firstrow clear
drop year
merge 1:m wave using "$createddata\LTCI.dta", nogen
    order hhid hhidpn wave
	
sa "$createddata\LTCI.dta", replace	

* Merge in state file
merge 1:1 hhidpn wave using `state', keep(master matched) nogen

	* Assume no one moved
	so hhidpn wave
	bys hhidpn: replace state1 = state1[_n-1] if state1==""
    encode state1, g(stateid)	
	
sa "$createddata\LTCI.dta", replace	

	
	
	
********************************************************************************
*   SECTION 5  RECODE FOR LTCI MARRIEDS STUDY   *
********************************************************************************

use "$createddata\LTCI.dta", clear
	
* Generate year variable 
    gen year=riwendy
	
	
* Couple relationship
    recode ptr_finlsy_hlthins (1/2=1) (3/7=0) (else=.)
	bys hhidpn (wave): egen ptr_finlsy_hlthins_max = max(ptr_finlsy_hlthins)	
	
	order hhidpn wave ptr_*

	
* Financial resources

    * Total household income
	rename hitot income
	
	* Networth
	rename hatotb wealth
	
	* Adjust for inflation
	su cpi if wave==14
	g base_year=r(mean)
	g cpi18=cpi/base_year
	replace income=(income/cpi18)/1000
	replace wealth = wealth/cpi18	
	
    * Generate networth quartile variable
	xtile networth_quart = wealth, n(4)
		
	* Owns a home
	recode home_ownership (1=1) (2/7=0) (else=.), g(owns_home)
	
	* Has a will or trust
	recode will_trust (1/3=1) (5=0) (else=.), g(has_will_andor_trust) 
	
	
* Demographics

	* Gender
	recode ragender (1=1) (2=0) (else=.), g(male)
	
    * Age
	recode ragey_e (".m"=.), g(agey_e)
	
	* Marital status
	recode rmstat (1=1) (2/8=0) (else=.), g(married)
	
	* First time getting married
	recode rmrct (1=1) (0 2/13=0) (else=.), gen(firsttime_married)
	
	* Education
	recode raeduc (1=1) (2/5=0) (else=.), g(lt_hs)
	recode raeduc (2/3=1) (1 4/5=0) (else=.), g(hs_or_ged)
	recode raeduc (4/5=1) (1/3=0) (else=.), g(atleastsome_college)
	
	* Race
	recode raracem (1=1) (2/3=0) (else=.), g(caucasian)
	recode raracem (2=1) (1 3=0) (else=.), g(africanameric)
	recode raracem (3=1) (1/2=0) (else=.), g(other_race)
	
	
* Couple shared family care measures 

 	* Mom or dad still alive
	recode rmomliv (1=1) (0=0) (else=.), g(mother_alive)
	recode rdadliv (1=1) (0=0) (else=.), g(father_alive)
	
	* Ever provided informal care
	recode adl_help (1=1) (5=0) (else=.), g(adl_help_100)
	recode chores_help (1=1) (5=0) (else=.), g(chores_help_100)
	
	g any_ltc = .
	    replace any_ltc=1 if (adl_help_100==1|chores_help_100==1)
	    replace any_ltc=0 if (adl_help_100==0 & chores_help_100==0)
		replace any_ltc=0 if mother_alive==0 & father_alive==0 & any_ltc==.
		
	g any_ltc_ever=any_ltc
	bys hhidpn (wave): replace any_ltc_ever=1 if any_ltc_ever[_n-1]==1 
	
	
* Health and risk aversion 

	* Self-reported health
	recode rshlt (1=1) (2/5=0) (else=.), g(excellent_health)
	recode rshlt (2=1) (1 3/5=0) (else=.), g(verygood_health)
	recode rshlt (3=1) (1/2 4/5=0) (else=.), g(good_health)
	recode rshlt (4=1) (1/3 5=0) (else=.), g(fair_health)
	recode rshlt (5=1) (1/4=0) (else=.), g(poor_health)
    
	* Currently smokes
	recode rsmoken (1=1) (0=0) (else=.), g(smokes)
	
	* Preventive behaviors
	* Preventive behaviors: Prev Cholesterol; Prev Flu Shot; Prev Breast Check; Prev Mammogram; Prev Pap Smear; Prev Prostate
	foreach var of varlist rcholst rflusht rmammog rpapsm rprost {
		recode `var' (0=0)(1=1)(.a=99)(else=.)
		
		forv i=4(2)14 {
			
			bys hhidpn (wave): replace `var'=`var'[_n-1] if `var'==99 & wave[_n-1]==wave-1 & wave==`i'
			
		}
	}
		
		
		
* Outcome: LTCI Purchase 
	recode rhiltc (1=1) (0=0) (else=.), g(ltc_ins)

	* Gen long term care insurance in the next wave
    bys hhidpn (wave): g Fltc_ins=ltc_ins[_n+1] if (wave[_n+1]==wave+1|wave[_n+1]==wave+2)
	    * Gen long term care insurance from t+1 to t+10
		bys hhidpn (wave): egen Fltc_ins_ever=max(Fltc_ins)
	
    order hhidpn wave ltc_ins Fltc_ins Fltc_ins_ever
	
	
	
* Variables used to restrict the sample

	* Government insurance 
	recode rgovmd (1=1) (0=0) (else=.), g(medicaid)
	recode rgovva (1=1) (0=0) (else=.), g(va_ins)
	
		g gov_ins = .
		    replace gov_ins=1 if (medicaid==1|va_ins==1)
		    replace gov_ins=0 if (medicaid==0 & va_ins==0)
			
	* LTCI Eligibility
		
	    * Past nursing home use
	    recode rnrshom (1=1) (0=0) (else=.), g(nurshome_2yrs)
    
	    * Ever had a stroke
	    recode rstroke (1=1) (0=0) (else=.)
	
	    * Number of ADL
	    recode radl5a (".m"=.), g(adla)

	    * Disability 
	    g past_nrshom = nurshome_2yrs
		    bys hhidpn (wave): replace past_nrshom=1 if past_nrshom[_n-1]==1
		
	    g disabled = .
	    replace disabled = 1 if (adla>1 & adla<.) | past_nrshom==1 | rstroke==1
		replace disabled=0 if adla<=1 & past_nrshom==0 & rstroke==0 
	
	    * Eligibility for LTCI
	    recode disabled (0=1) (1=0) (else=.), g(ltci_eligible)

sa "$createddata\LTCI.dta", replace




********************************************************************************
*   SECTION 6 CONSTRUCT COUPLE-WAVE LEVEL DATA   * 
********************************************************************************

use "$createddata\LTCI.dta", clear

* Condition 1: Removing individuals with no spouse present
    * Just married individuals
    keep if married==1 
    distinct hhidpn //138,919 hhidpn-wave
	
	* With sp present
	keep if riwstat==1 & siwstat==1	
    distinct hhidpn //133,739 hhidpn-wave
	
	destring hhid, replace
    g pn=hhidpn-(1000*hhid)
    g pn_sp=shhidpn-(1000*hhid)
    g id=pn+pn_sp
    egen couple=group(hhid id)

    bys couple wave: gen dup=cond(_N==1,0,_n)
    keep if dup!=0
	su couple //133,440 hhidpn-wave	


* Condition 2: Removing same-sex couples (creates issues with merging male to female later)
    bys couple wave (hhidpn):g cond2_samesex=(male==male[_n+1]|male==male[_n-1])
	keep if cond2_samesex==0		
	su couple //133,230 hhidpn-wave

	 
* Create gender-specific variables, then merge on couple id
preserve
	keep if male==1

	loc var agey_e married lt_hs hs_or_ged atleastsome_college ///
	        havedau haveson havestepkids havecores19 ///
	        caucasian africanameric other_race any_ltc any_ltc_ever ///
			excellent_health verygood_health good_health fair_health poor_health ///
		    smokes gov_ins ltc_ins Fltc_ins disabled ltci_eligible has_will_andor_trust ptr_finlsy_hlthins_max firsttime_married Fltc_ins_ever ///
			rmomliv rdadliv rcholst rflusht rbreast rmammog rpapsm rprost rfinr stateid
			
	foreach x in `var' {
	rename `x' `x'_m
	}
	
	keep couple wave agey_e_m married_m lt_hs_m hs_or_ged_m atleastsome_college_m ///
	     havedau_m haveson_m havestepkids_m havecores19_m ///
		 caucasian_m africanameric_m other_race_m any_ltc_m any_ltc_ever_m ///
		 excellent_health_m verygood_health_m good_health_m fair_health_m poor_health_m ///
		 smokes_m gov_ins_m ltc_ins_m Fltc_ins_m disabled_m ltci_eligible_m has_will_andor_trust_m ptr_finlsy_hlthins_max_m firsttime_married_m Fltc_ins_ever_m ///
		 rmomliv_m rdadliv_m rcholst_m rflusht_m ///
		 rmammog_m rpapsm_m rprost_m rfinr_m stateid_m
		 
		 
	tempfile male
	sa `male'
	clear 
	
restore 
	keep if male==0

	loc var agey_e married lt_hs hs_or_ged atleastsome_college ///
	        havedau haveson havestepkids havecores19 ///
	        caucasian africanameric other_race any_ltc any_ltc_ever ///
			excellent_health verygood_health good_health fair_health poor_health ///
		    smokes gov_ins ltc_ins Fltc_ins disabled ltci_eligible has_will_andor_trust ptr_finlsy_hlthins_max firsttime_married Fltc_ins_ever ///
			rmomliv rdadliv rcholst rflusht rmammog rpapsm rprost rfinr stateid
			
	foreach x in `var' {
	 rename `x' `x'_f
	}
	
	keep couple wave agey_e_f married_f lt_hs_f hs_or_ged_f atleastsome_college_f ///
	     havedau_f haveson_f havestepkids_f havecores19_f ///
		 caucasian_f africanameric_f other_race_f any_ltc_f any_ltc_ever_f ///
		 excellent_health_f verygood_health_f good_health_f fair_health_f poor_health_f ///
		 smokes_f gov_ins_f ltc_ins_f Fltc_ins_f disabled_f ltci_eligible_f has_will_andor_trust_f ptr_finlsy_hlthins_max_f firsttime_married_f Fltc_ins_ever_f ///
		 networth_quart year income owns_home numkidshh18udr ///
		 rmomliv_f rdadliv_f ///
		 rcholst_f rflusht_f rmammog_f rpapsm_f rprost_f rfinr_f stateid_f

	merge 1:1 couple wave using `male', nogen
    order couple wave ltc_ins_f ltc_ins_m Fltc_ins_f Fltc_ins_m 	

	
* Condition 3: Removing waves with missing LTCI information for either partner in a couple
    bys couple wave:g cond3_nomissltci=(ltc_ins_m!=. & ltc_ins_f!=.) 
	keep if cond3_nomissltci==1
	su couple //64,127 couple-wave	
	
* Condition 4: Responses from 2+ consecutive waves
	so couple wave
    g cond4_consec=(!mi(Fltc_ins_f) & !mi(Fltc_ins_m))	
	keep if cond4_consec==1
	su couple //49,857 couple-wave

* Condition 5: Neither has LTCI in the base wave
    bys couple (wave): g cond5_ltci=(ltc_ins_f==0 & ltc_ins_m==0)
	keep if cond5_ltci==1
    su couple //41,566 couple-wave
	
* Condition 6: No gov ins in the base wave
    bys couple (wave):g cond6_govins=(gov_ins_f==0 & gov_ins_m==0)	
	keep if cond6_govins==1
	su couple //35,938 couple-wave
		
* Condition 7: Both under 79 in the base wave
    bys couple (wave):g cond7_age=(agey_e_f<79 & agey_e_m<79)	
	keep if cond7_age==1
	su couple //31,773 couple-wave	

sa "$createddata\LTCI_couple.dta", replace




********************************************************************************
*   SECTION 7 GENERATE REGRESSION SAMPLE   * 
********************************************************************************

use "$createddata\LTCI_couple.dta", clear 

* Condition 8: Both eligible for LTCI in the base wave
	g disabled_partners = disabled_f+disabled_m	
		recode disabled_partner (0/1=1) (2=0), g(cond8_notdisabled)		
		recode disabled_partner (0=1) (1/2=0), g(cond8_neitherdisabled)	
    keep if cond8_neitherdisabled==1
	su couple //26,953 couple-wave

* LTCI purchase decision 
    g buyfor_neither=(Fltc_ins_m==0 & Fltc_ins_f==0)
    g buyfor_both=(Fltc_ins_m==1 & Fltc_ins_f==1)
	g buyfor_male_only=(Fltc_ins_m==1 & Fltc_ins_f==0)
	g buyfor_female_only=(Fltc_ins_m==0 & Fltc_ins_f==1)
	
	g outcome=0
	    replace outcome=1 if buyfor_male_only==1
		replace outcome=2 if buyfor_female_only==1
		replace outcome=3 if buyfor_both==1
		
* Risk aversion summation 
	egen risk_av_sum_f=rowtotal(rcholst_f rflusht_f rmammog_f rpapsm_f) 		
	egen risk_av_sum_f_miss=rowmiss(rcholst_f rflusht_f rmammog_f rpapsm_f)
	replace risk_av_sum_f=. if risk_av_sum_f_miss>1

	egen risk_av_sum_m=rowtotal(rcholst_m rflusht_m rprost_m) 		
	egen risk_av_sum_m_miss=rowmiss(rcholst_m rflusht_m rprost_m)
	replace risk_av_sum_m=. if risk_av_sum_m_miss>1
	
	order couple wave ltc_ins_f ltc_ins_m Fltc_ins_f Fltc_ins_m ltci_eligible_f ltci_eligible_m
	
	ta networth_quart, g(networth_quart)
		
sa "$createddata\LTCI_couple_regression.dta", replace		
		