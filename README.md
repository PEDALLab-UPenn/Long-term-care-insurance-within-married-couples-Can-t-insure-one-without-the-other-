
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
