## COVID_DATA SQL Queries

````sql
USE covid_data;
````

**After uploading the data from CSV file, date format and other Columns were auto-changed to VARCHAR.**

**TYPE CONVERSION : Updating COVID_DEATH table to change the "date" column from VARCHAR to DATE format and other columns from VARCHAR TO INT**

````sql
update covid_death set date = date_format(str_to_date(date, '%m/%d/%Y'), '%Y-%m-%d');
update covid_death set new_deaths = new_deaths*1;
update covid_death set icu_patients = icu_patients*1;
update covid_death set new_tests = new_tests*1;
update covid_death set total_tests = total_tests*1;
update covid_death set total_vaccinations = total_vaccinations*1;
update covid_death set people_fully_vaccinated = people_fully_vaccinated*1;
````

**TYPE CONVERSION : Updating COVID_VACCINATIONS table to change the "date" column from VARCHAR to DATE format and other columns from VARCHAR TO INT**


````sql
update covid_vaccinations set date = date_format(str_to_date(date, '%m/%d/%Y'), '%Y-%m-%d');
update covid_vaccinations set new_tests = new_tests*1;
update covid_vaccinations set total_tests = total_tests*1;
update covid_vaccinations set total_vaccinations = total_vaccinations*1;
update covid_vaccinations set people_fully_vaccinated = people_fully_vaccinated*1;
update covid_vaccinations set new_vaccinations = new_vaccinations*1;
````


**Altering the COVID_DEATH table to change table's "date" column from VARCHAR to DATE data type and other columns from VARCHAR to INT.**

````sql
alter table covid_death change date date date,
CHANGE COLUMN `new_deaths` `new_deaths` INT NULL DEFAULT NULL, 
CHANGE COLUMN `icu_patients` `icu_patients` INT NULL DEFAULT NULL ,
CHANGE COLUMN `new_tests` `new_tests` INT NULL DEFAULT NULL ,
CHANGE COLUMN `total_tests` `total_tests` INT NULL DEFAULT NULL,
CHANGE COLUMN `total_vaccinations` `total_vaccinations` INT NULL DEFAULT NULL,
CHANGE COLUMN `people_fully_vaccinated` `people_fully_vaccinated` INT NULL DEFAULT NULL;
````


**Altering the COVID_VACCINATIONS table to change table's "date" column from VARCHAR to DATE data type and other columns from VARCHAR to INT.**

````sql
alter table covid_vaccinations change date date date,
CHANGE COLUMN `new_tests` `new_tests` INT NULL DEFAULT NULL, 
CHANGE COLUMN `total_tests` `total_tests` INT NULL DEFAULT NULL ,
CHANGE COLUMN `total_vaccinations` `total_vaccinations` INT NULL DEFAULT NULL ,
CHANGE COLUMN `people_fully_vaccinated` `people_fully_vaccinated` INT NULL DEFAULT NULL,
CHANGE COLUMN `new_vaccinations` `new_vaccinations` INT NULL DEFAULT NULL;
````


**Query 1 : Total deaths and cases reported in each country.**

````sql
select location, sum(new_deaths) as Total_deaths, sum(new_cases) as Total_cases
from covid_death
group by location
limit 15;
````

**Results :**

| location       | Total_deaths | Total_cases |
|----------------|--------------|-------------|
| United States  |       576232 |    32346970 |
| Brazil         |       403781 |    14659011 |
| Mexico         |       216907 |     2344755 |
| India          |       211853 |    19164969 |
| United Kingdom |       127775 |     4432246 |
| Italy          |       120807 |     4022653 |
| Russia         |       108290 |     4750755 |
| France         |       104675 |     5677835 |
| Germany        |        83097 |     3405365 |
| Spain          |        78216 |     3524077 |
| Colombia       |        73720 |     2859724 |
| Iran           |        71758 |     2499077 |
| Poland         |        67502 |     2792142 |
| Argentina      |        63865 |     2977363 |
| Peru           |        61477 |     1799445 |


**Query 2 :  Countries with highest percentage of Infection rate, compared to country's population, order by Percentage_infected DESC.**

````sql
select *, round((Total_cases/population)*100,2) as Percentage_infected 
from (
select location, sum(new_cases) as Total_cases, max(population) as population
from covid_death
group by location
) e
order by  Percentage_infected desc
limit 15;
````


**Results :**

