
********************************************************************************
		     *	         LTCI MARRIEDS MASTER DO FILE	        *
********************************************************************************

/*

GENERAL NOTES:
- This is the master do-file for the LTCI Marrieds project.
- This do-file defines folder and data globals and allows users to choose which sections and tables to run.
- Adjust the folder and data globals to replicate the results.

*/


********************************************************************************
	
	clear  
	clear matrix
	clear mata
	capture log close
	set more off
	set maxvar 20000
	set scheme s1color
	cap ssc install estout

		
		
********************************************************************************
	*	PART 1:  PREPARING GLOBALS & DEFINE PREAMBLE	  *
********************************************************************************

* FOLDER AND DATA GLOBALS

if 1 {

*select path
gl csun  1
gl name  0                      /* Enter your name */
 
	if $csun {
	gl folder 					"U:\LTCI_marrieds"  
	}

	if $name {
	gl folder					""   /* Enter location of main folder */
	}

}


* FOLDER GLOBALS

		gl do			   			"$folder\do"
		gl output		  			"$folder\output"
		gl log			  		 	"$folder\log"
		gl data			   			"$folder\data"
		gl createddata			   	"$folder\createddata"
		


* CHOOSE SECTIONS TO RUN
	
	loc cleanandmerge				1	
	loc estimation					1		
	loc summarystats                1

	
	
********************************************************************************
*				PART 2:  RUN DO-FILES			*
********************************************************************************

* PART 01: CREATE DATASET	

	if `cleanandmerge' {
		do "$do/01_cleanandmerge.do"            // Appendix Table 1: Sample restrictions 
	}

* PART 2: RUN ESTIMATIONS	
	
	if `estimation' {
		do "$do/02_estimation_full.do"          // Main Table 3 (Woman is the decision maker ME); Appendix Table 5
		do "$do/03_estimation_interaction.do"   // Main Table 3 (Woman is the decision maker ME); Appendix Table 6
		do "$do/04_estimation_finrp.do"         // Main Table 3 (Woman is the decision maker ME); Appendix Table 7
		do "$do/05_estimation_logit.do"         // Main Table 3 (Woman is the decision maker ME); Appendix Table 8
		do "$do/06_estimation_dropcontrad.do"   // Robustness check: Appendix Table 9
	}

* PART 3: RUN SUMMARY STATISTICS
	if `summarystats' {
		do "$do/07_summarystatistics.do"        // Main Table 1 & Main Table 2  
	}
	
	
