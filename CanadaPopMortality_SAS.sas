*** PROJECT ***

**Importing datasets
*a) Death causes and numbers Canada 2020-2023;

proc import datafile="/home/u63878396/Project_/death_canada_clean.csv"
    out=death_canada_clean
    dbms=csv
    replace;
    getnames=yes; 
    guessingrows=max; 
run;

*b) Population Canada 2020-2023;

proc import datafile="/home/u63878396/Project_/population_canada_clean.csv"
    out=population_canada_clean
    dbms=csv
    replace;
    getnames=yes; 
    guessingrows=max; 
run;

**Datachecking;
*a)Population;
proc print data=population_canada_clean;
run;

*Metadata sort by index;
proc contents data=population_canada_clean varnum;
run;

*b)Death data;
proc print data=death_canada_clean(obs=10);
run;

proc contents data=death_canada_clean varnum;
run;

**********************************************
**Analysis;
*Challenge: change name of columns;

data population_canada_clean_renamed;
    set population_canada_clean(rename=(
        '2020'n = '2020y'n
        '2021'n = '2021y'n
        '2022'n = '2022y'n
        '2023'n = '2023y'n
    ));
run;

*AVG population by year;
PROC MEANS DATA=population_canada_clean_renamed MEAN;
  VAR _NUMERIC_;
RUN;

* Vertical Bar chart;
* 1)First transpose the data to long format for plotting *;
proc transpose data=population_canada_clean_renamed
               out=plot_data
               name=Year
               prefix=Population;
   var '2020y'n '2021y'n '2022y'n '2023y'n;
run;

* 2)Create the vertical bar chart *;
proc sgplot data=plot_data;
    vbar Year / response=Population1
                stat=sum
                barwidth=0.7
                fillattrs=(color=orange);
    title "Total Population by Year in Canada";
    yaxis label="Total Population";
    xaxis label="Year";
run;


**Numbers inside bars;
/* First transpose the data to long format for plotting */
proc transpose data=population_canada_clean_renamed
               out=plot_data
               name=Year
               prefix=Population;
   var '2020y'n '2021y'n '2022y'n '2023y'n;
run;

/* Calculate sums for each year */
proc means data=plot_data noprint;
   class Year;
   var Population1;
   output out=sum_data sum=TotalPopulation;
run;

/* Merge the sums back with the plot data */
data plot_data_with_totals;
   merge plot_data sum_data(keep=Year TotalPopulation);
   by Year;
   /* Format the total for display */
   TotalPopulation_Formatted = put(TotalPopulation, comma12.);
run;

/* Create the vertical bar chart with orange bars and labels */
proc sgplot data=plot_data_with_totals;
   vbar Year / response=Population1
               stat=sum
               barwidth=0.7
               fillattrs=(color=orange)       /* Changed to orange */
               datalabel=TotalPopulation_Formatted
               datalabelattrs=(color=black weight=bold);  /* Improved label visibility */
   title "Average Population by Year";
   yaxis label="Total Population" grid;
   xaxis label="Year";
   format Population1 comma12.;              /* Format numbers with commas */
run;


*****************
Slope Chart Pop Canada;

OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;

proc sgplot data=plot_data;
    series x=Year y=Population1 / 
        markerattrs=(symbol=circlefilled) 
        lineattrs=(thickness=2);

    scatter x=Year y=Population1 / 
        markerattrs=(symbol=circlefilled size=8)
        datalabel=Population1;

    title "Average Population Trend in Canada (2020-2023)";
    yaxis label="Total Population";
    xaxis label="Year";
    format Population1 comma10.;
run;

******************************
Analysis of Death causes and numbers Canada in Total;

proc sql;
    select Cause,
           Contagious,
           sum(Total) as Total_Frequency
    from death_canada_clean
    group by Cause, Contagious
    order by Cause, Contagious;
quit;

*Just Contagious causes;
proc sql;
    select Cause,
           Contagious,
           sum(Total) as Total_Frequency
    from death_canada_clean
    where Contagious = 1
    group by Cause, Contagious
    order by Total_Frequency desc;
quit;

*Top 5 contaginous Horiozontal Bar Graph:
a)Preparing the data;
proc sql outobs=5;
    create table top5_contagious as
    select Cause,
           sum(Total) as Total_Frequency
    from death_canada_clean
    where Contagious = 1
    group by Cause
    order by Total_Frequency desc;
quit;

*b)Bar chart;
proc sgplot data=top5_contagious;
    title height=14pt "Top 5 Infectious Diseases in Canada Between 2000 and 2023";
    hbar Cause / response=Total_Frequency 
                 fillattrs=(color=green)
                 datalabel;
    xaxis display=none;
    yaxis label="Cause [ICD-10]";
run;


