# Canadian-Mortality-and-Population-Trends-2020-2023

The objective of this project is to analyze the patterns and trends in population and mortality across Canadian provinces between 2020 and 2023, using SAS. By integrating datasets on population counts and causes of death (including classification by contagious vs. non-contagious diseases), this project aims to:

* Quantify year-over-year changes in population and deaths.
* Identify top causes of death, especially infectious diseases, during and after the COVID-19 pandemic.
* Evaluate regional disparities in mortality and population distribution.
* Visualize trends through maps, bar charts, and time series to support data-driven insights.
* Contribute to public health monitoring by highlighting shifts in health outcomes and demographic pressure.

## 1. Data Source

### Population Data:
* Statistics Canada (https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710000901 )
* Table: "Population estimates, quarterly"
* Years: 2000–2023
* Granularity: Provincial
* Indicator: "Population, total" 

### Death Statistics:
* Statistics Canada - Vital Statistics (https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310039401)
* Table: "Leading causes of death, total population, by age group"
* Years: 2000–2023
* Includes: Total deaths, cause of death

## 2. Dictionary
* Population dataset ("population_canada_clean")
  
| Variable | Description |
| --- | --- |
| Index | Unique ID |
| Province | The Province in Canada |
| Q1 2020 - Q4 2023 | Quartiles and year|
| 2000 - 2023| Year|

* Mortality Datasets ("death_canada_clean")
  
| Variable | Description |
| --- | --- |
| Index | Unique ID|
| Cause| The cause of death|
| 2020 - 2023 | Year|
| Total | Total per cause|
| Contagious | The cause is contagious or not|

## 3. Ethics Statement
This project complies with the TCPS 2. The dataset is in the public domain.

## 4. Data preparationg
* Rename year columns in "population_canada_clean" dataset (RENAME)
* Transposing data in "population_canada_clean_renamed" dataset to create a bar chart (PROC TRANSPOSE)
* Rouding numbers to display
* Filter data by Contagious or not (PROC SQL)
* Group the data by Cause (GROUP BY)
* Order the dataset in descending order to display (ORDER BY)
* Keeping only necessary information (KEEP)
* Creating a new dataset to build a map and join with "maps.canada"(JOIN)
* Feature engineering: Adding a new column with CDCODES in the dataset to permit join with "maps.canada" and upcase the Province names (UPCASE)
* Calculating Year-Over-Year data and round data (FORMAT)
* Filtering dataset by Province (WHERE)
* Ploting data with clause for negative and positive values (IF, ELSE)
* Split the dataset "death_canada_clean" in 2 new datasets to analyse the distribution of contagious and non-contagious diseases

## 5. Project Plan
The datasets were uploaded from the Statistics Canada website in CSV format, and the analysis was done using SAS.

## 6. Analysis

<img width="476" alt="Screen Shot 2025-06-05 at 7 17 15 PM" src="https://github.com/user-attachments/assets/351ece55-4023-4e2a-9ad3-fa559d37445d" />

Figure 1. In Canada, the population has increased after 2021
* 
<br><br>

<img width="479" alt="Screen Shot 2025-06-05 at 7 20 19 PM" src="https://github.com/user-attachments/assets/e2e8fef5-f744-44dd-813f-a99e03489846" />

Figure 2. The number of deaths in Canada was higher in 2022
<br><br>

<img width="476" alt="Screen Shot 2025-06-05 at 7 21 45 PM" src="https://github.com/user-attachments/assets/8ac9eb73-8b24-429e-ac0a-00f83d3d736c" />

Figure 3. Top 5 contagious diseases in Canada between 2020 and 2023

<br><br>
<img width="472" alt="Screen Shot 2025-06-05 at 7 23 15 PM" src="https://github.com/user-attachments/assets/c8f13bdc-e786-40eb-b6bc-66672e551453" />

Figure 4. Top infectious diseases in Canada in 2022

<br><br>
<img width="614" alt="Screen Shot 2025-06-05 at 7 24 12 PM" src="https://github.com/user-attachments/assets/6972aeea-ab8a-4cdb-8ddd-48d5a74839ae" />

Figure 5. Population density in Canada (2020-2023)

<br><br>
<img width="485" alt="Screen Shot 2025-06-05 at 7 25 02 PM" src="https://github.com/user-attachments/assets/ce2bd4a6-4080-4301-9573-bbcb1bd691ff" />

Figure 6. Year-over-year population rate change by Province (2020-2023)

<br><br>
<img width="429" alt="Screen Shot 2025-06-05 at 7 25 59 PM" src="https://github.com/user-attachments/assets/fe5118fd-f0b5-4391-941a-56f2daa3d9f1" />

Figure 7. Year-over-year population rate change in "Newfoundland and Labrador" and "Northwest Territories" (2020-2023)
<br><br>

<img width="422" alt="Screen Shot 2025-06-05 at 7 27 14 PM" src="https://github.com/user-attachments/assets/b2dec594-a8aa-4553-84e2-f7d944691924" />

Figure 8. Year-over-year percentage change in Mortality by Chronic lower respiratory diseases (2020-2023)

<br><br>
<img width="450" alt="Screen Shot 2025-06-05 at 7 28 25 PM" src="https://github.com/user-attachments/assets/ad947d54-598b-48e7-859b-d404c6308f74" />

Figure 9. Distribuition of "Contagious" data

<br><br>
<img width="422" alt="Screen Shot 2025-06-05 at 7 29 22 PM" src="https://github.com/user-attachments/assets/1020e247-a72e-4d7a-b000-f3062c08f837" />


Figure 10. Distribuition of "Non-Contagious" data
<br><br>

<img width="422" alt="Screen Shot 2025-06-05 at 7 29 38 PM" src="https://github.com/user-attachments/assets/7755d884-8f81-4215-9781-8986c2b0c563" />

Figure 11. Results of Mann-Whitney U test (Wilcoxon Scores in SAS) comparing median Contagious x Non-contagious
<br><br>

<img width="422" alt="Screen Shot 2025-06-05 at 7 31 23 PM" src="https://github.com/user-attachments/assets/a643b215-6100-49ba-8afd-2be86e3282f8" />

Figure 12. Top 5 causes of Non-contagious deaths in Canada (2020-2023)

## 7. Communication and Action