| location                         | Total_cases | population | Percentage_infected |
|----------------------------------|-------------|------------|---------------------|
| Andorra                          |       13232 |      77265 |               17.13 |
| Montenegro                       |       97389 |     628062 |               15.51 |
| Czechia                          |     1630758 |   10708982 |               15.23 |
| San Marino                       |        5066 |      33938 |               14.93 |
| Slovenia                         |      240292 |    2078932 |               11.56 |
| Luxembourg                       |       67205 |     625976 |               10.74 |
| Bahrain                          |      176934 |    1701583 |                10.4 |
| Serbia                           |      689557 |    6804596 |               10.13 |
| United States                    |    32346970 |  331002647 |                9.77 |
| Israel                           |      838481 |    8655541 |                9.69 |
| Sweden                           |      973604 |   10099270 |                9.64 |
| Estonia                          |      122019 |    1326539 |                 9.2 |
| Lithuania                        |      247269 |    2722291 |                9.08 |
| Netherlands                      |     1522973 |   17134873 |                8.89 |



**Query 3 : Countries with highest percentage of death rate, compared to country's total cases reported, order by Percentage_died DESC.**


```sql
select *, round((Total_deaths/Total_cases)*100,2) as Percentage_died
from (
select location, sum(new_deaths) as Total_deaths, sum(new_cases) as Total_cases
from covid_death
group by location
) e
order by Percentage_died desc
limit 15;
```

**Results :**


| location                         | Total_deaths | Total_cases | Percentage_died |
|----------------------------------|--------------|-------------|-----------------|
| Vanuatu                          |            1 |           4 |              25 |
| Yemen                            |         1226 |        6317 |           19.41 |
| Mexico                           |       216907 |     2344755 |            9.25 |
| Syria                            |         1592 |       22733 |               7 |
| Sudan                            |         2349 |       33944 |            6.92 |
| Egypt                            |        13339 |      227552 |            5.86 |
| Somalia                          |          713 |       13915 |            5.12 |
| Ecuador                          |        18631 |      381862 |            4.88 |
| China                            |         4828 |      101946 |            4.74 |
| Afghanistan                      |         2625 |       59745 |            4.39 |
| Bosnia and Herzegovina           |         8551 |      198461 |            4.31 |
| Bolivia                          |        12951 |      303732 |            4.26 |
| Tanzania                         |           21 |         509 |            4.13 |
| Zimbabwe                         |         1567 |       38257 |             4.1 |
| Bulgaria                         |        16399 |      404380 |            4.06 |
| Liberia                          |           85 |        2099 |            4.05 |



**Query 4 : Showing global cases, month wise.**

