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
| 2000-2023| | Year|

* Mortality Datasets ("death_canada_clean")
  
| Variable | Description |
| --- | --- |
| Index | Unique ID|
| Cause| The cause of death|
| 2020 - 2023 | Year|
| Total | Total per cause|
| Contagious | The cause is contagious or not|

## 
