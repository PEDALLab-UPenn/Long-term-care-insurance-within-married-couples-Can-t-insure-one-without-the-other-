
# Long-term care insurance within married couples: Can’t insure one without the other?

**Authors**: Norma B. Coe, R. Tamara Konetzka, Chuxuan Sun, Courtney Harold Van Houtven

## Abstract
Although long-term care remains one of the largest uninsured risks facing older Americans, demand for insurance remains low. While there is a long literature estimating a variety of factors that contribute to this low demand, much of it has overlooked the fact that most private long-term care insurance (LTCI) purchases are made within couples, adding a host of additional reasons for low demand. This paper examines the role of financial decision-making power within the couple and the association with LTCI purchase decisions. We document LTCI purchase patterns among married couples and find that, among couples who ever purchase LTCI, they are roughly equally likely to purchase for the woman exclusively (10.0%), the man exclusively (11%), or both (11%). However, among couples where women have more bargaining power, LTCI purchases are more likely overall (40% vs. 33%), and more likely to cover the woman, either exclusively (16% vs. 11%) or as part of both members of the couple (14% vs. 11%), than among couples with more traditional gender roles. In adjusted analyses, we find that women are more likely to be insured when they have more bargaining power. These findings suggest that intra-household bargaining power may be another potential explanation for the particularly low LTCI take-up, especially in the time period in which policies were unisex-priced.

Please cite as: Coe, N.B., Konetzka, R.T., Sun, C. et al. Long-term care insurance within married couples: Can’t insure one without the other?. Rev Econ Household (2025). https://doi.org/10.1007/s11150-025-09779-0

## Overview

Before Running the Code

- Create the following subfolders in your project directory: do, data, createddata, log, and output

- Change the file path for the global folder (`gl folder`) in `00_master.do` to the location of the project folder

Once these changes have been made, running `00_master.do` will produce the data and figures corresponding to the selected sections (noted in each local in the 00_master.do).

For questions about the code, please contact **Chuxuan Sun**:  
`chuxuan.sun@pennmedicine.upenn.edu`

Register for access to the HRS and RAND HRS data on the HRS website  
(https://hrs.isr.umich.edu/data-products), then download the following files (both `.dct` and `.da`, or `.dta` where noted):

- **RAND HRS Fat Files**: `ad95f2b`, `h96f4a`, `hd98f2c`, `h00f1d`, `h02f2c`, `h04f1c`, `h06f3a`, `h08f3a`, `hd10f5f`, `h12f3a`, `h14f2b`, `h16f2c`, `h18f2b`
- **RAND HRS Longitudinal File**: `randhrs1992_2018v2.dta`
- **RAND HRS Family Data Respondent-Kid File**: `randhrsfamk1992_2018v2.dta`

Place RAND HRS Fat Files in the `rand_fat` folder, and place RAND HRS Longitudinal File and RAND HRS Family Data Respondent-Kid File in the `rand` folder.

The primary analysis uses the HRS's restricted Cross-Wave Geographic Information (Detail) file. Place it in the `data` folder.

- **HRS Restricted State File**: `hrshrsxgeo18v8b_r`

Finally, download the provided data on Consumer Price Index (CPI) to adjust for inflation in income and wealth  
(https://www.minneapolisfed.org/about-us/monetary-policy/inflation-calculator/consumer-price-index-1913-)

- **CPI File**: `cpi.xlsx`




## Running the code:

This code is for **Stata MP**, and has been verified to run in version **18.5**.  
The `estout` package is required to output tables.

---

## Description of files:

The following describes how the files correspond to the inputs and output:

| File                        | Description                                                  | Inputs                                                                                          | Outputs                                               | Notes                                                  |
|-----------------------------|--------------------------------------------------------------|--------------------------------------------------------------------------------------------------|--------------------------------------------------------|--------------------------------------------------------|
| `00_master.do`              | Sets macros for all variables, specifications, and replications used in the other files | —                                                                                                | —                                                      | Only edit the global folder and the individual global macros |
| `01_cleanandmerge.do`       | Cleans and merges all raw data files                         | RAND HRS Fat Files, RAND HRS Longitudinal File, RAND HRS Family Data Respondent-Kid File, HRS Restricted State File, and CPI File | `LTCI_couple_regression.dta`; Table 1 (sample restrictions) | —                                                      |
| `02_estimation_full`        | Runs estimations for main analyses                           | `LTCI_couple_regression.dta`                                                                     | `LTCI_couple_sumstats.dta`; Table 3 ME + Appendix Tables 5 | —                                                      |
| `03_estimation_interaction` | Runs estimations for unisex pricing interactions             | `LTCI_couple_regression.dta`                                                                     | Table 3 ME + Appendix Tables 6                          | —                                                      |
| `04_estimation_finrp`       | Runs estimations for woman is the financial respondent       | `LTCI_couple_sumstats.dta`                                                                       | Table 3 ME + Appendix Tables 7                          | —                                                      |
| `04_estimation_logit`       | Runs estimations for differential purchase                   | `LTCI_couple_regression.dta`                                                                     | Table 3 ME + Appendix Tables 8                          | —                                                      |
| `06_estimation_dropcontrad` | Runs estimations for dropping if contradictions in who is the decision maker | `LTCI_couple_regression.dta`                                                                     | Appendix Tables 9                                      | —                                                      |
| `07_summarystatistics`      | Creates summary statistics                                   | `LTCI_couple_sumstats.dta`                                                                       | Tables 2                                               | —                                                      |