```sql
select *,  round((deaths/cases_reported)*100,2) as percentage_died
from (
select date_format(date,"%M-%Y") as date_mm,max(new_deaths) as deaths, max(total_cases) cases_reported
from covid_death
group by date_mm
) q;	
````

**Results :**

| date_mm        | deaths | cases_reported | percentage_died |
|----------------|--------|----------------|-----------------|
| February-2020  |    252 |          79356 |            0.32 |
| March-2020     |   1085 |         192301 |            0.56 |
| April-2020     |   2612 |        1081020 |            0.24 |
| May-2020       |   2314 |        1798718 |            0.13 |
| June-2020      |   2003 |        2642174 |            0.08 |
| July-2020      |   3887 |        4567420 |            0.09 |
| August-2020    |   4143 |        6026895 |            0.07 |
| September-2020 |   3852 |        7235428 |            0.05 |
| October-2020   |   3351 |        9165619 |            0.04 |
| November-2020  |   2263 |       13670332 |            0.02 |
| December-2020  |   3731 |       20099363 |            0.02 |
| January-2021   |   4474 |       26247053 |            0.02 |
| February-2021  |   3906 |       28648744 |            0.01 |
| March-2021     |   3869 |       30462210 |            0.01 |
| April-2021     |   4249 |       32346971 |            0.01 |
| January-2020   |     49 |           9802 |            0.50 |


**Query 5 : Percentage of number of people vaccinated in entire population, order by Percent_vaccinated DESC.**

````sql
with PopVsVac as (
select d.location, max(d.population) as population, max(v.people_fully_vaccinated) as total_vaccinated
from covid_death d
join covid_vaccinations v
on d.location = v.location and d.date = v.date
group by d.location
)
select *, round((total_vaccinated/population)*100,2) as Percent_vaccinated
from PopVsVac 
order by Percent_vaccinated desc
limit 15;
````

**Results :**


| location                         | population | total_vaccinated | Percent_vaccinated |
|----------------------------------|------------|------------------|--------------------|
| Gibraltar                        |      33691 |            32838 |              97.47 |
| Seychelles                       |      98340 |            59160 |              60.16 |
| Israel                           |    8655541 |          5092858 |              58.84 |
| Falkland Islands                 |       3483 |             1775 |              50.96 |
| Cayman Islands                   |      65720 |            29920 |              45.53 |
| United Arab Emirates             |    9890400 |          3836521 |              38.79 |
| Bermuda                          |      62273 |            23775 |              38.18 |
| Chile                            |   19116209 |          6693685 |              35.02 |
| Bahrain                          |    1701583 |           541747 |              31.84 |
| United States                    |  331002647 |        101407318 |              30.64 |
| Jersey                           |     101073 |            30333 |              30.01 |
| Monaco                           |      39244 |            11632 |              29.64 |
| Turks and Caicos Islands         |      38718 |            10000 |              25.83 |
| San Marino                       |      33938 |             8701 |              25.64 |
| Malta                            |     441539 |           105628 |              23.92 |
| Serbia                           |    6804596 |          1488034 |              21.87 |



**Created stored procedure with input as country name, to see the number of deaths and vaccinations happened in each month.**

````sql
DELIMITER //
create procedure vaccination_trend (in country varchar(50))
begin
	select date_format(d.date,"%Y-%m") as month_year, d.location, max(d.new_deaths) as deaths, sum(v.people_fully_vaccinated) as vaccinated
	from covid_death d
	join covid_vaccinations v
	on d.location = v.location and d.date = v.date
	group by month_year, location
    having location = country
    order by month_year ;
end //
DELIMITER ;
````

**Query 6 : Calling stored proceedure vaccination_trend with country "India".**


````sql
CALL vaccination_trend('India');
````


**Results :**


| month_year | location | deaths | vaccinated |
|------------|----------|--------|------------|
| 2020-01    | India    |      0 |          0 |
| 2020-02    | India    |      0 |          0 |
| 2020-03    | India    |      8 |          0 |
| 2020-04    | India    |     75 |          0 |
| 2020-05    | India    |    269 |          0 |
| 2020-06    | India    |   2003 |          0 |
| 2020-07    | India    |   1129 |          0 |
| 2020-08    | India    |   1115 |          0 |
| 2020-09    | India    |   1290 |          0 |
| 2020-10    | India    |   1095 |          0 |
| 2020-11    | India    |    704 |          0 |
| 2020-12    | India    |    540 |          0 |
| 2021-01    | India    |    441 |          0 |
| 2021-02    | India    |    138 |   16614639 |
| 2021-03    | India    |    459 |  190428458 |
| 2021-04    | India    |   3645 |  427137196 |


**Query 7 : Calling stored proceedure vaccination_trend with country "Australia".**


````sql
CALL vaccination_trend('Australia');
````

**Results :**

| month_year | location  | deaths | vaccinated |
|------------|-----------|--------|------------|
| 2020-01    | Australia |      0 |          0 |
| 2020-02    | Australia |      0 |          0 |
| 2020-03    | Australia |      5 |          0 |
| 2020-04    | Australia |      8 |          0 |
| 2020-05    | Australia |      1 |          0 |
| 2020-06    | Australia |      1 |          0 |
| 2020-07    | Australia |     13 |          0 |
| 2020-08    | Australia |     41 |          0 |
| 2020-09    | Australia |     59 |          0 |
| 2020-10    | Australia |      5 |          0 |
| 2020-11    | Australia |      1 |          0 |
| 2020-12    | Australia |      1 |          0 |
| 2021-01    | Australia |      0 |          0 |
| 2021-02    | Australia |      0 |          0 |
| 2021-03    | Australia |      0 |          0 |
| 2021-04    | Australia |      1 |          0 |


**Query 8 : Calling stored proceedure vaccination_trend with country "United States".**


````sql
CALL vaccination_trend('united states');
````

**Results :**


| month_year | location      | deaths | vaccinated |
|------------|---------------|--------|------------|
| 2020-01    | United States |      0 |          0 |
| 2020-02    | United States |      1 |          0 |
| 2020-03    | United States |   1085 |          0 |
| 2020-04    | United States |   2612 |          0 |
| 2020-05    | United States |   2314 |          0 |
| 2020-06    | United States |   1013 |          0 |
| 2020-07    | United States |   1414 |          0 |
| 2020-08    | United States |   1499 |          0 |
| 2020-09    | United States |   1200 |          0 |
| 2020-10    | United States |   1121 |          0 |
| 2020-11    | United States |   2263 |          0 |
| 2020-12    | United States |   3731 |          0 |
| 2021-01    | United States |   4474 |   49123911 |
| 2021-02    | United States |   3906 |  383610786 |
| 2021-03    | United States |   2491 | 1218064777 |
| 2021-04    | United States |   2586 | 2374031843 |


**Query 9 : checking if there is any correlation of number of cases report with population density and GDP of a country.**

```sql
select location, max(total_cases) as cases_reported, max(population_density) as population_density, max(gdp_per_capita) as GDP
from covid_death
group by location
order by cases_reported desc, population_density desc
limit 15;
````