*deaths and population changes over the years
a)Preparing death dataset;
data death_canada_clean_renamed;
    set death_canada_clean(rename=(
        '2020'n = '2020y'n
        '2021'n = '2021y'n
        '2022'n = '2022y'n
        '2023'n = '2023y'n
    ));
run;

*b)Aggregate deaths per year;
proc sql;
    create table death_canada_clean_renamed as
    select 
        sum('2020'n) as Deaths_2020,
        sum('2021'n) as Deaths_2021,
        sum('2022'n) as Deaths_2022,
        sum('2023'n) as Deaths_2023
    from death_canada_clean
    where Contagious = 1;
quit;

*c)Preparing data for Creating a time series chart;
data deaths_timeline;
    set death_canada_clean_renamed;
    Year = "2020"; Deaths = Deaths_2020; output;
    Year = "2021"; Deaths = Deaths_2021; output;
    Year = "2022"; Deaths = Deaths_2022; output;
    Year = "2023"; Deaths = Deaths_2023; output;
    keep Year Deaths;
run;

*d)Creating a time series chart;
proc sgplot data=deaths_timeline;
    title height=14pt "Total Deaths from Infections Diseases in Canada (2020–2023)";
    series x=Year y=Deaths / markers lineattrs=(color=red thickness=2);
    yaxis label="Number of Deaths";
    xaxis label="Year";
run;

*e)Top 5 Infections Diseases in Canada 2022;
*Preparing dataset;
proc sql outobs=5;
    create table top5_contagious_2022 as
    select Cause,
           sum('2022'n) as Deaths_2022
    from death_canada_clean
    where Contagious = 1
    group by Cause
    order by Deaths_2022 desc;
quit;

*Horizontal bar chart;
proc sgplot data=top5_contagious_2022;
    title height=14pt "Top 5 Infectious Diseases in Canada - 2022";
    hbar Cause / response=Deaths_2022 
                 datalabel 
                 datalabelpos=right 
                 fillattrs=(color=blue);
    xaxis display=none; 
    yaxis label="Cause of Death";
run;

*Provinces with highest level of Population
*a) Creating a new dataset;

data map_provinces_pop;
    set population_canada_clean;
    Province = upcase(Province);
    Total_Pop = sum(of '2020'n, '2021'n, '2022'n, '2023'n);
    keep Province Total_Pop;
run;


*b);
proc contents data=maps.canada; 
run;

proc print data=maps.canada(obs=20); 
run;

*c)Prepare your population data to match map IDs;

data province_codes;
    input Province $ 1-21 CDCODE;
    datalines;
ONTARIO             	10
QUEBEC              	11
BRITISH COLUMBIA    	12
ALBERTA             	13
MANITOBA            	14
SASKATCHEWAN        	15
NOVASCOTIA          	16
NEWBRUNSWICK        	17
NEWFOUNDLAND        	18
PRINCE EDWARD ISLAND	19
NORTHWEST TERRITORIES	20
YUKON               	21
NUNAVUT             	22
;
run;

*Creating an index in each dataset
a) Consistency in Province Name:;
proc sort data=province_codes;
by Province;
run;

proc sort data=map_provinces_pop;
by Province;
run;

*b) Create index on the province name in both datasets;
Title "Provinces Dataset";
data province_codes_with_id;
    set province_codes;
    by Province;
    retain Province_ID 0;
    if first.Province then Province_ID + 1;
run;

Title "Map Dataset";
data map_provinces_pop_with_id;
    set map_provinces_pop;
    by Province;
    retain Province_ID 0;
    if first.Province then Province_ID + 1;
run;


*d)Join1;

proc sql;
    create table map_provinces_pop_with_id as
    select a.*, b.*
    from map_provinces_pop_with_id as a
    left join province_codes_with_id as b
    on a.Province_ID = b.Province_ID;
quit;

*checking variables type;
proc contents data=map_provinces_pop_with_id;
run;

proc contents data=maps.canada;
run;

*e)Converting CDODE variable;

data map_provinces_pop_char;
    set map_provinces_pop_with_id;
    CDCODE_char = put(CDCODE, z2.); 
    drop CDCODE;
    rename CDCODE_char = CDCODE;
run;

*f)Join2 (maps canada and new dataset);


* TEST Map;

/* Optional: Define a gradient color scheme */
pattern1 color=lightyellow;
pattern2 color=gold;
pattern3 color=orange;
pattern4 color=red;
pattern5 color=darkred;

/* Create the map */
proc gmap data=map_provinces_pop_char map=maps.canada;
    id CDCODE;
    choro Total_pop / coutline=black;
    title "Population by Canadian Province - Gradient Map";
run;
quit;

*OBSERVATION: A maps.canada dataset might define polygons at the provincial level, 
meaning it provides the outlines for each province. It is not so detailed.


* Map 








