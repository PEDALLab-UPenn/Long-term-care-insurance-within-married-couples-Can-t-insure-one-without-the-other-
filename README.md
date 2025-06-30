
# Long-term care insurance within married couples: Can’t insure one without the other?

**Authors**: Norma B. Coe, R. Tamara Konetzka, Chuxuan Sun, Courtney Harold Van Houtven

## Overview

Before Running the Code

- Create the following subfolders in your project directory: do, data, createdata, log, and output

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

| File                     | Description                                                  | Inputs                                                                                          | Outputs                                         | Notes                                      |
|--------------------------|--------------------------------------------------------------|--------------------------------------------------------------------------------------------------|--------------------------------------------------|--------------------------------------------|
| `00_master.do`           | Sets macros for all variables, specifications, and replications used in the other files | Only edit the global folder and the individual global macros                                    |                                                  |                                            |
| `01_cleanandmerge.do`    | Cleans and merges all raw data files                         | Input: RAND HRS Fat Files, RAND HRS Longitudinal File, RAND HRS Family Data Respondent-Kid File, HRS Restricted State File, and CPI File | Output: `LTCI_couple_regression.dta`; Table 1 (sample restrictions) |                                            |
| `02_estimation_full`     | Runs estimations for main analyses                           | Input: `LTCI_couple_regression.dta`                                                              | Output: `LTCI_couple_sumstats.dta`; Table 3 ME + Appendix Tables 5 |                                            |
| `03_estimation_interaction` | Runs estimations for unisex pricing interactions         | Input: `LTCI_couple_regression.dta`                                                              | Output: Table 3 ME + Appendix Tables 6           |                                            |
| `04_estimation_finrp`    | Runs estimations for woman is the financial respondent       | Input: `LTCI_couple_sumstats.dta`                                                                | Output: Table 3 ME + Appendix Tables 7           |                                            |
| `04_estimation_logit`    | Runs estimations for differential purchase                   | Input: `LTCI_couple_regression.dta`                                                              | Output: Table 3 ME + Appendix Tables 8           |                                            |
| `06_estimation_dropcontrad` | Runs estimations for dropping if contradictions in who is the decision maker | Input: `LTCI_couple_regression.dta`                                                              | Output: Appendix Tables 9                        |                                            |
| `07_summarystatistics`   | Creates summary statistics                                   | Input: `LTCI_couple_sumstats.dta`                                                                | Output: Tables 2                                 |                                            |