**Results :**


| location                         | cases_reported | population_density | GDP        |
|----------------------------------|----------------|--------------------|------------|
| United States                    |       32346971 |             35.608 |  54225.446 |
| India                            |       19164969 |            450.419 |   6426.674 |
| Brazil                           |       14659011 |              25.04 |  14103.452 |
| France                           |        5677835 |            122.578 |  38605.671 |
| Turkey                           |        4820591 |            104.914 |  25129.341 |
| Russia                           |        4750755 |              8.823 |  24765.954 |
| United Kingdom                   |        4432246 |            272.898 |  39753.244 |
| Italy                            |        4022653 |            205.859 |  35220.084 |
| Spain                            |        3524077 |             93.105 |   34272.36 |
| Germany                          |        3405365 |            237.016 |  45229.245 |
| Argentina                        |        2977363 |             16.177 |  18933.907 |
| Colombia                         |        2859724 |             44.223 |  13254.949 |
| Poland                           |        2792142 |            124.027 |  27216.445 |
| Iran                             |        2499077 |             49.831 |   19082.62 |
| Mexico                           |        2344755 |             66.444 |  17336.469 |




**Query 10 : Representing month-wise number of cases reported with countries in rows and months in columns.**

**Common Table Expression (CTE)**


````sql
with month_wise as 
(
select location, case when date_format(date,"%Y-%m") = "2020-02" then (new_cases) else 0 end as feb , 
case when date_format(date,"%Y-%m") = "2020-03" then (new_cases) else 0 end as mar,
case when date_format(date,"%Y-%m") = "2020-04" then (new_cases) else 0 end as apr,
case when date_format(date,"%Y-%m") = "2020-05" then (new_cases) else 0 end as may,
case when date_format(date,"%Y-%m") = "2020-06" then (new_cases) else 0 end as jun,
case when date_format(date,"%Y-%m") = "2020-07" then (new_cases) else 0 end as jul,
case when date_format(date,"%Y-%m") = "2020-08" then (new_cases) else 0 end as aug,
case when date_format(date,"%Y-%m") = "2020-09" then (new_cases) else 0 end as sep,
case when date_format(date,"%Y-%m") = "2020-10" then (new_cases) else 0 end as oct,
case when date_format(date,"%Y-%m") = "2020-11" then (new_cases) else 0 end as nov,
case when date_format(date,"%Y-%m") = "2020-12" then (new_cases) else 0 end as dece,
case when date_format(date,"%Y-%m") = "2021-01" then (new_cases) else 0 end as jan
from covid_death
) 

select location, sum(feb) as "Feb-2020", sum(mar) as "Mar-2020", sum(apr) as "Apr-2020", sum(may)as "May-2020", sum(jun) as "Jun-2020", sum(jul) as "Jul-2020", 
sum(aug)as "Aug-2020", sum(sep)as "Sept-2020",sum(oct) as "Oct-2020",sum(nov)as "Nov-2020",sum(dece)as "Feb-2020", sum(jan) as "Jan-2021"
from month_wise
group by location
limit 20; 
````


**Results :**


| location                         | Feb-2020 | Mar-2020 | Apr-2020 | May-2020 | Jun-2020 | Jul-2020 | Aug-2020 | Sept-2020 | Oct-2020 | Nov-2020 | Feb-2020 | Jan-2021 |
|----------------------------------|----------|----------|----------|----------|----------|----------|----------|-----------|----------|----------|----------|----------|
| Afghanistan                      |        1 |      174 |     1952 |    13081 |    16299 |     5158 |     1494 |      1109 |     2157 |     4849 |     5252 |     3497 |
| Albania                          |        0 |      243 |      530 |      364 |     1398 |     2741 |     4237 |      4136 |     7226 |    17307 |    20134 |    19811 |
| Algeria                          |        1 |      715 |     3290 |     5388 |     4513 |    16487 |    14100 |      7036 |     6412 |    25257 |    16411 |     7729 |
| Andorra                          |        0 |      376 |      369 |       19 |       91 |       70 |      251 |       874 |     2706 |     1989 |     1304 |     1888 |
| Angola                           |        0 |        7 |       20 |       59 |      198 |      864 |     1506 |      2318 |     5833 |     4334 |     2414 |     2243 |
| Anguilla                         |        0 |        0 |        0 |        0 |        0 |        0 |        0 |         0 |        0 |        0 |        0 |        0 |
| Antigua and Barbuda              |        0 |        7 |       17 |        2 |       43 |       22 |        3 |         7 |       27 |       13 |       18 |       75 |
| Argentina                        |        0 |     1054 |     3374 |    12423 |    47679 |   126772 |   226433 |    333266 |   415923 |   257609 |   200981 |   301725 |
| Armenia                          |        0 |      532 |     1534 |     7216 |    16260 |    13008 |     5231 |      6578 |    39454 |    45311 |    24285 |     7617 |
| Aruba                            |        0 |        0 |        0 |        0 |        0 |        0 |        0 |         0 |        0 |        0 |        0 |        0 |
| Australia                        |       16 |     4534 |     2207 |      436 |      718 |     9360 |     8539 |      1277 |      499 |      317 |      513 |      393 |
| Austria                          |        9 |    10171 |     5272 |     1279 |     1035 |     3364 |     6308 |     17375 |    60112 |   177531 |    78359 |    53583 |
| Azerbaijan                       |        0 |      298 |     1506 |     3690 |    12030 |    14354 |     4557 |      3794 |    15040 |    65907 |    97524 |    11519 |
| Bahamas                          |        0 |       14 |       67 |       21 |        2 |      470 |     1643 |      1906 |     2591 |      827 |      330 |      303 |
| Bahrain                          |       41 |      526 |     2473 |     8358 |    15360 |    14224 |    10990 |     18892 |    10781 |     5311 |     5719 |    10382 |
| Bangladesh                       |        0 |       51 |     7616 |    39486 |    98330 |    92178 |    75335 |     50483 |    44205 |    57248 |    48578 |    21629 |
| Barbados                         |        0 |       34 |       47 |       11 |        5 |       13 |       64 |        16 |       47 |       39 |      107 |     1162 |
| Belarus                          |        1 |      151 |    13875 |    28529 |    19562 |     5690 |     4035 |      6788 |    19851 |    38165 |    57637 |    54052 |
| Belgium                          |        1 |    12774 |    35744 |     9862 |     3046 |     7324 |    16485 |     33216 |   310777 |   148116 |    69151 |    63657 |
| Belize                           |        0 |        3 |       15 |        0 |        6 |       24 |      959 |       985 |     1495 |     2367 |     4922 |     1132 |
| Benin                            |        0 |        9 |       55 |      168 |      967 |      606 |      340 |       212 |      286 |      372 |      236 |      642 |


**Query 11 : Representing month-wise number of deaths reported with countries in rows and months in columns.**

**Common Table Expression (CTE)**


````sql
with month_wise as 
(
select location, case when date_format(date,"%Y-%m") = "2020-02" then (new_deaths) else 0 end as feb , 
case when date_format(date,"%Y-%m") = "2020-03" then (new_deaths) else 0 end as mar,
case when date_format(date,"%Y-%m") = "2020-04" then (new_deaths) else 0 end as apr,
case when date_format(date,"%Y-%m") = "2020-05" then (new_deaths) else 0 end as may,
case when date_format(date,"%Y-%m") = "2020-06" then (new_deaths) else 0 end as jun,
case when date_format(date,"%Y-%m") = "2020-07" then (new_deaths) else 0 end as jul,
case when date_format(date,"%Y-%m") = "2020-08" then (new_deaths) else 0 end as aug,
case when date_format(date,"%Y-%m") = "2020-09" then (new_deaths) else 0 end as sep,
case when date_format(date,"%Y-%m") = "2020-10" then (new_deaths) else 0 end as oct,
case when date_format(date,"%Y-%m") = "2020-11" then (new_deaths) else 0 end as nov,
case when date_format(date,"%Y-%m") = "2020-12" then (new_deaths) else 0 end as dece,
case when date_format(date,"%Y-%m") = "2021-01" then (new_deaths) else 0 end as jan
from covid_death
) 

select location, sum(feb) as "Feb-2020", sum(mar) as "Mar-2020", sum(apr) as "Apr-2020", sum(may)as "May-2020", sum(jun) as "Jun-2020", sum(jul) as "Jul-2020", 
sum(aug)as "Aug-2020", sum(sep)as "Sept-2020",sum(oct) as "Oct-2020",sum(nov)as "Nov-2020",sum(dece)as "Feb-2020", sum(jan) as "Jan-2021"
from month_wise
group by location
limit 20; 
````

**Results :**


| location                         | Feb-2020 | Mar-2020 | Apr-2020 | May-2020 | Jun-2020 | Jul-2020 | Aug-2020 | Sept-2020 | Oct-2020 | Nov-2020 | Feb-2020 | Jan-2021 |
|----------------------------------|----------|----------|----------|----------|----------|----------|----------|-----------|----------|----------|----------|----------|
| Afghanistan                      |        0 |        4 |       60 |      194 |      494 |      532 |      119 |        57 |       78 |      257 |      396 |      209 |
| Albania                          |        0 |       15 |       16 |        2 |       29 |       95 |      127 |       103 |      122 |      301 |      371 |      199 |
| Algeria                          |        0 |       44 |      406 |      203 |      259 |      298 |      300 |       226 |      228 |      467 |      325 |      135 |
| Andorra                          |        0 |       12 |       30 |        9 |        1 |        0 |        1 |         0 |       22 |        1 |        8 |       17 |
| Angola                           |        0 |        2 |        0 |        2 |        9 |       39 |       56 |        75 |      101 |       64 |       57 |       61 |
| Anguilla                         |        0 |        0 |        0 |        0 |        0 |        0 |        0 |         0 |        0 |        0 |        0 |        0 |
| Antigua and Barbuda              |        0 |        0 |        3 |        0 |        0 |        0 |        0 |         0 |        0 |        1 |        1 |        2 |
| Argentina                        |        0 |       27 |      191 |      321 |      768 |     2236 |     5117 |      8277 |    14065 |     7728 |     4515 |     4729 |
| Armenia                          |        0 |        3 |       29 |       99 |      312 |      295 |      141 |        80 |      382 |      823 |      659 |      257 |
| Aruba                            |        0 |        0 |        0 |        0 |        0 |        0 |        0 |         0 |        0 |        0 |        0 |        0 |
| Australia                        |        0 |       18 |       75 |       10 |        1 |       97 |      456 |       231 |       19 |        1 |        1 |        0 |
| Austria                          |        0 |      128 |      456 |       84 |       37 |       13 |       15 |        66 |      310 |     2075 |     3038 |     1499 |
| Azerbaijan                       |        0 |        5 |       19 |       39 |      150 |      235 |       86 |        57 |      139 |      662 |     1249 |      491 |
| Bahamas                          |        0 |        0 |       11 |        0 |        0 |        3 |       36 |        46 |       48 |       19 |        7 |        6 |
| Bahrain                          |        0 |        4 |        4 |       11 |       68 |       60 |       43 |        61 |       70 |       20 |       11 |       23 |
| Bangladesh                       |        0 |        5 |      163 |      482 |     1197 |     1264 |     1170 |       970 |      672 |      721 |      915 |      568 |
| Barbados                         |        0 |        0 |        7 |        0 |        0 |        0 |        0 |         0 |        0 |        0 |        0 |        7 |
| Belarus                          |        0 |        1 |       88 |      146 |      157 |      167 |      122 |       152 |      147 |      178 |      266 |      294 |
| Belgium                          |        0 |      705 |     6889 |     1873 |      280 |       94 |       54 |       121 |     1609 |     5020 |     2883 |     1564 |
| Belize                           |        0 |        0 |        2 |        0 |        0 |        0 |       11 |        14 |       32 |       89 |      100 |       53 |
| Benin                            |        0 |        0 |        1 |        2 |       18 |       15 |        4 |         1 |        0 |        2 |        1 |        8 |




**Query 12 : Percentage of people died in a month, out of number of cases reported in each month**


````sql
select *, round((sum_total_deaths/sum_total_cases)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year,  
sum(new_deaths) as sum_total_deaths, sum(total_cases) as sum_total_cases 
from covid_death 
group by Month_year, Location
) e
limit 50 ;
````

**Results:**

| Location                         | Month_year     | sum_total_deaths | sum_total_cases | Death_Percentage |
|----------------------------------|----------------|-----------------|------------------------|------------|
| Afghanistan                      | February-2020  |                0 |               6 |             0.00 |
| Afghanistan                      | March-2020     |                4 |            1164 |             0.34 |
| Afghanistan                      | April-2020     |               60 |           27074 |             0.22 |
| Afghanistan                      | May-2020       |              194 |          225674 |             0.09 |
| Afghanistan                      | June-2020      |              494 |          750944 |             0.07 |
| Afghanistan                      | July-2020      |              532 |         1077247 |             0.05 |
| Afghanistan                      | August-2020    |              119 |         1163297 |             0.01 |
| Afghanistan                      | September-2020 |               57 |         1163868 |             0.00 |
| Afghanistan                      | October-2020   |               78 |         1245948 |             0.01 |
| Afghanistan                      | November-2020  |              257 |         1308111 |             0.02 |
| Afghanistan                      | December-2020  |              396 |         1522209 |             0.03 |
| Afghanistan                      | January-2021   |              209 |         1668119 |             0.01 |
| Afghanistan                      | February-2021  |               43 |         1553102 |             0.00 |
| Afghanistan                      | March-2021     |               41 |         1737068 |             0.00 |
| Afghanistan                      | April-2021     |              141 |         1733260 |             0.01 |
| Albania                          | February-2020  |                0 |               0 |             NULL |
| Albania                          | March-2020     |               15 |            2232 |             0.67 |
| Albania                          | April-2020     |               16 |           15632 |             0.10 |
| Albania                          | May-2020       |                2 |           28873 |             0.01 |
| Albania                          | June-2020      |               29 |           50880 |             0.06 |
| Albania                          | July-2020      |               95 |          119660 |             0.08 |
| Albania                          | August-2020    |              127 |          230278 |             0.06 |
| Albania                          | September-2020 |              103 |          350148 |             0.03 |
| Albania                          | October-2020   |              122 |          523084 |             0.02 |
| Albania                          | November-2020  |              301 |          866248 |             0.03 |
| Albania                          | December-2020  |              371 |         1540509 |             0.02 |
| Albania                          | January-2021   |              199 |         2088163 |             0.01 |
| Albania                          | February-2021  |              416 |         2610775 |             0.02 |
| Albania                          | March-2021     |              439 |         3652195 |             0.01 |
| Albania                          | April-2021     |              159 |         3865660 |             0.00 |
| Algeria                          | February-2020  |                0 |               5 |             0.00 |
| Algeria                          | March-2020     |               44 |            4823 |             0.91 |
| Algeria                          | April-2020     |              406 |           69497 |             0.58 |
| Algeria                          | May-2020       |              203 |          211394 |             0.10 |
| Algeria                          | June-2020      |              259 |          337819 |             0.08 |
| Algeria                          | July-2020      |              298 |          674286 |             0.04 |
| Algeria                          | August-2020    |              300 |         1185076 |             0.03 |
| Algeria                          | September-2020 |              226 |         1458290 |             0.02 |
| Algeria                          | October-2020   |              228 |         1683631 |             0.01 |
| Algeria                          | November-2020  |              467 |         2074384 |             0.02 |
| Algeria                          | December-2020  |              325 |         2884170 |             0.01 |
| Algeria                          | January-2021   |              135 |         3212268 |             0.00 |
| Algeria                          | February-2021  |               92 |         3096714 |             0.00 |
| Algeria                          | March-2021     |              110 |         3577898 |             0.00 |
| Algeria                          | April-2021     |              160 |         3581338 |             0.00 |
| Andorra                          | March-2020     |               12 |            2787 |             0.43 |
| Andorra                          | April-2020     |               30 |           19106 |             0.16 |
| Andorra                          | May-2020       |                9 |           23498 |             0.04 |
| Andorra                          | June-2020      |                1 |           25511 |             0.00 |
| Andorra                          | July-2020      |                0 |           27174 |             0.00 |
| Andorra                          | August-2020    |                1 |           31382 |             0.00 |



**Query 13 : Percentage of people diagnosed in a month, out of total population** 


````sql
select *,round((sum_total_cases/population)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year, 
sum(total_cases) as sum_total_cases , max(population) as population
from covid_death
group by Month_year, Location
) e
limit 50;
````

**Result:**

| Location                         | Month_year     | sum_total_cases | population | Death_Percentage |
|----------------------------------|----------------|-----------------|------------|------------------|
| Afghanistan                      | February-2020  |               6 |   38928341 |                0 |
| Afghanistan                      | March-2020     |            1164 |   38928341 |                0 |
| Afghanistan                      | April-2020     |           27074 |   38928341 |             0.07 |
| Afghanistan                      | May-2020       |          225674 |   38928341 |             0.58 |
| Afghanistan                      | June-2020      |          750944 |   38928341 |             1.93 |
| Afghanistan                      | July-2020      |         1077247 |   38928341 |             2.77 |
| Afghanistan                      | August-2020    |         1163297 |   38928341 |             2.99 |
| Afghanistan                      | September-2020 |         1163868 |   38928341 |             2.99 |
| Afghanistan                      | October-2020   |         1245948 |   38928341 |              3.2 |
| Afghanistan                      | November-2020  |         1308111 |   38928341 |             3.36 |
| Afghanistan                      | December-2020  |         1522209 |   38928341 |             3.91 |
| Afghanistan                      | January-2021   |         1668119 |   38928341 |             4.29 |
| Afghanistan                      | February-2021  |         1553102 |   38928341 |             3.99 |
| Afghanistan                      | March-2021     |         1737068 |   38928341 |             4.46 |
| Afghanistan                      | April-2021     |         1733260 |   38928341 |             4.45 |
| Albania                          | February-2020  |               0 |    2877800 |                0 |
| Albania                          | March-2020     |            2232 |    2877800 |             0.08 |
| Albania                          | April-2020     |           15632 |    2877800 |             0.54 |
| Albania                          | May-2020       |           28873 |    2877800 |                1 |
| Albania                          | June-2020      |           50880 |    2877800 |             1.77 |
| Albania                          | July-2020      |          119660 |    2877800 |             4.16 |
| Albania                          | August-2020    |          230278 |    2877800 |                8 |
| Albania                          | September-2020 |          350148 |    2877800 |            12.17 |
| Albania                          | October-2020   |          523084 |    2877800 |            18.18 |
| Albania                          | November-2020  |          866248 |    2877800 |             30.1 |
| Albania                          | December-2020  |         1540509 |    2877800 |            53.53 |
| Albania                          | January-2021   |         2088163 |    2877800 |            72.56 |
| Albania                          | February-2021  |         2610775 |    2877800 |            90.72 |
| Albania                          | March-2021     |         3652195 |    2877800 |           126.91 |
| Albania                          | April-2021     |         3865660 |    2877800 |           134.33 |
| Algeria                          | February-2020  |               5 |   43851043 |                0 |
| Algeria                          | March-2020     |            4823 |   43851043 |             0.01 |
| Algeria                          | April-2020     |           69497 |   43851043 |             0.16 |
| Algeria                          | May-2020       |          211394 |   43851043 |             0.48 |
| Algeria                          | June-2020      |          337819 |   43851043 |             0.77 |
| Algeria                          | July-2020      |          674286 |   43851043 |             1.54 |
| Algeria                          | August-2020    |         1185076 |   43851043 |              2.7 |
| Algeria                          | September-2020 |         1458290 |   43851043 |             3.33 |
| Algeria                          | October-2020   |         1683631 |   43851043 |             3.84 |
| Algeria                          | November-2020  |         2074384 |   43851043 |             4.73 |
| Algeria                          | December-2020  |         2884170 |   43851043 |             6.58 |
| Algeria                          | January-2021   |         3212268 |   43851043 |             7.33 |
| Algeria                          | February-2021  |         3096714 |   43851043 |             7.06 |
| Algeria                          | March-2021     |         3577898 |   43851043 |             8.16 |
| Algeria                          | April-2021     |         3581338 |   43851043 |             8.17 |
| Andorra                          | March-2020     |            2787 |      77265 |             3.61 |
| Andorra                          | April-2020     |           19106 |      77265 |            24.73 |
| Andorra                          | May-2020       |           23498 |      77265 |            30.41 |
| Andorra                          | June-2020      |           25511 |      77265 |            33.02 |
| Andorra                          | July-2020      |           27174 |      77265 |            35.17 |
| Andorra                          | August-2020    |           31382 |      77265 |            40.62 |

