# COVID_DATA

````sql
USE covid_data;
````

### After uploading the data from CSV file, date format was auto-changed to VARCHAR. Testing to Changing it again to DATE data type.

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


**
Query 1 : Percentage of people died in a month, out of number of cases reported in each month
**

````sql
select *, round((sum_total_deaths/sum_total_cases)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year,  
sum(new_deaths) as sum_total_deaths, sum(total_cases) as sum_total_cases 
from covid_death 
group by Month_year, Location
) e ;
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
| Andorra                          | September-2020 |                0 |           45275 |             0.00 |
| Andorra                          | October-2020   |               22 |          103067 |             0.02 |
| Andorra                          | November-2020  |                1 |          174907 |             0.00 |
| Andorra                          | December-2020  |                8 |          230115 |             0.00 |
| Andorra                          | January-2021   |               17 |          279226 |             0.01 |
| Andorra                          | February-2021  |                9 |          293412 |             0.00 |
| Andorra                          | March-2021     |                5 |          352375 |             0.00 |
| Andorra                          | April-2021     |               10 |          380633 |             0.00 |
| Angola                           | March-2020     |                2 |              48 |             4.17 |
| Angola                           | April-2020     |                0 |             601 |             0.00 |
| Angola                           | May-2020       |                2 |            1639 |             0.12 |
| Angola                           | June-2020      |                9 |            4660 |             0.19 |
| Angola                           | July-2020      |               39 |           20049 |             0.19 |
| Angola                           | August-2020    |               56 |           59160 |             0.09 |
| Angola                           | September-2020 |               75 |          111469 |             0.07 |
| Angola                           | October-2020   |              101 |          233349 |             0.04 |
| Angola                           | November-2020  |               64 |          404417 |             0.02 |
| Angola                           | December-2020  |               57 |          508018 |             0.01 |
| Angola                           | January-2021   |               61 |          580289 |             0.01 |
| Angola                           | February-2021  |               42 |          569508 |             0.01 |
| Angola                           | March-2021     |               29 |          666295 |             0.00 |
| Angola                           | April-2021     |               59 |          726071 |             0.01 |
| Anguilla                         | February-2021  |                0 |               0 |             NULL |
| Anguilla                         | March-2021     |                0 |               0 |             NULL |
| Anguilla                         | April-2021     |                0 |               0 |             NULL |
| Antigua and Barbuda              | March-2020     |                0 |              61 |             0.00 |
| Antigua and Barbuda              | April-2020     |                3 |             617 |             0.49 |
| Antigua and Barbuda              | May-2020       |                0 |             776 |             0.00 |
| Antigua and Barbuda              | June-2020      |                0 |            1026 |             0.00 |
| Antigua and Barbuda              | July-2020      |                0 |            2366 |             0.00 |
| Antigua and Barbuda              | August-2020    |                0 |            2881 |             0.00 |
| Antigua and Barbuda              | September-2020 |                0 |            2886 |             0.00 |
| Antigua and Barbuda              | October-2020   |                0 |            3586 |             0.00 |
| Antigua and Barbuda              | November-2020  |                1 |            4047 |             0.02 |
| Antigua and Barbuda              | December-2020  |                1 |            4656 |             0.02 |
| Antigua and Barbuda              | January-2021   |                2 |            5759 |             0.03 |
| Antigua and Barbuda              | February-2021  |                7 |           12957 |             0.05 |
| Antigua and Barbuda              | March-2021     |               14 |           30085 |             0.05 |
| Antigua and Barbuda              | April-2021     |                4 |           36073 |             0.01 |
| Argentina                        | January-2020   |                0 |               0 |             NULL |
| Argentina                        | February-2020  |                0 |               0 |             NULL |
| Argentina                        | March-2020     |               27 |            6529 |             0.41 |
| Argentina                        | April-2020     |              191 |           77576 |             0.25 |
| Argentina                        | May-2020       |              321 |          275556 |             0.12 |
| Argentina                        | June-2020      |              768 |         1091252 |             0.07 |
| Argentina                        | July-2020      |             2236 |         3728771 |             0.06 |
| Argentina                        | August-2020    |             5117 |         9244163 |             0.06 |
| Argentina                        | September-2020 |             8277 |        17545982 |             0.05 |
| Argentina                        | October-2020   |            14065 |        29922509 |             0.05 |
| Argentina                        | November-2020  |             7728 |        39307295 |             0.02 |
| Argentina                        | December-2020  |             4515 |        47136788 |             0.01 |
| Argentina                        | January-2021   |             4729 |        55312462 |             0.01 |
| Argentina                        | February-2021  |             3991 |        56733848 |             0.01 |
| Argentina                        | March-2021     |             3893 |        68713761 |             0.01 |
| Argentina                        | April-2021     |             8007 |        79416752 |             0.01 |
| Armenia                          | March-2020     |                3 |            4099 |             0.07 |
| Armenia                          | April-2020     |               29 |           36511 |             0.08 |
| Armenia                          | May-2020       |               99 |          151445 |             0.07 |
| Armenia                          | June-2020      |              312 |          520967 |             0.06 |
| Armenia                          | July-2020      |              295 |         1026463 |             0.03 |
| Armenia                          | August-2020    |              141 |         1286089 |             0.01 |
| Armenia                          | September-2020 |               80 |         1398359 |             0.01 |
| Armenia                          | October-2020   |              382 |         2012415 |             0.02 |
| Armenia                          | November-2020  |              823 |         3480514 |             0.02 |
| Armenia                          | December-2020  |              659 |         4636215 |             0.01 |
| Armenia                          | January-2021   |              257 |         5076072 |             0.01 |
| Armenia                          | February-2021  |              112 |         4741148 |             0.00 |
| Armenia                          | March-2021     |              323 |         5603135 |             0.01 |
| Armenia                          | April-2021     |              593 |         6176164 |             0.01 |
| Aruba                            | March-2021     |                0 |               0 |             NULL |
| Aruba                            | April-2021     |                0 |               0 |             NULL |
| Australia                        | January-2020   |                0 |              38 |             0.00 |
| Australia                        | February-2020  |                0 |             431 |             0.00 |
| Australia                        | March-2020     |               18 |           35679 |             0.05 |
| Australia                        | April-2020     |               75 |          188206 |             0.04 |
| Australia                        | May-2020       |               10 |          217625 |             0.00 |
| Australia                        | June-2020      |                1 |          222611 |             0.00 |
| Australia                        | July-2020      |               97 |          361720 |             0.03 |
| Australia                        | August-2020    |              456 |          711091 |             0.06 |
| Australia                        | September-2020 |              231 |          800899 |             0.03 |
| Australia                        | October-2020   |               19 |          848364 |             0.00 |
| Australia                        | November-2020  |                1 |          832514 |             0.00 |
| Australia                        | December-2020  |                1 |          872046 |             0.00 |
| Australia                        | January-2021   |                0 |          889012 |             0.00 |
| Australia                        | February-2021  |                0 |          809190 |             0.00 |
| Australia                        | March-2021     |                0 |          903649 |             0.00 |
| Australia                        | April-2021     |                1 |          885710 |             0.00 |
| Austria                          | February-2020  |                0 |              19 |             0.00 |
| Austria                          | March-2020     |              128 |           84802 |             0.15 |
| Austria                          | April-2020     |              456 |          417242 |             0.11 |
| Austria                          | May-2020       |               84 |          500479 |             0.02 |
| Austria                          | June-2020      |               37 |          515592 |             0.01 |
| Austria                          | July-2020      |               13 |          600464 |             0.00 |
| Austria                          | August-2020    |               15 |          735971 |             0.00 |
| Austria                          | September-2020 |               66 |         1058863 |             0.01 |
| Austria                          | October-2020   |              310 |         2039236 |             0.02 |
| Austria                          | November-2020  |             2075 |         6048662 |             0.03 |
| Austria                          | December-2020  |             3038 |        10147084 |             0.03 |
| Austria                          | January-2021   |             1499 |        12102376 |             0.01 |
| Austria                          | February-2021  |              840 |        12191179 |             0.01 |
| Austria                          | March-2021     |              778 |        15518627 |             0.01 |
| Austria                          | April-2021     |              866 |        17593916 |             0.00 |
| Azerbaijan                       | March-2020     |                5 |            1928 |             0.26 |
| Azerbaijan                       | April-2020     |               19 |           35353 |             0.05 |
| Azerbaijan                       | May-2020       |               39 |          101560 |             0.04 |
| Azerbaijan                       | June-2020      |              150 |          326549 |             0.05 |
| Azerbaijan                       | July-2020      |              235 |          794844 |             0.03 |
| Azerbaijan                       | August-2020    |               86 |         1065366 |             0.01 |
| Azerbaijan                       | September-2020 |               57 |         1156339 |             0.00 |
| Azerbaijan                       | October-2020   |              139 |         1403733 |             0.01 |
| Azerbaijan                       | November-2020  |              662 |         2434291 |             0.03 |
| Azerbaijan                       | December-2020  |             1249 |         5629069 |             0.02 |
| Azerbaijan                       | January-2021   |              491 |         7006474 |             0.01 |
| Azerbaijan                       | February-2021  |               88 |         6502320 |             0.00 |
| Azerbaijan                       | March-2021     |              347 |         7560926 |             0.00 |
| Azerbaijan                       | April-2021     |              950 |         8816077 |             0.01 |
| Bahamas                          | March-2020     |                0 |              99 |             0.00 |
| Bahamas                          | April-2020     |               11 |            1578 |             0.70 |
| Bahamas                          | May-2020       |                0 |            2933 |             0.00 |
| Bahamas                          | June-2020      |                0 |            3100 |             0.00 |
| Bahamas                          | July-2020      |                3 |            6403 |             0.05 |
| Bahamas                          | August-2020    |               36 |           41780 |             0.09 |
| Bahamas                          | September-2020 |               46 |           93104 |             0.05 |
| Bahamas                          | October-2020   |               48 |          170339 |             0.03 |
| Bahamas                          | November-2020  |               19 |          215718 |             0.01 |
| Bahamas                          | December-2020  |                7 |          238552 |             0.00 |
| Bahamas                          | January-2021   |                6 |          249177 |             0.00 |
| Bahamas                          | February-2021  |                3 |          233940 |             0.00 |
| Bahamas                          | March-2021     |                9 |          271796 |             0.00 |
| Bahamas                          | April-2021     |               11 |          289640 |             0.00 |
| Bahrain                          | February-2020  |                0 |             167 |             0.00 |
| Bahrain                          | March-2020     |                4 |            7765 |             0.05 |
| Bahrain                          | April-2020     |                4 |           48676 |             0.01 |
| Bahrain                          | May-2020       |               11 |          210502 |             0.01 |
| Bahrain                          | June-2020      |               68 |          575360 |             0.01 |
| Bahrain                          | July-2020      |               60 |         1074705 |             0.01 |
| Bahrain                          | August-2020    |               43 |         1447593 |             0.00 |
| Bahrain                          | September-2020 |               61 |         1856231 |             0.00 |
| Bahrain                          | October-2020   |               70 |         2388821 |             0.00 |
| Bahrain                          | November-2020  |               20 |         2539313 |             0.00 |
| Bahrain                          | December-2020  |               11 |         2780573 |             0.00 |
| Bahrain                          | January-2021   |               23 |         3022735 |             0.00 |
| Bahrain                          | February-2021  |               74 |         3165005 |             0.00 |
| Bahrain                          | March-2021     |               72 |         4119520 |             0.00 |
| Bahrain                          | April-2021     |              125 |         4837969 |             0.00 |
| Bangladesh                       | March-2020     |                5 |             546 |             0.92 |
| Bangladesh                       | April-2020     |              163 |           70283 |             0.23 |
| Bangladesh                       | May-2020       |              482 |          731311 |             0.07 |
| Bangladesh                       | June-2020      |             1197 |         2836656 |             0.04 |
| Bangladesh                       | July-2020      |             1264 |         6049862 |             0.02 |
| Bangladesh                       | August-2020    |             1170 |         8565945 |             0.01 |
| Bangladesh                       | September-2020 |              970 |        10232791 |             0.01 |
| Bangladesh                       | October-2020   |              672 |        11965030 |             0.01 |
| Bangladesh                       | November-2020  |              721 |        13055589 |             0.01 |
| Bangladesh                       | December-2020  |              915 |        15301465 |             0.01 |
| Bangladesh                       | January-2021   |              568 |        16311378 |             0.00 |
| Bangladesh                       | February-2021  |              281 |        15145689 |             0.00 |
| Bangladesh                       | March-2021     |              638 |        17583288 |             0.00 |
| Bangladesh                       | April-2021     |             2404 |        21032790 |             0.01 |
| Barbados                         | March-2020     |                0 |             255 |             0.00 |
| Barbados                         | April-2020     |                7 |            2071 |             0.34 |
| Barbados                         | May-2020       |                0 |            2697 |             0.00 |
| Barbados                         | June-2020      |                0 |            2860 |             0.00 |
| Barbados                         | July-2020      |                0 |            3209 |             0.00 |
| Barbados                         | August-2020    |                0 |            4654 |             0.00 |
| Barbados                         | September-2020 |                0 |            5515 |             0.00 |
| Barbados                         | October-2020   |                0 |            6692 |             0.00 |
| Barbados                         | November-2020  |                0 |            7563 |             0.00 |
| Barbados                         | December-2020  |                0 |            9713 |             0.00 |
| Barbados                         | January-2021   |                7 |           32342 |             0.02 |
| Barbados                         | February-2021  |               19 |           63279 |             0.03 |
| Barbados                         | March-2021     |                9 |          106483 |             0.01 |
| Barbados                         | April-2021     |                2 |          112693 |             0.00 |
| Belarus                          | February-2020  |                0 |               2 |             0.00 |
| Belarus                          | March-2020     |                1 |            1465 |             0.07 |
| Belarus                          | April-2020     |               88 |          150554 |             0.06 |
| Belarus                          | May-2020       |              146 |          888892 |             0.02 |
| Belarus                          | June-2020      |              157 |         1626878 |             0.01 |
| Belarus                          | July-2020      |              167 |         2029325 |             0.01 |
| Belarus                          | August-2020    |              122 |         2159686 |             0.01 |
| Belarus                          | September-2020 |              152 |         2246305 |             0.01 |
| Belarus                          | October-2020   |              147 |         2701983 |             0.01 |
| Belarus                          | November-2020  |              178 |         3481029 |             0.01 |
| Belarus                          | December-2020  |              266 |         5144839 |             0.01 |
| Belarus                          | January-2021   |              294 |         6908021 |             0.00 |
| Belarus                          | February-2021  |              258 |         7520716 |             0.00 |
| Belarus                          | March-2021     |              271 |         9451715 |             0.00 |
| Belarus                          | April-2021     |              295 |        10229519 |             0.00 |
| Belgium                          | February-2020  |                0 |              26 |             0.00 |
| Belgium                          | March-2020     |              705 |           89009 |             0.79 |
| Belgium                          | April-2020     |             6889 |          993613 |             0.69 |
| Belgium                          | May-2020       |             1873 |         1688377 |             0.11 |
| Belgium                          | June-2020      |              280 |         1801706 |             0.02 |
| Belgium                          | July-2020      |               94 |         1979139 |             0.00 |
| Belgium                          | August-2020    |               54 |         2409779 |             0.00 |
| Belgium                          | September-2020 |              121 |         2955815 |             0.00 |
| Belgium                          | October-2020   |             1609 |         7060830 |             0.02 |
| Belgium                          | November-2020  |             5020 |        15807456 |             0.03 |
| Belgium                          | December-2020  |             2883 |        19046283 |             0.02 |
| Belgium                          | January-2021   |             1564 |        20983559 |             0.01 |
| Belgium                          | February-2021  |              985 |        20733707 |             0.00 |
| Belgium                          | March-2021     |              939 |        25421637 |             0.00 |
| Belgium                          | April-2021     |             1214 |        28207302 |             0.00 |
| Belize                           | March-2020     |                0 |              18 |             0.00 |
| Belize                           | April-2020     |                2 |             411 |             0.49 |
| Belize                           | May-2020       |                0 |             558 |             0.00 |
| Belize                           | June-2020      |                0 |             633 |             0.00 |
| Belize                           | July-2020      |                0 |            1208 |             0.00 |
| Belize                           | August-2020    |               11 |           13861 |             0.08 |
| Belize                           | September-2020 |               14 |           45432 |             0.03 |
| Belize                           | October-2020   |               32 |           84329 |             0.04 |
| Belize                           | November-2020  |               89 |          142741 |             0.06 |
| Belize                           | December-2020  |              100 |          285706 |             0.04 |
| Belize                           | January-2021   |               53 |          355291 |             0.01 |
| Belize                           | February-2021  |               14 |          340198 |             0.00 |
| Belize                           | March-2021     |                2 |          383735 |             0.00 |
| Belize                           | April-2021     |                6 |          376175 |             0.00 |
| Benin                            | March-2020     |                0 |              68 |             0.00 |
| Benin                            | April-2020     |                1 |            1178 |             0.08 |
| Benin                            | May-2020       |                2 |            6566 |             0.03 |
| Benin                            | June-2020      |               18 |           17757 |             0.10 |
| Benin                            | July-2020      |               15 |           46022 |             0.03 |
| Benin                            | August-2020    |                4 |           62855 |             0.01 |
| Benin                            | September-2020 |                1 |           68013 |             0.00 |
| Benin                            | October-2020   |                0 |           76944 |             0.00 |
| Benin                            | November-2020  |                2 |           85621 |             0.00 |
| Benin                            | December-2020  |                1 |           97112 |             0.00 |
| Benin                            | January-2021   |                8 |          107836 |             0.01 |
| Benin                            | February-2021  |               18 |          133911 |             0.01 |
| Benin                            | March-2021     |               20 |          203298 |             0.01 |
| Benin                            | April-2021     |                9 |          227170 |             0.00 |
| Bermuda                          | January-2021   |                0 |               0 |             NULL |
| Bermuda                          | February-2021  |                0 |               0 |             NULL |
| Bermuda                          | March-2021     |                0 |               0 |             NULL |
| Bermuda                          | April-2021     |                0 |               0 |             NULL |
| Bhutan                           | March-2020     |                0 |              46 |             0.00 |
| Bhutan                           | April-2020     |                0 |             167 |             0.00 |
| Bhutan                           | May-2020       |                0 |             561 |             0.00 |
| Bhutan                           | June-2020      |                0 |            1897 |             0.00 |
| Bhutan                           | July-2020      |                0 |            2700 |             0.00 |
| Bhutan                           | August-2020    |                0 |            4396 |             0.00 |
| Bhutan                           | September-2020 |                0 |            7485 |             0.00 |
| Bhutan                           | October-2020   |                0 |            9919 |             0.00 |
| Bhutan                           | November-2020  |                0 |           11234 |             0.00 |
| Bhutan                           | December-2020  |                0 |           15035 |             0.00 |
| Bhutan                           | January-2021   |                1 |           25294 |             0.00 |
| Bhutan                           | February-2021  |                0 |           24183 |             0.00 |
| Bhutan                           | March-2021     |                0 |           26933 |             0.00 |
| Bhutan                           | April-2021     |                0 |           28670 |             0.00 |
| Bolivia                          | March-2020     |                6 |             682 |             0.88 |
| Bolivia                          | April-2020     |               56 |           14801 |             0.38 |
| Bolivia                          | May-2020       |              251 |          137671 |             0.18 |
| Bolivia                          | June-2020      |              810 |          614758 |             0.13 |
| Bolivia                          | July-2020      |             1854 |         1700323 |             0.11 |
| Bolivia                          | August-2020    |             2050 |         3085662 |             0.07 |
| Bolivia                          | September-2020 |             2938 |         3821303 |             0.08 |
| Bolivia                          | October-2020   |              760 |         4317118 |             0.02 |
| Bolivia                          | November-2020  |              232 |         4298716 |             0.01 |
| Bolivia                          | December-2020  |              208 |         4637462 |             0.00 |
| Bolivia                          | January-2021   |             1214 |         5778389 |             0.02 |
| Bolivia                          | February-2021  |             1270 |         6603704 |             0.02 |
| Bolivia                          | March-2021     |              608 |         8093271 |             0.01 |
| Bolivia                          | April-2021     |              694 |         8619557 |             0.01 |
| Bosnia and Herzegovina           | March-2020     |               13 |            2826 |             0.46 |
| Bosnia and Herzegovina           | April-2020     |               56 |           33408 |             0.17 |
| Bosnia and Herzegovina           | May-2020       |               84 |           68816 |             0.12 |
| Bosnia and Herzegovina           | June-2020      |               33 |           95167 |             0.03 |
| Bosnia and Herzegovina           | July-2020      |              153 |          241630 |             0.06 |
| Bosnia and Herzegovina           | August-2020    |              270 |          494986 |             0.05 |
| Bosnia and Herzegovina           | September-2020 |              247 |          721110 |             0.03 |
| Bosnia and Herzegovina           | October-2020   |              378 |         1082304 |             0.03 |
| Bosnia and Herzegovina           | November-2020  |             1447 |         2143108 |             0.07 |
| Bosnia and Herzegovina           | December-2020  |             1369 |         3166283 |             0.04 |
| Bosnia and Herzegovina           | January-2021   |              629 |         3632102 |             0.02 |
| Bosnia and Herzegovina           | February-2021  |              392 |         3535303 |             0.01 |
| Bosnia and Herzegovina           | March-2021     |             1528 |         4584265 |             0.03 |
| Bosnia and Herzegovina           | April-2021     |             1952 |         5603125 |             0.03 |
| Botswana                         | March-2020     |                1 |               7 |            14.29 |
| Botswana                         | April-2020     |                0 |             437 |             0.00 |
| Botswana                         | May-2020       |                0 |             843 |             0.00 |
| Botswana                         | June-2020      |                0 |            2211 |             0.00 |
| Botswana                         | July-2020      |                1 |           14959 |             0.01 |
| Botswana                         | August-2020    |                4 |           37084 |             0.01 |
| Botswana                         | September-2020 |               10 |           73122 |             0.01 |
| Botswana                         | October-2020   |                8 |          144559 |             0.01 |
| Botswana                         | November-2020  |               10 |          261748 |             0.00 |
| Botswana                         | December-2020  |                8 |          398982 |             0.00 |
| Botswana                         | January-2021   |               92 |          556279 |             0.02 |
| Botswana                         | February-2021  |              176 |          715384 |             0.02 |
| Botswana                         | March-2021     |              258 |         1087347 |             0.02 |
| Botswana                         | April-2021     |              144 |         1315455 |             0.01 |
| Brazil                           | February-2020  |                0 |               5 |             0.00 |
| Brazil                           | March-2020     |              201 |           37127 |             0.54 |
| Brazil                           | April-2020     |             5805 |         1048506 |             0.55 |
| Brazil                           | May-2020       |            23308 |         7944285 |             0.29 |
| Brazil                           | June-2020      |            30280 |        28161222 |             0.11 |
| Brazil                           | July-2020      |            32881 |        62641865 |             0.05 |
| Brazil                           | August-2020    |            28906 |       102903896 |             0.03 |
| Brazil                           | September-2020 |            22571 |       132059962 |             0.02 |
| Brazil                           | October-2020   |            15932 |       160991539 |             0.01 |
| Brazil                           | November-2020  |            13236 |       176837421 |             0.01 |
| Brazil                           | December-2020  |            21829 |       218249737 |             0.01 |
| Brazil                           | January-2021   |            29555 |       261187142 |             0.01 |
| Brazil                           | February-2021  |            30438 |       276456100 |             0.01 |
| Brazil                           | March-2021     |            66573 |       361059664 |             0.02 |
| Brazil                           | April-2021     |            82266 |       412565115 |             0.02 |
| Brunei                           | March-2020     |                1 |            1688 |             0.06 |
| Brunei                           | April-2020     |                0 |            4089 |             0.00 |
| Brunei                           | May-2020       |                1 |            4354 |             0.02 |
| Brunei                           | June-2020      |                1 |            4230 |             0.02 |
| Brunei                           | July-2020      |                0 |            4371 |             0.00 |
| Brunei                           | August-2020    |                0 |            4416 |             0.00 |
| Brunei                           | September-2020 |                0 |            4355 |             0.00 |
| Brunei                           | October-2020   |                0 |            4554 |             0.00 |
| Brunei                           | November-2020  |                0 |            4455 |             0.00 |
| Brunei                           | December-2020  |                0 |            4715 |             0.00 |
| Brunei                           | January-2021   |                0 |            5379 |             0.00 |
| Brunei                           | February-2021  |                0 |            5133 |             0.00 |
| Brunei                           | March-2021     |                0 |            6155 |             0.00 |
| Brunei                           | April-2021     |                0 |            6588 |             0.00 |
| Bulgaria                         | March-2020     |                8 |            3576 |             0.22 |
| Bulgaria                         | April-2020     |               58 |           25790 |             0.22 |
| Bulgaria                         | May-2020       |               74 |           65828 |             0.11 |
| Bulgaria                         | June-2020      |               90 |          105731 |             0.09 |
| Bulgaria                         | July-2020      |              153 |          254933 |             0.06 |
| Bulgaria                         | August-2020    |              246 |          443823 |             0.06 |
| Bulgaria                         | September-2020 |              196 |          552189 |             0.04 |
| Bulgaria                         | October-2020   |              454 |          962977 |             0.05 |
| Bulgaria                         | November-2020  |             2756 |         3044632 |             0.09 |
| Bulgaria                         | December-2020  |             3541 |         5636378 |             0.06 |
| Bulgaria                         | January-2021   |             1469 |         6550706 |             0.02 |
| Bulgaria                         | February-2021  |             1146 |         6492052 |             0.02 |
| Bulgaria                         | March-2021     |             3006 |         9012470 |             0.03 |
| Bulgaria                         | April-2021     |             3202 |        11402304 |             0.03 |
| Burkina Faso                     | March-2020     |               14 |            1901 |             0.74 |
| Burkina Faso                     | April-2020     |               29 |           15230 |             0.19 |
| Burkina Faso                     | May-2020       |               10 |           24013 |             0.04 |
| Burkina Faso                     | June-2020      |                0 |           27120 |             0.00 |
| Burkina Faso                     | July-2020      |                0 |           32311 |             0.00 |
| Burkina Faso                     | August-2020    |                2 |           38874 |             0.01 |
| Burkina Faso                     | September-2020 |                3 |           51159 |             0.01 |
| Burkina Faso                     | October-2020   |                9 |           72258 |             0.01 |
| Burkina Faso                     | November-2020  |                1 |           79775 |             0.00 |
| Burkina Faso                     | December-2020  |               17 |          143616 |             0.01 |
| Burkina Faso                     | January-2021   |               35 |          275921 |             0.01 |
| Burkina Faso                     | February-2021  |               22 |          322977 |             0.01 |
| Burkina Faso                     | March-2021     |                4 |          384211 |             0.00 |
| Burkina Faso                     | April-2021     |               11 |          391736 |             0.00 |
| Burundi                          | March-2020     |                0 |               2 |             0.00 |
| Burundi                          | April-2020     |                1 |             183 |             0.55 |
| Burundi                          | May-2020       |                0 |             889 |             0.00 |
| Burundi                          | June-2020      |                0 |            3219 |             0.00 |
| Burundi                          | July-2020      |                0 |            8597 |             0.00 |
| Burundi                          | August-2020    |                0 |           12907 |             0.00 |
| Burundi                          | September-2020 |                0 |           14171 |             0.00 |
| Burundi                          | October-2020   |                0 |           16650 |             0.00 |
| Burundi                          | November-2020  |                0 |           19096 |             0.00 |
| Burundi                          | December-2020  |                1 |           23099 |             0.00 |
| Burundi                          | January-2021   |                0 |           36863 |             0.00 |
| Burundi                          | February-2021  |                1 |           52468 |             0.00 |
| Burundi                          | March-2021     |                3 |           77229 |             0.00 |
| Burundi                          | April-2021     |                0 |          102093 |             0.00 |
| Cambodia                         | January-2020   |                0 |               5 |             0.00 |
| Cambodia                         | February-2020  |                0 |              29 |             0.00 |
| Cambodia                         | March-2020     |                0 |            1225 |             0.00 |
| Cambodia                         | April-2020     |                0 |            3583 |             0.00 |
| Cambodia                         | May-2020       |                0 |            3804 |             0.00 |
| Cambodia                         | June-2020      |                0 |            3885 |             0.00 |
| Cambodia                         | July-2020      |                0 |            5473 |             0.00 |
| Cambodia                         | August-2020    |                0 |            8173 |             0.00 |
| Cambodia                         | September-2020 |                0 |            8247 |             0.00 |
| Cambodia                         | October-2020   |                0 |            8809 |             0.00 |
| Cambodia                         | November-2020  |                0 |            9085 |             0.00 |
| Cambodia                         | December-2020  |                0 |           11076 |             0.00 |
| Cambodia                         | January-2021   |                0 |           13195 |             0.00 |
| Cambodia                         | February-2021  |                0 |           15201 |             0.00 |
| Cambodia                         | March-2021     |               11 |           46744 |             0.02 |
| Cambodia                         | April-2021     |               82 |          189155 |             0.04 |
| Cameroon                         | March-2020     |                6 |            1067 |             0.56 |
| Cameroon                         | April-2020     |               55 |           30497 |             0.18 |
| Cameroon                         | May-2020       |              130 |          109504 |             0.12 |
| Cameroon                         | June-2020      |              122 |          295083 |             0.04 |
| Cameroon                         | July-2020      |               78 |          477610 |             0.02 |
| Cameroon                         | August-2020    |               20 |          570225 |             0.00 |
| Cameroon                         | September-2020 |                7 |          606411 |             0.00 |
| Cameroon                         | October-2020   |                8 |          662489 |             0.00 |
| Cameroon                         | November-2020  |               11 |          690210 |             0.00 |
| Cameroon                         | December-2020  |               11 |          788845 |             0.00 |
| Cameroon                         | January-2021   |               14 |          867295 |             0.00 |
| Cameroon                         | February-2021  |               89 |          910920 |             0.01 |
| Cameroon                         | March-2021     |              170 |         1255724 |             0.01 |
| Cameroon                         | April-2021     |              386 |         1886280 |             0.02 |
| Canada                           | January-2020   |                0 |              12 |             0.00 |
| Canada                           | February-2020  |                0 |             234 |             0.00 |
| Canada                           | March-2020     |              152 |           52015 |             0.29 |
| Canada                           | April-2020     |             4027 |          929888 |             0.43 |
| Canada                           | May-2020       |             3727 |         2369720 |             0.16 |
| Canada                           | June-2020      |              874 |         3016433 |             0.03 |
| Canada                           | July-2020      |              245 |         3460185 |             0.01 |
| Canada                           | August-2020    |              168 |         3854051 |             0.00 |
| Canada                           | September-2020 |              198 |         4290890 |             0.00 |
| Canada                           | October-2020   |              885 |         6126216 |             0.01 |
| Canada                           | November-2020  |             1963 |         9141329 |             0.02 |
| Canada                           | December-2020  |             3523 |        15031370 |             0.02 |
| Canada                           | January-2021   |             4279 |        21663417 |             0.02 |
| Canada                           | February-2021  |             1949 |        23280680 |             0.01 |
| Canada                           | March-2021     |              970 |        28667193 |             0.00 |
| Canada                           | April-2021     |             1260 |        33242319 |             0.00 |
| Cape Verde                       | March-2020     |                1 |              49 |             2.04 |
| Cape Verde                       | April-2020     |                0 |            1423 |             0.00 |
| Cape Verde                       | May-2020       |                3 |            9336 |             0.03 |
| Cape Verde                       | June-2020      |               11 |           23482 |             0.05 |
| Cape Verde                       | July-2020      |                8 |           58038 |             0.01 |
| Cape Verde                       | August-2020    |               17 |           98700 |             0.02 |
| Cape Verde                       | September-2020 |               20 |          148629 |             0.01 |
| Cape Verde                       | October-2020   |               35 |          232518 |             0.02 |
| Cape Verde                       | November-2020  |               10 |          295451 |             0.00 |
| Cape Verde                       | December-2020  |                8 |          353444 |             0.00 |
| Cape Verde                       | January-2021   |               21 |          399245 |             0.01 |
| Cape Verde                       | February-2021  |               13 |          412799 |             0.00 |
| Cape Verde                       | March-2021     |               21 |          504501 |             0.00 |
| Cape Verde                       | April-2021     |               49 |          604208 |             0.01 |
| Cayman Islands                   | December-2020  |                0 |               0 |             NULL |
| Cayman Islands                   | January-2021   |                0 |               0 |             NULL |
| Cayman Islands                   | February-2021  |                0 |               0 |             NULL |
| Cayman Islands                   | March-2021     |                0 |               0 |             NULL |
| Cayman Islands                   | April-2021     |                0 |               0 |             NULL |
| Central African Republic         | March-2020     |                0 |              41 |             0.00 |
| Central African Republic         | April-2020     |                0 |             444 |             0.00 |
| Central African Republic         | May-2020       |                2 |           11339 |             0.02 |
| Central African Republic         | June-2020      |               45 |           70765 |             0.06 |
| Central African Republic         | July-2020      |               12 |          134487 |             0.01 |
| Central African Republic         | August-2020    |                3 |          144485 |             0.00 |
| Central African Republic         | September-2020 |                0 |          143052 |             0.00 |
| Central African Republic         | October-2020   |                0 |          150498 |             0.00 |
| Central African Republic         | November-2020  |                1 |          146812 |             0.00 |
| Central African Republic         | December-2020  |                0 |          153026 |             0.00 |
| Central African Republic         | January-2021   |                0 |          154155 |             0.00 |
| Central African Republic         | February-2021  |                0 |          139885 |             0.00 |
| Central African Republic         | March-2021     |                4 |          156694 |             0.00 |
| Central African Republic         | April-2021     |               21 |          173004 |             0.01 |
| Chad                             | March-2020     |                0 |              35 |             0.00 |
| Chad                             | April-2020     |                5 |             797 |             0.63 |
| Chad                             | May-2020       |               60 |           14051 |             0.43 |
| Chad                             | June-2020      |                9 |           25427 |             0.04 |
| Chad                             | July-2020      |                1 |           27639 |             0.00 |
| Chad                             | August-2020    |                2 |           29949 |             0.01 |
| Chad                             | September-2020 |                8 |           33155 |             0.02 |
| Chad                             | October-2020   |               13 |           41806 |             0.03 |
| Chad                             | November-2020  |                3 |           47873 |             0.01 |
| Chad                             | December-2020  |                3 |           57171 |             0.01 |
| Chad                             | January-2021   |               14 |           86880 |             0.02 |
| Chad                             | February-2021  |               22 |          102859 |             0.02 |
| Chad                             | March-2021     |               24 |          133784 |             0.02 |
| Chad                             | April-2021     |                6 |          140453 |             0.00 |
| Chile                            | February-2020  |                0 |              14 |             0.00 |
| Chile                            | March-2020     |               12 |           18796 |             0.06 |
| Chile                            | April-2020     |              215 |          285413 |             0.08 |
| Chile                            | May-2020       |              827 |         1763115 |             0.05 |
| Chile                            | June-2020      |             4634 |         6291295 |             0.07 |
| Chile                            | July-2020      |             3769 |         9987599 |             0.04 |
| Chile                            | August-2020    |             1832 |        11936049 |             0.02 |
| Chile                            | September-2020 |             1452 |        13147124 |             0.01 |
| Chile                            | October-2020   |             1466 |        15134758 |             0.01 |
| Chile                            | November-2020  |             1203 |        15945192 |             0.01 |
| Chile                            | December-2020  |             1198 |        17938094 |             0.01 |
| Chile                            | January-2021   |             1844 |        20661911 |             0.01 |
| Chile                            | February-2021  |             2120 |        21754084 |             0.01 |
| Chile                            | March-2021     |             2563 |        28062147 |             0.01 |
| Chile                            | April-2021     |             3218 |        33124646 |             0.01 |
| China                            | January-2020   |              196 |           38008 |             0.52 |
| China                            | February-2020  |             2624 |         1633361 |             0.16 |
| China                            | March-2020     |              472 |         2515426 |             0.02 |
| China                            | April-2020     |             1328 |         2500143 |             0.05 |
| China                            | May-2020       |                1 |         2605281 |             0.00 |
| China                            | June-2020      |                3 |         2532679 |             0.00 |
| China                            | July-2020      |               20 |         2654943 |             0.00 |
| China                            | August-2020    |               62 |         2764441 |             0.00 |
| China                            | September-2020 |               16 |         2707451 |             0.00 |
| China                            | October-2020   |                0 |         2818977 |             0.00 |
| China                            | November-2020  |                4 |         2758806 |             0.00 |
| China                            | December-2020  |               39 |         2931959 |             0.00 |
| China                            | January-2021   |               35 |         3035071 |             0.00 |
| China                            | February-2021  |               18 |         2816372 |             0.00 |
| China                            | March-2021     |                6 |         3143003 |             0.00 |
| China                            | April-2021     |                4 |         3064656 |             0.00 |
| Colombia                         | March-2020     |               16 |            6190 |             0.26 |
| Colombia                         | April-2020     |              277 |          101704 |             0.27 |
| Colombia                         | May-2020       |              646 |          492214 |             0.13 |
| Colombia                         | June-2020      |             2395 |         1745908 |             0.14 |
| Colombia                         | July-2020      |             6771 |         5680255 |             0.12 |
| Colombia                         | August-2020    |             9557 |        14415644 |             0.07 |
| Colombia                         | September-2020 |             6336 |        21951355 |             0.03 |
| Colombia                         | October-2020   |             5316 |        29377177 |             0.02 |
| Colombia                         | November-2020  |             5452 |        35993382 |             0.02 |
| Colombia                         | December-2020  |             6447 |        45578807 |             0.01 |
| Colombia                         | January-2021   |            10770 |        58374546 |             0.02 |
| Colombia                         | February-2021  |             5783 |        61356188 |             0.01 |
| Colombia                         | March-2021     |             3656 |        71861747 |             0.01 |
| Colombia                         | April-2021     |            10298 |        78567887 |             0.01 |
| Comoros                          | April-2020     |                0 |               1 |             0.00 |
| Comoros                          | May-2020       |                2 |            1116 |             0.18 |
| Comoros                          | June-2020      |                5 |            5961 |             0.08 |
| Comoros                          | July-2020      |                0 |           10233 |             0.00 |
| Comoros                          | August-2020    |                0 |           12580 |             0.00 |
| Comoros                          | September-2020 |                0 |           13863 |             0.00 |
| Comoros                          | October-2020   |                0 |           15608 |             0.00 |
| Comoros                          | November-2020  |                0 |           17436 |             0.00 |
| Comoros                          | December-2020  |                3 |           20497 |             0.01 |
| Comoros                          | January-2021   |               83 |           51485 |             0.16 |
| Comoros                          | February-2021  |               51 |           92325 |             0.06 |
| Comoros                          | March-2021     |                2 |          112884 |             0.00 |
| Comoros                          | April-2021     |                0 |          113736 |             0.00 |
| Congo                            | March-2020     |                0 |              97 |             0.00 |
| Congo                            | April-2020     |                9 |            3419 |             0.26 |
| Congo                            | May-2020       |               11 |           12105 |             0.09 |
| Congo                            | June-2020      |               17 |           25460 |             0.07 |
| Congo                            | July-2020      |               17 |           73328 |             0.02 |
| Congo                            | August-2020    |               24 |          116513 |             0.02 |
| Congo                            | September-2020 |               11 |          146292 |             0.01 |
| Congo                            | October-2020   |                3 |          159997 |             0.00 |
| Congo                            | November-2020  |                2 |          165519 |             0.00 |
| Congo                            | December-2020  |               14 |          193968 |             0.01 |
| Congo                            | January-2021   |                9 |          232416 |             0.00 |
| Congo                            | February-2021  |               11 |          234475 |             0.00 |
| Congo                            | March-2021     |                7 |          290998 |             0.00 |
| Congo                            | April-2021     |                9 |          304069 |             0.00 |
| Costa Rica                       | March-2020     |                2 |            2987 |             0.07 |
| Costa Rica                       | April-2020     |                4 |           17866 |             0.02 |
| Costa Rica                       | May-2020       |                4 |           26697 |             0.01 |
| Costa Rica                       | June-2020      |                6 |           58319 |             0.01 |
| Costa Rica                       | July-2020      |              134 |          309536 |             0.04 |
| Costa Rica                       | August-2020    |              286 |          890542 |             0.03 |
| Costa Rica                       | September-2020 |              468 |         1771225 |             0.03 |
| Costa Rica                       | October-2020   |              481 |         2901099 |             0.02 |
| Costa Rica                       | November-2020  |              341 |         3734891 |             0.01 |
| Costa Rica                       | December-2020  |              459 |         4796194 |             0.01 |
| Costa Rica                       | January-2021   |              419 |         5681017 |             0.01 |
| Costa Rica                       | February-2021  |              196 |         5594208 |             0.00 |
| Costa Rica                       | March-2021     |              157 |         6522718 |             0.00 |
| Costa Rica                       | April-2021     |              274 |         6872891 |             0.00 |
| Croatia                          | February-2020  |                0 |              18 |             0.00 |
| Croatia                          | March-2020     |                6 |            6404 |             0.09 |
| Croatia                          | April-2020     |               63 |           49646 |             0.13 |
| Croatia                          | May-2020       |               34 |           68134 |             0.05 |
| Croatia                          | June-2020      |                4 |           70331 |             0.01 |
| Croatia                          | July-2020      |               38 |          124811 |             0.03 |
| Croatia                          | August-2020    |               41 |          217353 |             0.02 |
| Croatia                          | September-2020 |               94 |          415353 |             0.02 |
| Croatia                          | October-2020   |              266 |          831572 |             0.03 |
| Croatia                          | November-2020  |             1240 |         2599232 |             0.05 |
| Croatia                          | December-2020  |             2134 |         5539120 |             0.04 |
| Croatia                          | January-2021   |             1107 |         6921173 |             0.02 |
| Croatia                          | February-2021  |              499 |         6657593 |             0.01 |
| Croatia                          | March-2021     |              421 |         7881286 |             0.01 |
| Croatia                          | April-2021     |             1134 |         9063636 |             0.01 |
| Cuba                             | March-2020     |                6 |            1020 |             0.59 |
| Cuba                             | April-2020     |               55 |           25438 |             0.22 |
| Cuba                             | May-2020       |               22 |           56950 |             0.04 |
| Cuba                             | June-2020      |                3 |           67429 |             0.00 |
| Cuba                             | July-2020      |                1 |           75857 |             0.00 |
| Cuba                             | August-2020    |                7 |          102621 |             0.01 |
| Cuba                             | September-2020 |               28 |          145208 |             0.02 |
| Cuba                             | October-2020   |                6 |          192396 |             0.00 |
| Cuba                             | November-2020  |                7 |          228288 |             0.00 |
| Cuba                             | December-2020  |               11 |          305830 |             0.00 |
| Cuba                             | January-2021   |               68 |          554408 |             0.01 |
| Cuba                             | February-2021  |              108 |         1088096 |             0.01 |
| Cuba                             | March-2021     |              102 |         1949383 |             0.01 |
| Cuba                             | April-2021     |              220 |         2738557 |             0.01 |
| Curacao                          | March-2021     |                0 |               0 |             NULL |
| Curacao                          | April-2021     |                0 |               0 |             NULL |
| Cyprus                           | February-2020  |                0 |               0 |             NULL |
| Cyprus                           | March-2020     |                8 |            2089 |             0.38 |
| Cyprus                           | April-2020     |                7 |           19846 |             0.04 |
| Cyprus                           | May-2020       |                2 |           28209 |             0.01 |
| Cyprus                           | June-2020      |                2 |           29366 |             0.01 |
| Cyprus                           | July-2020      |                0 |           32017 |             0.00 |
| Cyprus                           | August-2020    |                1 |           41372 |             0.00 |
| Cyprus                           | September-2020 |                2 |           47357 |             0.00 |
| Cyprus                           | October-2020   |                4 |           82890 |             0.00 |
| Cyprus                           | November-2020  |               23 |          222920 |             0.01 |
| Cyprus                           | December-2020  |               70 |          500151 |             0.01 |
| Cyprus                           | January-2021   |               80 |          872089 |             0.01 |
| Cyprus                           | February-2021  |               32 |          913382 |             0.00 |
| Cyprus                           | March-2021     |               25 |         1250242 |             0.00 |
| Cyprus                           | April-2021     |               52 |         1655891 |             0.00 |
| Czechia                          | March-2020     |               31 |           25984 |             0.12 |
| Czechia                          | April-2020     |              205 |          184001 |             0.11 |
| Czechia                          | May-2020       |               84 |          262979 |             0.03 |
| Czechia                          | June-2020      |               29 |          307889 |             0.01 |
| Czechia                          | July-2020      |               33 |          430742 |             0.01 |
| Czechia                          | August-2020    |               42 |          628547 |             0.01 |
| Czechia                          | September-2020 |              231 |         1304611 |             0.02 |
| Czechia                          | October-2020   |             2596 |         5443207 |             0.05 |
| Czechia                          | November-2020  |             5044 |        13617115 |             0.04 |
| Czechia                          | December-2020  |             3285 |        18743896 |             0.02 |
| Czechia                          | January-2021   |             4728 |        26959120 |             0.02 |
| Czechia                          | February-2021  |             4031 |        30777715 |             0.01 |
| Czechia                          | March-2021     |             6082 |        43611257 |             0.01 |
| Czechia                          | April-2021     |             2846 |        47718289 |             0.01 |
| Democratic Republic of Congo     | March-2020     |                8 |             642 |             1.25 |
| Democratic Republic of Congo     | April-2020     |               23 |            8639 |             0.27 |
| Democratic Republic of Congo     | May-2020       |               41 |           48228 |             0.09 |
| Democratic Republic of Congo     | June-2020      |               98 |          152518 |             0.06 |
| Democratic Republic of Congo     | July-2020      |               45 |          253461 |             0.02 |
| Democratic Republic of Congo     | August-2020    |               43 |          298422 |             0.01 |
| Democratic Republic of Congo     | September-2020 |               14 |          312145 |             0.00 |
| Democratic Republic of Congo     | October-2020   |               35 |          340349 |             0.01 |
| Democratic Republic of Congo     | November-2020  |               26 |          357658 |             0.01 |
| Democratic Republic of Congo     | December-2020  |              258 |          465473 |             0.06 |
| Democratic Republic of Congo     | January-2021   |               80 |          633392 |             0.01 |
| Democratic Republic of Congo     | February-2021  |               36 |          682090 |             0.01 |
| Democratic Republic of Congo     | March-2021     |               36 |          841033 |             0.00 |
| Democratic Republic of Congo     | April-2021     |               23 |          867489 |             0.00 |
| Denmark                          | February-2020  |                0 |               5 |             0.00 |
| Denmark                          | March-2020     |               90 |           32722 |             0.28 |
| Denmark                          | April-2020     |              362 |          203547 |             0.18 |
| Denmark                          | May-2020       |              122 |          338822 |             0.04 |
| Denmark                          | June-2020      |               31 |          373368 |             0.01 |
| Denmark                          | July-2020      |               10 |          414692 |             0.00 |
| Denmark                          | August-2020    |                9 |          490789 |             0.00 |
| Denmark                          | September-2020 |               26 |          658184 |             0.00 |
| Denmark                          | October-2020   |               71 |         1116242 |             0.01 |
| Denmark                          | November-2020  |              116 |         1916850 |             0.01 |
| Denmark                          | December-2020  |              461 |         3767540 |             0.01 |
| Denmark                          | January-2021   |              828 |         5785270 |             0.01 |
| Denmark                          | February-2021  |              236 |         5754590 |             0.00 |
| Denmark                          | March-2021     |               58 |         6880888 |             0.00 |
| Denmark                          | April-2021     |               64 |         7249735 |             0.00 |
| Djibouti                         | March-2020     |                0 |             125 |             0.00 |
| Djibouti                         | April-2020     |                2 |           16283 |             0.01 |
| Djibouti                         | May-2020       |               22 |           54254 |             0.04 |
| Djibouti                         | June-2020      |               30 |          132173 |             0.02 |
| Djibouti                         | July-2020      |                4 |          153695 |             0.00 |
| Djibouti                         | August-2020    |                2 |          165639 |             0.00 |
| Djibouti                         | September-2020 |                1 |          161960 |             0.00 |
| Djibouti                         | October-2020   |                0 |          169641 |             0.00 |
| Djibouti                         | November-2020  |                0 |          169185 |             0.00 |
| Djibouti                         | December-2020  |                0 |          178378 |             0.00 |
| Djibouti                         | January-2021   |                2 |          182684 |             0.00 |
| Djibouti                         | February-2021  |                0 |          167737 |             0.00 |
| Djibouti                         | March-2021     |                7 |          203948 |             0.00 |
| Djibouti                         | April-2021     |               73 |          300878 |             0.02 |
| Dominica                         | March-2020     |                0 |              79 |             0.00 |
| Dominica                         | April-2020     |                0 |             460 |             0.00 |
| Dominica                         | May-2020       |                0 |             496 |             0.00 |
| Dominica                         | June-2020      |                0 |             538 |             0.00 |
| Dominica                         | July-2020      |                0 |             558 |             0.00 |
| Dominica                         | August-2020    |                0 |             576 |             0.00 |
| Dominica                         | September-2020 |                0 |             718 |             0.00 |
| Dominica                         | October-2020   |                0 |            1061 |             0.00 |
| Dominica                         | November-2020  |                0 |            2033 |             0.00 |
| Dominica                         | December-2020  |                0 |            2696 |             0.00 |
| Dominica                         | January-2021   |                0 |            3325 |             0.00 |
| Dominica                         | February-2021  |                0 |            3612 |             0.00 |
| Dominica                         | March-2021     |                0 |            4761 |             0.00 |
| Dominica                         | April-2021     |                0 |            5029 |             0.00 |
| Dominican Republic               | March-2020     |               51 |            6140 |             0.83 |
| Dominican Republic               | April-2020     |              250 |          115932 |             0.22 |
| Dominican Republic               | May-2020       |              201 |          376401 |             0.05 |
| Dominican Republic               | June-2020      |              245 |          721962 |             0.03 |
| Dominican Republic               | July-2020      |              413 |         1543434 |             0.03 |
| Dominican Republic               | August-2020    |              550 |         2630788 |             0.02 |
| Dominican Republic               | September-2020 |              395 |         3143556 |             0.01 |
| Dominican Republic               | October-2020   |              140 |         3727191 |             0.00 |
| Dominican Republic               | November-2020  |               86 |         4036491 |             0.00 |
| Dominican Republic               | December-2020  |               83 |         4864830 |             0.00 |
| Dominican Republic               | January-2021   |              252 |         5941766 |             0.00 |
| Dominican Republic               | February-2021  |              434 |         6413645 |             0.01 |
| Dominican Republic               | March-2021     |              225 |         7652946 |             0.00 |
| Dominican Republic               | April-2021     |              155 |         7794798 |             0.00 |
| Ecuador                          | March-2020     |               75 |           16469 |             0.46 |
| Ecuador                          | April-2020     |              825 |          321161 |             0.26 |
| Ecuador                          | May-2020       |             2458 |         1029314 |             0.24 |
| Ecuador                          | June-2020      |             1169 |         1429745 |             0.08 |
| Ecuador                          | July-2020      |             1175 |         2217004 |             0.05 |
| Ecuador                          | August-2020    |              854 |         3121790 |             0.03 |
| Ecuador                          | September-2020 |             4799 |         3678159 |             0.13 |
| Ecuador                          | October-2020   |             1315 |         4714534 |             0.03 |
| Ecuador                          | November-2020  |              791 |         5411330 |             0.01 |
| Ecuador                          | December-2020  |              573 |         6306084 |             0.01 |
| Ecuador                          | January-2021   |              825 |         7125483 |             0.01 |
| Ecuador                          | February-2021  |              952 |         7472445 |             0.01 |
| Ecuador                          | March-2021     |             1036 |         9480656 |             0.01 |
| Ecuador                          | April-2021     |             1784 |        10654344 |             0.02 |
| Egypt                            | February-2020  |                0 |              16 |             0.00 |
| Egypt                            | March-2020     |               46 |            7140 |             0.64 |
| Egypt                            | April-2020     |              346 |           83386 |             0.41 |
| Egypt                            | May-2020       |              567 |          403993 |             0.14 |
| Egypt                            | June-2020      |             1994 |         1406847 |             0.14 |
| Egypt                            | July-2020      |             1852 |         2615575 |             0.07 |
| Egypt                            | August-2020    |              616 |         2991066 |             0.02 |
| Egypt                            | September-2020 |              509 |         3038840 |             0.02 |
| Egypt                            | October-2020   |              336 |         3263459 |             0.01 |
| Egypt                            | November-2020  |              384 |         3339298 |             0.01 |
| Egypt                            | December-2020  |              981 |         3859859 |             0.03 |
| Egypt                            | January-2021   |             1685 |         4792291 |             0.04 |
| Egypt                            | February-2021  |             1372 |         4878915 |             0.03 |
| Egypt                            | March-2021     |             1307 |         5961213 |             0.02 |
| Egypt                            | April-2021     |             1344 |         6435218 |             0.02 |
| El Salvador                      | March-2020     |                1 |             156 |             0.64 |
| El Salvador                      | April-2020     |                9 |            5333 |             0.17 |
| El Salvador                      | May-2020       |               36 |           41262 |             0.09 |
| El Salvador                      | June-2020      |              128 |          122784 |             0.10 |
| El Salvador                      | July-2020      |              274 |          347650 |             0.08 |
| El Salvador                      | August-2020    |              269 |          692113 |             0.04 |
| El Salvador                      | September-2020 |              126 |          819156 |             0.02 |
| El Salvador                      | October-2020   |              132 |          969372 |             0.01 |
| El Salvador                      | November-2020  |              139 |         1095940 |             0.01 |
| El Salvador                      | December-2020  |              213 |         1318177 |             0.02 |
| El Salvador                      | January-2021   |              296 |         1573181 |             0.02 |
| El Salvador                      | February-2021  |              231 |         1619262 |             0.01 |
| El Salvador                      | March-2021     |              152 |         1939285 |             0.01 |
| El Salvador                      | April-2021     |              118 |         2010965 |             0.01 |
| Equatorial Guinea                | March-2020     |                0 |             130 |             0.00 |
| Equatorial Guinea                | April-2020     |                1 |            2867 |             0.03 |
| Equatorial Guinea                | May-2020       |               11 |           21842 |             0.05 |
| Equatorial Guinea                | June-2020      |               20 |           46572 |             0.04 |
| Equatorial Guinea                | July-2020      |               51 |           95881 |             0.05 |
| Equatorial Guinea                | August-2020    |                0 |          150812 |             0.00 |
| Equatorial Guinea                | September-2020 |                0 |          149975 |             0.00 |
| Equatorial Guinea                | October-2020   |                0 |          157079 |             0.00 |
| Equatorial Guinea                | November-2020  |                2 |          153445 |             0.00 |
| Equatorial Guinea                | December-2020  |                1 |          161321 |             0.00 |
| Equatorial Guinea                | January-2021   |                0 |          166183 |             0.00 |
| Equatorial Guinea                | February-2021  |                5 |          159963 |             0.00 |
| Equatorial Guinea                | March-2021     |               11 |          203858 |             0.01 |
| Equatorial Guinea                | April-2021     |               10 |          219014 |             0.00 |
| Eritrea                          | March-2020     |                0 |              65 |             0.00 |
| Eritrea                          | April-2020     |                0 |            1027 |             0.00 |
| Eritrea                          | May-2020       |                0 |            1209 |             0.00 |
| Eritrea                          | June-2020      |                0 |            3083 |             0.00 |
| Eritrea                          | July-2020      |                0 |            7490 |             0.00 |
| Eritrea                          | August-2020    |                0 |            9178 |             0.00 |
| Eritrea                          | September-2020 |                0 |           10664 |             0.00 |
| Eritrea                          | October-2020   |                0 |           13346 |             0.00 |
| Eritrea                          | November-2020  |                0 |           15545 |             0.00 |
| Eritrea                          | December-2020  |                3 |           24769 |             0.01 |
| Eritrea                          | January-2021   |                4 |           54320 |             0.01 |
| Eritrea                          | February-2021  |                0 |           70980 |             0.00 |
| Eritrea                          | March-2021     |                3 |           95058 |             0.00 |
| Eritrea                          | April-2021     |                0 |          104836 |             0.00 |
| Estonia                          | February-2020  |                0 |               3 |             0.00 |
| Estonia                          | March-2020     |                4 |            7350 |             0.05 |
| Estonia                          | April-2020     |               48 |           41075 |             0.12 |
| Estonia                          | May-2020       |               16 |           55005 |             0.03 |
| Estonia                          | June-2020      |                1 |           58725 |             0.00 |
| Estonia                          | July-2020      |                0 |           62542 |             0.00 |
| Estonia                          | August-2020    |               -5 |           68481 |            -0.01 |
| Estonia                          | September-2020 |                0 |           83987 |             0.00 |
| Estonia                          | October-2020   |                9 |          125799 |             0.01 |
| Estonia                          | November-2020  |               45 |          241995 |             0.02 |
| Estonia                          | December-2020  |              111 |          612913 |             0.02 |
| Estonia                          | January-2021   |              190 |         1127645 |             0.02 |
| Estonia                          | February-2021  |              170 |         1495578 |             0.01 |
| Estonia                          | March-2021     |              313 |         2713051 |             0.01 |
| Estonia                          | April-2021     |              259 |         3472209 |             0.01 |
| Eswatini                         | March-2020     |                0 |              75 |             0.00 |
| Eswatini                         | April-2020     |                1 |             843 |             0.12 |
| Eswatini                         | May-2020       |                1 |            6137 |             0.02 |
| Eswatini                         | June-2020      |                9 |           15782 |             0.06 |
| Eswatini                         | July-2020      |               30 |           50503 |             0.06 |
| Eswatini                         | August-2020    |               50 |          115702 |             0.04 |
| Eswatini                         | September-2020 |               18 |          153585 |             0.01 |
| Eswatini                         | October-2020   |                8 |          177725 |             0.00 |
| Eswatini                         | November-2020  |                5 |          183907 |             0.00 |
| Eswatini                         | December-2020  |               83 |          227464 |             0.04 |
| Eswatini                         | January-2021   |              360 |          394910 |             0.09 |
| Eswatini                         | February-2021  |               87 |          462296 |             0.02 |
| Eswatini                         | March-2021     |               15 |          534337 |             0.00 |
| Eswatini                         | April-2021     |                4 |          541073 |             0.00 |
| Ethiopia                         | March-2020     |                0 |             203 |             0.00 |
| Ethiopia                         | April-2020     |                3 |            2558 |             0.12 |
| Ethiopia                         | May-2020       |                8 |           12773 |             0.06 |
| Ethiopia                         | June-2020      |               92 |          106607 |             0.09 |
| Ethiopia                         | July-2020      |              171 |          300942 |             0.06 |
| Ethiopia                         | August-2020    |              535 |          998557 |             0.05 |
| Ethiopia                         | September-2020 |              389 |         1964723 |             0.02 |
| Ethiopia                         | October-2020   |              271 |         2703736 |             0.01 |
| Ethiopia                         | November-2020  |              237 |         3089373 |             0.01 |
| Ethiopia                         | December-2020  |              217 |         3653211 |             0.01 |
| Ethiopia                         | January-2021   |              170 |         4052409 |             0.00 |
| Ethiopia                         | February-2021  |              272 |         4140296 |             0.01 |
| Ethiopia                         | March-2021     |              500 |         5589105 |             0.01 |
| Ethiopia                         | April-2021     |              823 |         7079762 |             0.01 |
| Faeroe Islands                   | January-2021   |                0 |               0 |             NULL |
| Faeroe Islands                   | February-2021  |                0 |               0 |             NULL |
| Faeroe Islands                   | March-2021     |                0 |               0 |             NULL |
| Faeroe Islands                   | April-2021     |                0 |               0 |             NULL |
| Falkland Islands                 | February-2021  |                0 |               0 |             NULL |
| Falkland Islands                 | March-2021     |                0 |               0 |             NULL |
| Falkland Islands                 | April-2021     |                0 |               0 |             NULL |
| Fiji                             | January-2020   |                0 |               0 |             NULL |
| Fiji                             | February-2020  |                0 |               0 |             NULL |
| Fiji                             | March-2020     |                0 |              47 |             0.00 |
| Fiji                             | April-2020     |                0 |             464 |             0.00 |
| Fiji                             | May-2020       |                0 |             558 |             0.00 |
| Fiji                             | June-2020      |                0 |             540 |             0.00 |
| Fiji                             | July-2020      |                1 |             765 |             0.13 |
| Fiji                             | August-2020    |                1 |             856 |             0.12 |
| Fiji                             | September-2020 |                0 |             944 |             0.00 |
| Fiji                             | October-2020   |                0 |            1006 |             0.00 |
| Fiji                             | November-2020  |                0 |            1065 |             0.00 |
| Fiji                             | December-2020  |                0 |            1405 |             0.00 |
| Fiji                             | January-2021   |                0 |            1659 |             0.00 |
| Fiji                             | February-2021  |                0 |            1577 |             0.00 |
| Fiji                             | March-2021     |                0 |            2031 |             0.00 |
| Fiji                             | April-2021     |                0 |            2357 |             0.00 |
| Finland                          | January-2020   |                0 |               3 |             0.00 |
| Finland                          | February-2020  |                0 |              34 |             0.00 |
| Finland                          | March-2020     |               17 |           13382 |             0.13 |
| Finland                          | April-2020     |              194 |           99473 |             0.20 |
| Finland                          | May-2020       |              109 |          190615 |             0.06 |
| Finland                          | June-2020      |                8 |          212396 |             0.00 |
| Finland                          | July-2020      |                1 |          226937 |             0.00 |
| Finland                          | August-2020    |                7 |          240361 |             0.00 |
| Finland                          | September-2020 |                8 |          265431 |             0.00 |
| Finland                          | October-2020   |               14 |          403740 |             0.00 |
| Finland                          | November-2020  |               41 |          596628 |             0.01 |
| Finland                          | December-2020  |              162 |          973027 |             0.02 |
| Finland                          | January-2021   |              110 |         1250210 |             0.01 |
| Finland                          | February-2021  |               71 |         1425623 |             0.00 |
| Finland                          | March-2021     |              102 |         2109166 |             0.00 |
| Finland                          | April-2021     |               70 |         2491149 |             0.00 |
| France                           | January-2020   |                0 |              30 |             0.00 |
| France                           | February-2020  |                2 |             466 |             0.43 |
| France                           | March-2020     |             3524 |          407938 |             0.86 |
| France                           | April-2020     |            20823 |         3456319 |             0.60 |
| France                           | May-2020       |             4456 |         5602193 |             0.08 |
| France                           | June-2020      |             1041 |         5922508 |             0.02 |
| France                           | July-2020      |              422 |         6640187 |             0.01 |
| France                           | August-2020    |              378 |         8150489 |             0.00 |
| France                           | September-2020 |             1332 |        13600511 |             0.01 |
| France                           | October-2020   |             4849 |        28773948 |             0.02 |
| France                           | November-2020  |            15992 |        59733195 |             0.03 |
| France                           | December-2020  |            11940 |        76678082 |             0.02 |
| France                           | January-2021   |            11442 |        91573599 |             0.01 |
| France                           | February-2021  |            10379 |        98925593 |             0.01 |
| France                           | March-2021     |             9218 |       130615782 |             0.01 |
| France                           | April-2021     |             8877 |       157155770 |             0.01 |
| Gabon                            | March-2020     |                1 |              86 |             1.16 |
| Gabon                            | April-2020     |                2 |            3106 |             0.06 |
| Gabon                            | May-2020       |               14 |           40885 |             0.03 |
| Gabon                            | June-2020      |               25 |          120239 |             0.02 |
| Gabon                            | July-2020      |                7 |          195607 |             0.00 |
| Gabon                            | August-2020    |                4 |          252682 |             0.00 |
| Gabon                            | September-2020 |                1 |          259821 |             0.00 |
| Gabon                            | October-2020   |                1 |          275060 |             0.00 |
| Gabon                            | November-2020  |                5 |          272546 |             0.00 |
| Gabon                            | December-2020  |                4 |          290679 |             0.00 |
| Gabon                            | January-2021   |                4 |          310352 |             0.00 |
| Gabon                            | February-2021  |               15 |          356809 |             0.00 |
| Gabon                            | March-2021     |               35 |          529781 |             0.01 |
| Gabon                            | April-2021     |               21 |          641075 |             0.00 |
| Gambia                           | March-2020     |                1 |              35 |             2.86 |
| Gambia                           | April-2020     |                0 |             233 |             0.00 |
| Gambia                           | May-2020       |                0 |             680 |             0.00 |
| Gambia                           | June-2020      |                1 |            1016 |             0.10 |
| Gambia                           | July-2020      |                7 |            4434 |             0.16 |
| Gambia                           | August-2020    |               87 |           56688 |             0.15 |
| Gambia                           | September-2020 |               16 |          101729 |             0.02 |
| Gambia                           | October-2020   |                7 |          112779 |             0.01 |
| Gambia                           | November-2020  |                4 |          111147 |             0.00 |
| Gambia                           | December-2020  |                1 |          117237 |             0.00 |
| Gambia                           | January-2021   |                4 |          121312 |             0.00 |
| Gambia                           | February-2021  |               22 |          123614 |             0.02 |
| Gambia                           | March-2021     |               15 |          156651 |             0.01 |
| Gambia                           | April-2021     |                9 |          170688 |             0.01 |
| Georgia                          | February-2020  |                0 |               4 |             0.00 |
| Georgia                          | March-2020     |                0 |            1256 |             0.00 |
| Georgia                          | April-2020     |                6 |            9767 |             0.06 |
| Georgia                          | May-2020       |                6 |           20931 |             0.03 |
| Georgia                          | June-2020      |                3 |           25966 |             0.01 |
| Georgia                          | July-2020      |                2 |           31917 |             0.01 |
| Georgia                          | August-2020    |                2 |           41023 |             0.00 |
| Georgia                          | September-2020 |               20 |           91939 |             0.02 |
| Georgia                          | October-2020   |              268 |          573395 |             0.05 |
| Georgia                          | November-2020  |              960 |         2505524 |             0.04 |
| Georgia                          | December-2020  |             1238 |         5970896 |             0.02 |
| Georgia                          | January-2021   |              673 |         7590826 |             0.01 |
| Georgia                          | February-2021  |              332 |         7429803 |             0.00 |
| Georgia                          | March-2021     |              268 |         8552929 |             0.00 |
| Georgia                          | April-2021     |              332 |         8819854 |             0.00 |
| Germany                          | January-2020   |                0 |              18 |             0.00 |
| Germany                          | February-2020  |                0 |             561 |             0.00 |
| Germany                          | March-2020     |              775 |          588179 |             0.13 |
| Germany                          | April-2020     |             5848 |         3942925 |             0.15 |
| Germany                          | May-2020       |             1917 |         5427815 |             0.04 |
| Germany                          | June-2020      |              450 |         5670762 |             0.01 |
| Germany                          | July-2020      |              157 |         6265079 |             0.00 |
| Germany                          | August-2020    |              156 |         7024733 |             0.00 |
| Germany                          | September-2020 |              192 |         8023521 |             0.00 |
| Germany                          | October-2020   |              988 |        11653042 |             0.01 |
| Germany                          | November-2020  |             6211 |        24564361 |             0.03 |
| Germany                          | December-2020  |            17097 |        44141683 |             0.04 |
| Germany                          | January-2021   |            23372 |        62555458 |             0.04 |
| Germany                          | February-2021  |            12989 |        65660655 |             0.02 |
| Germany                          | March-2021     |             6437 |        81277883 |             0.01 |
| Germany                          | April-2021     |             6508 |        93513080 |             0.01 |
| Ghana                            | March-2020     |                5 |            1146 |             0.44 |
| Ghana                            | April-2020     |               12 |           24029 |             0.05 |
| Ghana                            | May-2020       |               19 |          164583 |             0.01 |
| Ghana                            | June-2020      |               76 |          370733 |             0.02 |
| Ghana                            | July-2020      |               70 |          826344 |             0.01 |
| Ghana                            | August-2020    |               94 |         1296178 |             0.01 |
| Ghana                            | September-2020 |               25 |         1368073 |             0.00 |
| Ghana                            | October-2020   |               19 |         1465886 |             0.00 |
| Ghana                            | November-2020  |                3 |         1501148 |             0.00 |
| Ghana                            | December-2020  |               12 |         1651837 |             0.00 |
| Ghana                            | January-2021   |               81 |         1813441 |             0.00 |
| Ghana                            | February-2021  |              191 |         2124578 |             0.01 |
| Ghana                            | March-2021     |              136 |         2726591 |             0.00 |
| Ghana                            | April-2021     |               36 |         2746420 |             0.00 |
| Gibraltar                        | January-2021   |                0 |               0 |             NULL |
| Gibraltar                        | February-2021  |                0 |               0 |             NULL |
| Gibraltar                        | March-2021     |                0 |               0 |             NULL |
| Gibraltar                        | April-2021     |                0 |               0 |             NULL |
| Greece                           | February-2020  |                0 |              12 |             0.00 |
| Greece                           | March-2020     |               49 |           13397 |             0.37 |
| Greece                           | April-2020     |               91 |           64317 |             0.14 |
| Greece                           | May-2020       |               35 |           86384 |             0.04 |
| Greece                           | June-2020      |               17 |           94867 |             0.02 |
| Greece                           | July-2020      |               14 |          121131 |             0.01 |
| Greece                           | August-2020    |               60 |          222406 |             0.03 |
| Greece                           | September-2020 |              125 |          424201 |             0.03 |
| Greece                           | October-2020   |              235 |          802968 |             0.03 |
| Greece                           | November-2020  |             1780 |         2243451 |             0.08 |
| Greece                           | December-2020  |             2432 |         3904326 |             0.06 |
| Greece                           | January-2021   |              958 |         4585941 |             0.02 |
| Greece                           | February-2021  |              708 |         4844582 |             0.01 |
| Greece                           | March-2021     |             1589 |         7014206 |             0.02 |
| Greece                           | April-2021     |             2288 |         9230831 |             0.02 |
| Greenland                        | January-2021   |                0 |               0 |             NULL |
| Greenland                        | February-2021  |                0 |               0 |             NULL |
| Greenland                        | March-2021     |                0 |               0 |             NULL |
| Greenland                        | April-2021     |                0 |               0 |             NULL |
| Grenada                          | March-2020     |                0 |              52 |             0.00 |
| Grenada                          | April-2020     |                0 |             429 |             0.00 |
| Grenada                          | May-2020       |                0 |             674 |             0.00 |
| Grenada                          | June-2020      |                0 |             690 |             0.00 |
| Grenada                          | July-2020      |                0 |             715 |             0.00 |
| Grenada                          | August-2020    |                0 |             744 |             0.00 |
| Grenada                          | September-2020 |                0 |             720 |             0.00 |
| Grenada                          | October-2020   |                0 |             802 |             0.00 |
| Grenada                          | November-2020  |                0 |            1051 |             0.00 |
| Grenada                          | December-2020  |                0 |            2429 |             0.00 |
| Grenada                          | January-2021   |                1 |            4240 |             0.02 |
| Grenada                          | February-2021  |                0 |            4144 |             0.00 |
| Grenada                          | March-2021     |                0 |            4696 |             0.00 |
| Grenada                          | April-2021     |                0 |            4694 |             0.00 |
| Guatemala                        | February-2020  |                0 |               0 |             NULL |
| Guatemala                        | March-2020     |                1 |             333 |             0.30 |
| Guatemala                        | April-2020     |               15 |            7312 |             0.21 |
| Guatemala                        | May-2020       |               92 |           67102 |             0.14 |
| Guatemala                        | June-2020      |              665 |          329549 |             0.20 |
| Guatemala                        | July-2020      |             1151 |         1062083 |             0.11 |
| Guatemala                        | August-2020    |              836 |         1938713 |             0.04 |
| Guatemala                        | September-2020 |              486 |         2495864 |             0.02 |
| Guatemala                        | October-2020   |              483 |         3106103 |             0.02 |
| Guatemala                        | November-2020  |              442 |         3454791 |             0.01 |
| Guatemala                        | December-2020  |              642 |         4047232 |             0.02 |
| Guatemala                        | January-2021   |              830 |         4594145 |             0.02 |
| Guatemala                        | February-2021  |              750 |         4687392 |             0.02 |
| Guatemala                        | March-2021     |              447 |         5723666 |             0.01 |
| Guatemala                        | April-2021     |              684 |         6287226 |             0.01 |
| Guernsey                         | January-2021   |                0 |               0 |             NULL |
| Guernsey                         | February-2021  |                0 |               0 |             NULL |
| Guernsey                         | March-2021     |                0 |               0 |             NULL |
| Guernsey                         | April-2021     |                0 |               0 |             NULL |
| Guinea                           | March-2020     |                0 |             104 |             0.00 |
| Guinea                           | April-2020     |                7 |           15955 |             0.04 |
| Guinea                           | May-2020       |               16 |           80843 |             0.02 |
| Guinea                           | June-2020      |               10 |          139077 |             0.01 |
| Guinea                           | July-2020      |               13 |          196485 |             0.01 |
| Guinea                           | August-2020    |               13 |          261346 |             0.00 |
| Guinea                           | September-2020 |                7 |          303547 |             0.00 |
| Guinea                           | October-2020   |                6 |          350904 |             0.00 |
| Guinea                           | November-2020  |                4 |          379110 |             0.00 |
| Guinea                           | December-2020  |                5 |          417156 |             0.00 |
| Guinea                           | January-2021   |                1 |          437663 |             0.00 |
| Guinea                           | February-2021  |                7 |          422601 |             0.00 |
| Guinea                           | March-2021     |               36 |          558415 |             0.01 |
| Guinea                           | April-2021     |               19 |          637554 |             0.00 |
| Guinea-Bissau                    | March-2020     |                0 |              26 |             0.00 |
| Guinea-Bissau                    | April-2020     |                1 |            1515 |             0.07 |
| Guinea-Bissau                    | May-2020       |                7 |           26923 |             0.03 |
| Guinea-Bissau                    | June-2020      |               16 |           44361 |             0.04 |
| Guinea-Bissau                    | July-2020      |                2 |           58039 |             0.00 |
| Guinea-Bissau                    | August-2020    |                8 |           65237 |             0.01 |
| Guinea-Bissau                    | September-2020 |                5 |           68413 |             0.01 |
| Guinea-Bissau                    | October-2020   |                2 |           74077 |             0.00 |
| Guinea-Bissau                    | November-2020  |                3 |           72580 |             0.00 |
| Guinea-Bissau                    | December-2020  |                1 |           75812 |             0.00 |
| Guinea-Bissau                    | January-2021   |                0 |           77361 |             0.00 |
| Guinea-Bissau                    | February-2021  |                3 |           82413 |             0.00 |
| Guinea-Bissau                    | March-2021     |               15 |          107408 |             0.01 |
| Guinea-Bissau                    | April-2021     |                4 |          110920 |             0.00 |
| Guyana                           | March-2020     |                2 |             141 |             1.42 |
| Guyana                           | April-2020     |                7 |            1562 |             0.45 |
| Guyana                           | May-2020       |                3 |            3617 |             0.08 |
| Guyana                           | June-2020      |                0 |            5398 |             0.00 |
| Guyana                           | July-2020      |                8 |            9979 |             0.08 |
| Guyana                           | August-2020    |               19 |           24093 |             0.08 |
| Guyana                           | September-2020 |               41 |           61590 |             0.07 |
| Guyana                           | October-2020   |               44 |          112427 |             0.04 |
| Guyana                           | November-2020  |               27 |          144708 |             0.02 |
| Guyana                           | December-2020  |               13 |          185193 |             0.01 |
| Guyana                           | January-2021   |               12 |          213438 |             0.01 |
| Guyana                           | February-2021  |               19 |          229334 |             0.01 |
| Guyana                           | March-2021     |               36 |          289705 |             0.01 |
| Guyana                           | April-2021     |               65 |          349462 |             0.02 |
| Haiti                            | March-2020     |                0 |              84 |             0.00 |
| Haiti                            | April-2020     |                6 |            1261 |             0.48 |
| Haiti                            | May-2020       |               29 |           15126 |             0.19 |
| Haiti                            | June-2020      |               69 |          123311 |             0.06 |
| Haiti                            | July-2020      |               55 |          209881 |             0.03 |
| Haiti                            | August-2020    |               42 |          242437 |             0.02 |
| Haiti                            | September-2020 |               26 |          254840 |             0.01 |
| Haiti                            | October-2020   |                5 |          276326 |             0.00 |
| Haiti                            | November-2020  |                0 |          275045 |             0.00 |
| Haiti                            | December-2020  |                4 |          297680 |             0.00 |
| Haiti                            | January-2021   |                9 |          330582 |             0.00 |
| Haiti                            | February-2021  |                5 |          337607 |             0.00 |
| Haiti                            | March-2021     |                2 |          391885 |             0.00 |
| Haiti                            | April-2021     |                2 |          386496 |             0.00 |
| Honduras                         | March-2020     |                7 |             821 |             0.85 |
| Honduras                         | April-2020     |               64 |           13307 |             0.48 |
| Honduras                         | May-2020       |              141 |           86306 |             0.16 |
| Honduras                         | June-2020      |              285 |          317671 |             0.09 |
| Honduras                         | July-2020      |              840 |          975322 |             0.09 |
| Honduras                         | August-2020    |              536 |         1584516 |             0.03 |
| Honduras                         | September-2020 |              480 |         2074882 |             0.02 |
| Honduras                         | October-2020   |              316 |         2704316 |             0.01 |
| Honduras                         | November-2020  |              249 |         3085315 |             0.01 |
| Honduras                         | December-2020  |              212 |         3569628 |             0.01 |
| Honduras                         | January-2021   |              480 |         4149890 |             0.01 |
| Honduras                         | February-2021  |              541 |         4488251 |             0.01 |
| Honduras                         | March-2021     |              454 |         5569807 |             0.01 |
| Honduras                         | April-2021     |              676 |         5982916 |             0.01 |
| Hong Kong                        | January-2020   |                0 |               0 |             NULL |
| Hong Kong                        | February-2020  |                0 |               0 |             NULL |
| Hong Kong                        | March-2020     |                0 |               0 |             NULL |
| Hong Kong                        | April-2020     |                0 |               0 |             NULL |
| Hong Kong                        | May-2020       |                0 |               0 |             NULL |
| Hong Kong                        | June-2020      |                0 |               0 |             NULL |
| Hong Kong                        | July-2020      |                0 |               0 |             NULL |
| Hong Kong                        | August-2020    |                0 |               0 |             NULL |
| Hong Kong                        | September-2020 |                0 |               0 |             NULL |
| Hong Kong                        | October-2020   |                0 |               0 |             NULL |
| Hong Kong                        | November-2020  |                0 |               0 |             NULL |
| Hong Kong                        | December-2020  |                0 |               0 |             NULL |
| Hong Kong                        | January-2021   |                0 |               0 |             NULL |
| Hong Kong                        | February-2021  |                0 |               0 |             NULL |
| Hong Kong                        | March-2021     |                0 |               0 |             NULL |
| Hong Kong                        | April-2021     |                0 |               0 |             NULL |
| Hungary                          | March-2020     |               16 |            3512 |             0.46 |
| Hungary                          | April-2020     |              296 |           48858 |             0.61 |
| Hungary                          | May-2020       |              214 |          106717 |             0.20 |
| Hungary                          | June-2020      |               59 |          121673 |             0.05 |
| Hungary                          | July-2020      |               11 |          133397 |             0.01 |
| Hungary                          | August-2020    |               19 |          154696 |             0.01 |
| Hungary                          | September-2020 |              150 |          450339 |             0.03 |
| Hungary                          | October-2020   |              985 |         1426535 |             0.07 |
| Hungary                          | November-2020  |             3073 |         4340462 |             0.07 |
| Hungary                          | December-2020  |             4714 |         8774928 |             0.05 |
| Hungary                          | January-2021   |             2987 |        10794651 |             0.03 |
| Hungary                          | February-2021  |             2450 |        10954073 |             0.02 |
| Hungary                          | March-2021     |             5763 |        16553070 |             0.03 |
| Hungary                          | April-2021     |             6803 |        21975323 |             0.03 |
| Iceland                          | February-2020  |                0 |               2 |             0.00 |
| Iceland                          | March-2020     |                2 |           11298 |             0.02 |
| Iceland                          | April-2020     |                8 |           50142 |             0.02 |
| Iceland                          | May-2020       |                0 |           55864 |             0.00 |
| Iceland                          | June-2020      |                0 |           54362 |             0.00 |
| Iceland                          | July-2020      |                0 |           57048 |             0.00 |
| Iceland                          | August-2020    |                0 |           62238 |             0.00 |
| Iceland                          | September-2020 |                0 |           69104 |             0.00 |
| Iceland                          | October-2020   |                2 |          119128 |             0.00 |
| Iceland                          | November-2020  |               14 |          155412 |             0.01 |
| Iceland                          | December-2020  |                3 |          173260 |             0.00 |
| Iceland                          | January-2021   |                0 |          183571 |             0.00 |
| Iceland                          | February-2021  |                0 |          168952 |             0.00 |
| Iceland                          | March-2021     |                0 |          189143 |             0.00 |
| Iceland                          | April-2021     |                0 |          189420 |             0.00 |
| India                            | January-2020   |                0 |               2 |             0.00 |
| India                            | February-2020  |                0 |              84 |             0.00 |
| India                            | March-2020     |               35 |           10252 |             0.34 |
| India                            | April-2020     |             1119 |          447607 |             0.25 |
| India                            | May-2020       |             4254 |         3088494 |             0.14 |
| India                            | June-2020      |            11992 |        10951713 |             0.11 |
| India                            | July-2020      |            19111 |        32829678 |             0.06 |
| India                            | August-2020    |            28777 |        82734792 |             0.03 |
| India                            | September-2020 |            33390 |       151735176 |             0.02 |
| India                            | October-2020   |            23433 |       228641810 |             0.01 |
| India                            | November-2020  |            15510 |       265835139 |             0.01 |
| India                            | December-2020  |            11117 |       307985456 |             0.00 |
| India                            | January-2021   |             5654 |       326908857 |             0.00 |
| India                            | February-2021  |             2765 |       305984490 |             0.00 |
| India                            | March-2021     |             5770 |       357487053 |             0.00 |
| India                            | April-2021     |            48926 |       447598593 |             0.01 |
| Indonesia                        | March-2020     |              136 |           11971 |             1.14 |
| Indonesia                        | April-2020     |              656 |          164969 |             0.40 |
| Indonesia                        | May-2020       |              821 |          546175 |             0.15 |
| Indonesia                        | June-2020      |             1263 |         1211857 |             0.10 |
| Indonesia                        | July-2020      |             2255 |         2544132 |             0.09 |
| Indonesia                        | August-2020    |             2286 |         4336124 |             0.05 |
| Indonesia                        | September-2020 |             3323 |         6879525 |             0.05 |
| Indonesia                        | October-2020   |             3129 |        10928941 |             0.03 |
| Indonesia                        | November-2020  |             3076 |        14115752 |             0.02 |
| Indonesia                        | December-2020  |             5193 |        19834279 |             0.03 |
| Indonesia                        | January-2021   |             7860 |        27904068 |             0.03 |
| Indonesia                        | February-2021  |             6168 |        34172220 |             0.02 |
| Indonesia                        | March-2021     |             4692 |        44344084 |             0.01 |
| Indonesia                        | April-2021     |             4663 |        47761250 |             0.01 |
| Iran                             | February-2020  |               43 |            1617 |             2.66 |
| Iran                             | March-2020     |             2855 |          525947 |             0.54 |
| Iran                             | April-2020     |             3130 |         2255837 |             0.14 |
| Iran                             | May-2020       |             1769 |         3727988 |             0.05 |
| Iran                             | June-2020      |             3020 |         5749446 |             0.05 |
| Iran                             | July-2020      |             5949 |         8279348 |             0.07 |
| Iran                             | August-2020    |             4805 |        10622742 |             0.05 |
| Iran                             | September-2020 |             4598 |        12365981 |             0.04 |
| Iran                             | October-2020   |             8695 |        16323626 |             0.05 |
| Iran                             | November-2020  |            13382 |        23319184 |             0.06 |
| Iran                             | December-2020  |             6977 |        34734095 |             0.02 |
| Iran                             | January-2021   |             2736 |        41044213 |             0.01 |
| Iran                             | February-2021  |             2114 |        42690161 |             0.00 |
| Iran                             | March-2021     |             2592 |        54610163 |             0.00 |
| Iran                             | April-2021     |             9093 |        65501367 |             0.01 |
| Iraq                             | February-2020  |                0 |              34 |             0.00 |
| Iraq                             | March-2020     |               50 |            6335 |             0.79 |
| Iraq                             | April-2020     |               43 |           42494 |             0.10 |
| Iraq                             | May-2020       |              112 |          112314 |             0.10 |
| Iraq                             | June-2020      |             1738 |          731904 |             0.24 |
| Iraq                             | July-2020      |             2798 |         2680051 |             0.10 |
| Iraq                             | August-2020    |             2301 |         5516538 |             0.04 |
| Iraq                             | September-2020 |             2139 |         9025163 |             0.02 |
| Iraq                             | October-2020   |             1729 |        13048781 |             0.01 |
| Iraq                             | November-2020  |             1348 |        15543204 |             0.01 |
| Iraq                             | December-2020  |              555 |        17911961 |             0.00 |
| Iraq                             | January-2021   |              234 |        18838341 |             0.00 |
| Iraq                             | February-2021  |              359 |        18220943 |             0.00 |
| Iraq                             | March-2021     |              917 |        23904513 |             0.00 |
| Iraq                             | April-2021     |             1142 |        28798758 |             0.00 |
| Ireland                          | February-2020  |                0 |               1 |             0.00 |
| Ireland                          | March-2020     |               71 |           23308 |             0.30 |
| Ireland                          | April-2020     |             1161 |          365860 |             0.32 |
| Ireland                          | May-2020       |              420 |          730677 |             0.06 |
| Ireland                          | June-2020      |               84 |          758939 |             0.01 |
| Ireland                          | July-2020      |               27 |          797096 |             0.00 |
| Ireland                          | August-2020    |               14 |          847681 |             0.00 |
| Ireland                          | September-2020 |               27 |          958194 |             0.00 |
| Ireland                          | October-2020   |              109 |         1495470 |             0.01 |
| Ireland                          | November-2020  |              140 |         2035798 |             0.01 |
| Ireland                          | December-2020  |              184 |         2451763 |             0.01 |
| Ireland                          | January-2021   |             1070 |         4945372 |             0.02 |
| Ireland                          | February-2021  |             1012 |         5864137 |             0.02 |
| Ireland                          | March-2021     |              368 |         7065554 |             0.01 |
| Ireland                          | April-2021     |              216 |         7281321 |             0.00 |
| Isle of Man                      | January-2021   |                0 |               0 |             NULL |
| Isle of Man                      | February-2021  |                0 |               0 |             NULL |
| Isle of Man                      | March-2021     |                0 |               0 |             NULL |
| Isle of Man                      | April-2021     |                0 |               0 |             NULL |
| Israel                           | February-2020  |                0 |              22 |             0.00 |
| Israel                           | March-2020     |               21 |           35287 |             0.06 |
| Israel                           | April-2020     |              204 |          367312 |             0.06 |
| Israel                           | May-2020       |               62 |          512036 |             0.01 |
| Israel                           | June-2020      |               40 |          602486 |             0.01 |
| Israel                           | July-2020      |              237 |         1460503 |             0.02 |
| Israel                           | August-2020    |              389 |         2916651 |             0.01 |
| Israel                           | September-2020 |              651 |         5221620 |             0.01 |
| Israel                           | October-2020   |              957 |         9176583 |             0.01 |
| Israel                           | November-2020  |              311 |         9755418 |             0.00 |
| Israel                           | December-2020  |              453 |        11475028 |             0.00 |
| Israel                           | January-2021   |             1471 |        16729422 |             0.01 |
| Israel                           | February-2021  |              956 |        20255490 |             0.00 |
| Israel                           | March-2021     |              457 |        25324771 |             0.00 |
| Israel                           | April-2021     |              154 |        25095274 |             0.00 |
| Italy                            | January-2020   |                0 |               2 |             0.00 |
| Italy                            | February-2020  |               29 |            3966 |             0.73 |
| Italy                            | March-2020     |            12399 |         1209772 |             1.02 |
| Italy                            | April-2020     |            15539 |         4928524 |             0.32 |
| Italy                            | May-2020       |             5448 |         6914863 |             0.08 |
| Italy                            | June-2020      |             1352 |         7115232 |             0.02 |
| Italy                            | July-2020      |              374 |         7560745 |             0.00 |
| Italy                            | August-2020    |              342 |         7919622 |             0.00 |
| Italy                            | September-2020 |              411 |         8749361 |             0.00 |
| Italy                            | October-2020   |             2724 |        13281216 |             0.02 |
| Italy                            | November-2020  |            16958 |        35324374 |             0.05 |
| Italy                            | December-2020  |            18583 |        58293082 |             0.03 |
| Italy                            | January-2021   |            14357 |        72917277 |             0.02 |
| Italy                            | February-2021  |             9183 |        76429829 |             0.01 |
| Italy                            | March-2021     |            11647 |       101162913 |             0.01 |
| Italy                            | April-2021     |            11461 |       114799462 |             0.01 |
| Jamaica                          | March-2020     |                1 |             382 |             0.26 |
| Jamaica                          | April-2020     |                7 |            5011 |             0.14 |
| Jamaica                          | May-2020       |                1 |           16083 |             0.01 |
| Jamaica                          | June-2020      |                1 |           19058 |             0.01 |
| Jamaica                          | July-2020      |                0 |           24311 |             0.00 |
| Jamaica                          | August-2020    |               11 |           40928 |             0.03 |
| Jamaica                          | September-2020 |               86 |          130368 |             0.07 |
| Jamaica                          | October-2020   |               99 |          247729 |             0.04 |
| Jamaica                          | November-2020  |               51 |          297709 |             0.02 |
| Jamaica                          | December-2020  |               45 |          368482 |             0.01 |
| Jamaica                          | January-2021   |               48 |          439391 |             0.01 |
| Jamaica                          | February-2021  |               72 |          540682 |             0.01 |
| Jamaica                          | March-2021     |              174 |          982732 |             0.02 |
| Jamaica                          | April-2021     |              182 |         1293840 |             0.01 |
| Japan                            | January-2020   |                0 |              56 |             0.00 |
| Japan                            | February-2020  |                6 |            2418 |             0.25 |
| Japan                            | March-2020     |               61 |           29049 |             0.21 |
| Japan                            | April-2020     |              414 |          264160 |             0.16 |
| Japan                            | May-2020       |              417 |          496484 |             0.08 |
| Japan                            | June-2020      |               74 |          525609 |             0.01 |
| Japan                            | July-2020      |               36 |          771595 |             0.00 |
| Japan                            | August-2020    |              290 |         1701916 |             0.02 |
| Japan                            | September-2020 |              277 |         2297182 |             0.01 |
| Japan                            | October-2020   |              194 |         2856221 |             0.01 |
| Japan                            | November-2020  |              307 |         3650314 |             0.01 |
| Japan                            | December-2020  |             1216 |         5880523 |             0.02 |
| Japan                            | January-2021   |             2461 |         9902662 |             0.02 |
| Japan                            | February-2021  |             2136 |        11627561 |             0.02 |
| Japan                            | March-2021     |             1266 |        13976951 |             0.01 |
| Japan                            | April-2021     |             1044 |        15835437 |             0.01 |
| Jersey                           | January-2021   |                0 |               0 |             NULL |
| Jersey                           | February-2021  |                0 |               0 |             NULL |
| Jersey                           | March-2021     |                0 |               0 |             NULL |
| Jersey                           | April-2021     |                0 |               0 |             NULL |
| Jordan                           | March-2020     |                5 |            2421 |             0.21 |
| Jordan                           | April-2020     |                3 |           11816 |             0.03 |
| Jordan                           | May-2020       |                1 |           18801 |             0.01 |
| Jordan                           | June-2020      |                0 |           28514 |             0.00 |
| Jordan                           | July-2020      |                2 |           36345 |             0.01 |
| Jordan                           | August-2020    |                4 |           45488 |             0.01 |
| Jordan                           | September-2020 |               46 |          140406 |             0.03 |
| Jordan                           | October-2020   |              768 |         1138829 |             0.07 |
| Jordan                           | November-2020  |             1922 |         4471920 |             0.04 |
| Jordan                           | December-2020  |             1083 |         8196380 |             0.01 |
| Jordan                           | January-2021   |              482 |         9694303 |             0.00 |
| Jordan                           | February-2021  |              385 |         9868118 |             0.00 |
| Jordan                           | March-2021     |             2157 |        15461791 |             0.01 |
| Jordan                           | April-2021     |             1978 |        20243727 |             0.01 |
| Kazakhstan                       | March-2020     |                2 |            1937 |             0.10 |
| Kazakhstan                       | April-2020     |               23 |           46219 |             0.05 |
| Kazakhstan                       | May-2020       |               15 |          202761 |             0.01 |
| Kazakhstan                       | June-2020      |              148 |          476607 |             0.03 |
| Kazakhstan                       | July-2020      |              605 |         2056485 |             0.03 |
| Kazakhstan                       | August-2020    |              988 |         3642536 |             0.03 |
| Kazakhstan                       | September-2020 |              297 |         4099504 |             0.01 |
| Kazakhstan                       | October-2020   |              148 |         4489708 |             0.00 |
| Kazakhstan                       | November-2020  |              207 |         4848928 |             0.00 |
| Kazakhstan                       | December-2020  |              328 |         5844830 |             0.01 |
| Kazakhstan                       | January-2021   |              285 |         6716862 |             0.00 |
| Kazakhstan                       | February-2021  |              116 |         7028707 |             0.00 |
| Kazakhstan                       | March-2021     |               70 |         8618791 |             0.00 |
| Kazakhstan                       | April-2021     |              102 |        10069664 |             0.00 |
| Kenya                            | March-2020     |                1 |             370 |             0.27 |
| Kenya                            | April-2020     |               16 |            7263 |             0.22 |
| Kenya                            | May-2020       |               47 |           29773 |             0.16 |
| Kenya                            | June-2020      |               84 |          118824 |             0.07 |
| Kenya                            | July-2020      |              193 |          386628 |             0.05 |
| Kenya                            | August-2020    |              236 |          902573 |             0.03 |
| Kenya                            | September-2020 |              134 |         1091882 |             0.01 |
| Kenya                            | October-2020   |              270 |         1385303 |             0.02 |
| Kenya                            | November-2020  |              488 |         2106033 |             0.02 |
| Kenya                            | December-2020  |              201 |         2856847 |             0.01 |
| Kenya                            | January-2021   |               93 |         3065046 |             0.00 |
| Kenya                            | February-2021  |               93 |         2887159 |             0.00 |
| Kenya                            | March-2021     |              297 |         3634398 |             0.01 |
| Kenya                            | April-2021     |              571 |         4463081 |             0.01 |
| Kosovo                           | March-2020     |                1 |             844 |             0.12 |
| Kosovo                           | April-2020     |               21 |           12732 |             0.16 |
| Kosovo                           | May-2020       |                8 |           29343 |             0.03 |
| Kosovo                           | June-2020      |               19 |           51853 |             0.04 |
| Kosovo                           | July-2020      |              178 |          166431 |             0.11 |
| Kosovo                           | August-2020    |              298 |          349836 |             0.09 |
| Kosovo                           | September-2020 |              100 |          442311 |             0.02 |
| Kosovo                           | October-2020   |               53 |          524640 |             0.01 |
| Kosovo                           | November-2020  |              338 |          883320 |             0.04 |
| Kosovo                           | December-2020  |              316 |         1447730 |             0.02 |
| Kosovo                           | January-2021   |              166 |         1720254 |             0.01 |
| Kosovo                           | February-2021  |               94 |         1801727 |             0.01 |
| Kosovo                           | March-2021     |              274 |         2424115 |             0.01 |
| Kosovo                           | April-2021     |              268 |         2957297 |             0.01 |
| Kuwait                           | February-2020  |                0 |             171 |             0.00 |
| Kuwait                           | March-2020     |                0 |            4154 |             0.00 |
| Kuwait                           | April-2020     |               26 |           51368 |             0.05 |
| Kuwait                           | May-2020       |              186 |          445816 |             0.04 |
| Kuwait                           | June-2020      |              142 |         1106772 |             0.01 |
| Kuwait                           | July-2020      |               93 |         1776417 |             0.01 |
| Kuwait                           | August-2020    |               84 |         2362626 |             0.00 |
| Kuwait                           | September-2020 |               79 |         2885759 |             0.00 |
| Kuwait                           | October-2020   |              169 |         3569876 |             0.00 |
| Kuwait                           | November-2020  |              101 |         4082135 |             0.00 |
| Kuwait                           | December-2020  |               54 |         4554849 |             0.00 |
| Kuwait                           | January-2021   |               25 |         4881830 |             0.00 |
| Kuwait                           | February-2021  |              124 |         4988724 |             0.00 |
| Kuwait                           | March-2021     |              230 |         6584268 |             0.00 |
| Kuwait                           | April-2021     |              250 |         7607062 |             0.00 |
| Kyrgyzstan                       | March-2020     |                0 |             587 |             0.00 |
| Kyrgyzstan                       | April-2020     |                8 |           13260 |             0.06 |
| Kyrgyzstan                       | May-2020       |                8 |           36450 |             0.02 |
| Kyrgyzstan                       | June-2020      |               45 |           87845 |             0.05 |
| Kyrgyzstan                       | July-2020      |             1317 |          597522 |             0.22 |
| Kyrgyzstan                       | August-2020    |             -320 |         1276140 |            -0.03 |
| Kyrgyzstan                       | September-2020 |                6 |         1354021 |             0.00 |
| Kyrgyzstan                       | October-2020   |               80 |         1605533 |             0.00 |
| Kyrgyzstan                       | November-2020  |              131 |         1994975 |             0.01 |
| Kyrgyzstan                       | December-2020  |               80 |         2411196 |             0.00 |
| Kyrgyzstan                       | January-2021   |               57 |         2571550 |             0.00 |
| Kyrgyzstan                       | February-2021  |               54 |         2393821 |             0.00 |
| Kyrgyzstan                       | March-2021     |               34 |         2701863 |             0.00 |
| Kyrgyzstan                       | April-2021     |              104 |         2744413 |             0.00 |
| Laos                             | March-2020     |                0 |              50 |             0.00 |
| Laos                             | April-2020     |                0 |             503 |             0.00 |
| Laos                             | May-2020       |                0 |             589 |             0.00 |
| Laos                             | June-2020      |                0 |             570 |             0.00 |
| Laos                             | July-2020      |                0 |             597 |             0.00 |
| Laos                             | August-2020    |                0 |             656 |             0.00 |
| Laos                             | September-2020 |                0 |             680 |             0.00 |
| Laos                             | October-2020   |                0 |             724 |             0.00 |
| Laos                             | November-2020  |                0 |             846 |             0.00 |
| Laos                             | December-2020  |                0 |            1259 |             0.00 |
| Laos                             | January-2021   |                0 |            1292 |             0.00 |
| Laos                             | February-2021  |                0 |            1258 |             0.00 |
| Laos                             | March-2021     |                0 |            1485 |             0.00 |
| Laos                             | April-2021     |                0 |            4930 |             0.00 |
| Latvia                           | February-2020  |                0 |               0 |             NULL |
| Latvia                           | March-2020     |                0 |            3277 |             0.00 |
| Latvia                           | April-2020     |               15 |           20149 |             0.07 |
| Latvia                           | May-2020       |                9 |           30402 |             0.03 |
| Latvia                           | June-2020      |                6 |           32971 |             0.02 |
| Latvia                           | July-2020      |                2 |           36487 |             0.01 |
| Latvia                           | August-2020    |                2 |           40754 |             0.00 |
| Latvia                           | September-2020 |                3 |           45572 |             0.01 |
| Latvia                           | October-2020   |               34 |          106264 |             0.03 |
| Latvia                           | November-2020  |              135 |          326976 |             0.04 |
| Latvia                           | December-2020  |              429 |          875710 |             0.05 |
| Latvia                           | January-2021   |              560 |         1678918 |             0.03 |
| Latvia                           | February-2021  |              423 |         2151827 |             0.02 |
| Latvia                           | March-2021     |              281 |         2937772 |             0.01 |
| Latvia                           | April-2021     |              232 |         3303437 |             0.01 |
| Lebanon                          | February-2020  |                0 |              15 |             0.00 |
| Lebanon                          | March-2020     |               12 |            5177 |             0.23 |
| Lebanon                          | April-2020     |               12 |           18944 |             0.06 |
| Lebanon                          | May-2020       |                3 |           29199 |             0.01 |
| Lebanon                          | June-2020      |                7 |           44582 |             0.02 |
| Lebanon                          | July-2020      |               27 |           85807 |             0.03 |
| Lebanon                          | August-2020    |              106 |          302900 |             0.03 |
| Lebanon                          | September-2020 |              200 |          807478 |             0.02 |
| Lebanon                          | October-2020   |              270 |         1859410 |             0.01 |
| Lebanon                          | November-2020  |              381 |         3175672 |             0.01 |
| Lebanon                          | December-2020  |              450 |         4730285 |             0.01 |
| Lebanon                          | January-2021   |             1614 |         7586618 |             0.02 |
| Lebanon                          | February-2021  |             1610 |         9501209 |             0.02 |
| Lebanon                          | March-2021     |             1542 |        13134891 |             0.01 |
| Lebanon                          | April-2021     |             1044 |        15091550 |             0.01 |
| Lesotho                          | May-2020       |                0 |              29 |             0.00 |
| Lesotho                          | June-2020      |                0 |             272 |             0.00 |
| Lesotho                          | July-2020      |               13 |            8782 |             0.15 |
| Lesotho                          | August-2020    |               18 |           27809 |             0.06 |
| Lesotho                          | September-2020 |                5 |           39807 |             0.01 |
| Lesotho                          | October-2020   |                8 |           56894 |             0.01 |
| Lesotho                          | November-2020  |                0 |           61138 |             0.00 |
| Lesotho                          | December-2020  |                7 |           76083 |             0.01 |
| Lesotho                          | January-2021   |              121 |          194193 |             0.06 |
| Lesotho                          | February-2021  |              120 |          278256 |             0.04 |
| Lesotho                          | March-2021     |               23 |          327749 |             0.01 |
| Lesotho                          | April-2021     |                1 |          321443 |             0.00 |
| Liberia                          | March-2020     |                0 |              41 |             0.00 |
| Liberia                          | April-2020     |               16 |            2056 |             0.78 |
| Liberia                          | May-2020       |               11 |            6898 |             0.16 |
| Liberia                          | June-2020      |                9 |           15416 |             0.06 |
| Liberia                          | July-2020      |               39 |           32087 |             0.12 |
| Liberia                          | August-2020    |                7 |           39105 |             0.02 |
| Liberia                          | September-2020 |                0 |           39742 |             0.00 |
| Liberia                          | October-2020   |                0 |           42758 |             0.00 |
| Liberia                          | November-2020  |                1 |           45235 |             0.00 |
| Liberia                          | December-2020  |                0 |           53423 |             0.00 |
| Liberia                          | January-2021   |                1 |           57740 |             0.00 |
| Liberia                          | February-2021  |                1 |           55281 |             0.00 |
| Liberia                          | March-2021     |                0 |           63015 |             0.00 |
| Liberia                          | April-2021     |                0 |           61806 |             0.00 |
| Libya                            | March-2020     |                0 |              33 |             0.00 |
| Libya                            | April-2020     |                3 |            1180 |             0.25 |
| Libya                            | May-2020       |                2 |            2340 |             0.09 |
| Libya                            | June-2020      |               19 |           14275 |             0.13 |
| Libya                            | July-2020      |               50 |           57791 |             0.09 |
| Libya                            | August-2020    |              163 |          257246 |             0.06 |
| Libya                            | September-2020 |              314 |          739939 |             0.04 |
| Libya                            | October-2020   |              306 |         1475402 |             0.02 |
| Libya                            | November-2020  |              326 |         2198676 |             0.01 |
| Libya                            | December-2020  |              295 |         2861262 |             0.01 |
| Libya                            | January-2021   |              399 |         3375585 |             0.01 |
| Libya                            | February-2021  |              302 |         3560392 |             0.01 |
| Libya                            | March-2021     |              488 |         4553941 |             0.01 |
| Libya                            | April-2021     |              362 |         5099709 |             0.01 |
| Liechtenstein                    | March-2020     |                0 |             694 |             0.00 |
| Liechtenstein                    | April-2020     |                1 |            2372 |             0.04 |
| Liechtenstein                    | May-2020       |                0 |            2542 |             0.00 |
| Liechtenstein                    | June-2020      |                0 |            2460 |             0.00 |
| Liechtenstein                    | July-2020      |                0 |            2634 |             0.00 |
| Liechtenstein                    | August-2020    |                0 |            2952 |             0.00 |
| Liechtenstein                    | September-2020 |                0 |            3352 |             0.00 |
| Liechtenstein                    | October-2020   |                2 |            7561 |             0.03 |
| Liechtenstein                    | November-2020  |               13 |           28878 |             0.05 |
| Liechtenstein                    | December-2020  |               23 |           51462 |             0.04 |
| Liechtenstein                    | January-2021   |               13 |           73484 |             0.02 |
| Liechtenstein                    | February-2021  |                2 |           71015 |             0.00 |
| Liechtenstein                    | March-2021     |                2 |           81102 |             0.00 |
| Liechtenstein                    | April-2021     |                1 |           83726 |             0.00 |
| Lithuania                        | February-2020  |                0 |               1 |             0.00 |
| Lithuania                        | March-2020     |                4 |            3022 |             0.13 |
| Lithuania                        | April-2020     |               28 |           30598 |             0.09 |
| Lithuania                        | May-2020       |               22 |           47420 |             0.05 |
| Lithuania                        | June-2020      |                7 |           52692 |             0.01 |
| Lithuania                        | July-2020      |                2 |           59304 |             0.00 |
| Lithuania                        | August-2020    |                6 |           75618 |             0.01 |
| Lithuania                        | September-2020 |                8 |          107305 |             0.01 |
| Lithuania                        | October-2020   |               75 |          244755 |             0.03 |
| Lithuania                        | November-2020  |              468 |         1090304 |             0.04 |
| Lithuania                        | December-2020  |             1176 |         3142080 |             0.04 |
| Lithuania                        | January-2021   |             1012 |         5173306 |             0.02 |
| Lithuania                        | February-2021  |              436 |         5336974 |             0.01 |
| Lithuania                        | March-2021     |              330 |         6413345 |             0.01 |
| Lithuania                        | April-2021     |              349 |         6935557 |             0.01 |
| Luxembourg                       | February-2020  |                0 |               1 |             0.00 |
| Luxembourg                       | March-2020     |               23 |           17209 |             0.13 |
| Luxembourg                       | April-2020     |               67 |           99317 |             0.07 |
| Luxembourg                       | May-2020       |               20 |          121711 |             0.02 |
| Luxembourg                       | June-2020      |                0 |          122950 |             0.00 |
| Luxembourg                       | July-2020      |                4 |          166386 |             0.00 |
| Luxembourg                       | August-2020    |               10 |          225779 |             0.00 |
| Luxembourg                       | September-2020 |                0 |          225144 |             0.00 |
| Luxembourg                       | October-2020   |               28 |          351609 |             0.01 |
| Luxembourg                       | November-2020  |              169 |          800948 |             0.02 |
| Luxembourg                       | December-2020  |              174 |         1297802 |             0.01 |
| Luxembourg                       | January-2021   |               82 |         1506358 |             0.01 |
| Luxembourg                       | February-2021  |               60 |         1482434 |             0.00 |
| Luxembourg                       | March-2021     |              109 |         1807017 |             0.01 |
| Luxembourg                       | April-2021     |               50 |         1934308 |             0.00 |
| Macao                            | February-2021  |                0 |               0 |             NULL |
| Macao                            | March-2021     |                0 |               0 |             NULL |
| Macao                            | April-2021     |                0 |               0 |             NULL |
| Madagascar                       | March-2020     |                0 |             271 |             0.00 |
| Madagascar                       | April-2020     |                0 |            3143 |             0.00 |
| Madagascar                       | May-2020       |                6 |           10795 |             0.06 |
| Madagascar                       | June-2020      |               14 |           42217 |             0.03 |
| Madagascar                       | July-2020      |               86 |          192907 |             0.04 |
| Madagascar                       | August-2020    |               86 |          420613 |             0.02 |
| Madagascar                       | September-2020 |               38 |          473830 |             0.01 |
| Madagascar                       | October-2020   |               14 |          519886 |             0.00 |
| Madagascar                       | November-2020  |                7 |          517577 |             0.00 |
| Madagascar                       | December-2020  |               10 |          544372 |             0.00 |
| Madagascar                       | January-2021   |               20 |          564230 |             0.00 |
| Madagascar                       | February-2021  |               16 |          545744 |             0.00 |
| Madagascar                       | March-2021     |              121 |          671004 |             0.02 |
| Madagascar                       | April-2021     |              225 |          920949 |             0.02 |
| Malawi                           | March-2020     |                0 |               0 |             NULL |
| Malawi                           | April-2020     |                3 |             528 |             0.57 |
| Malawi                           | May-2020       |                1 |            2747 |             0.04 |
| Malawi                           | June-2020      |               10 |           19374 |             0.05 |
| Malawi                           | July-2020      |              100 |           82400 |             0.12 |
| Malawi                           | August-2020    |               61 |          154885 |             0.04 |
| Malawi                           | September-2020 |                4 |          170733 |             0.00 |
| Malawi                           | October-2020   |                5 |          181240 |             0.00 |
| Malawi                           | November-2020  |                1 |          179342 |             0.00 |
| Malawi                           | December-2020  |                4 |          191330 |             0.00 |
| Malawi                           | January-2021   |              513 |          415229 |             0.12 |
| Malawi                           | February-2021  |              342 |          808919 |             0.04 |
| Malawi                           | March-2021     |               73 |         1020068 |             0.01 |
| Malawi                           | April-2021     |               31 |         1016210 |             0.00 |
| Malaysia                         | January-2020   |                0 |              38 |             0.00 |
| Malaysia                         | February-2020  |                0 |             529 |             0.00 |
| Malaysia                         | March-2020     |               43 |           27636 |             0.16 |
| Malaysia                         | April-2020     |               59 |          145040 |             0.04 |
| Malaysia                         | May-2020       |               13 |          214779 |             0.01 |
| Malaysia                         | June-2020      |                6 |          252725 |             0.00 |
| Malaysia                         | July-2020      |                4 |          271966 |             0.00 |
| Malaysia                         | August-2020    |                2 |          284350 |             0.00 |
| Malaysia                         | September-2020 |                9 |          302097 |             0.00 |
| Malaysia                         | October-2020   |              113 |          621112 |             0.02 |
| Malaysia                         | November-2020  |              111 |         1451172 |             0.01 |
| Malaysia                         | December-2020  |              111 |         2734703 |             0.00 |
| Malaysia                         | January-2021   |              289 |         4894111 |             0.01 |
| Malaysia                         | February-2021  |              370 |         7379863 |             0.01 |
| Malaysia                         | March-2021     |              142 |        10091945 |             0.00 |
| Malaysia                         | April-2021     |              234 |        11169973 |             0.00 |
| Maldives                         | March-2020     |                0 |             289 |             0.00 |
| Maldives                         | April-2020     |                1 |            2519 |             0.04 |
| Maldives                         | May-2020       |                4 |           32674 |             0.01 |
| Maldives                         | June-2020      |                4 |           62485 |             0.01 |
| Maldives                         | July-2020      |                7 |           90220 |             0.01 |
| Maldives                         | August-2020    |               12 |          182727 |             0.01 |
| Maldives                         | September-2020 |                6 |          278856 |             0.00 |
| Maldives                         | October-2020   |                4 |          343649 |             0.00 |
| Maldives                         | November-2020  |                8 |          369915 |             0.00 |
| Maldives                         | December-2020  |                2 |          415623 |             0.00 |
| Maldives                         | January-2021   |                4 |          451616 |             0.00 |
| Maldives                         | February-2021  |               10 |          500324 |             0.00 |
| Maldives                         | March-2021     |                5 |          679662 |             0.00 |
| Maldives                         | April-2021     |                6 |          792272 |             0.00 |
| Mali                             | March-2020     |                2 |             106 |             1.89 |
| Mali                             | April-2020     |               24 |            5898 |             0.41 |
| Mali                             | May-2020       |               51 |           26486 |             0.19 |
| Mali                             | June-2020      |               39 |           53905 |             0.07 |
| Mali                             | July-2020      |                8 |           75197 |             0.01 |
| Mali                             | August-2020    |                2 |           81775 |             0.00 |
| Mali                             | September-2020 |                5 |           88671 |             0.01 |
| Mali                             | October-2020   |                5 |          104007 |             0.00 |
| Mali                             | November-2020  |               20 |          120596 |             0.02 |
| Mali                             | December-2020  |              113 |          183402 |             0.06 |
| Mali                             | January-2021   |               61 |          239845 |             0.03 |
| Mali                             | February-2021  |               23 |          230661 |             0.01 |
| Mali                             | March-2021     |               32 |          282009 |             0.01 |
| Mali                             | April-2021     |               99 |          370821 |             0.03 |
| Malta                            | February-2020  |                0 |               0 |             NULL |
| Malta                            | March-2020     |                0 |            1707 |             0.00 |
| Malta                            | April-2020     |                4 |           11099 |             0.04 |
| Malta                            | May-2020       |                5 |           16920 |             0.03 |
| Malta                            | June-2020      |                0 |           19477 |             0.00 |
| Malta                            | July-2020      |                0 |           21346 |             0.00 |
| Malta                            | August-2020    |                3 |           41914 |             0.01 |
| Malta                            | September-2020 |               23 |           74643 |             0.03 |
| Malta                            | October-2020   |               27 |          137553 |             0.02 |
| Malta                            | November-2020  |               75 |          242409 |             0.03 |
| Malta                            | December-2020  |               82 |          352991 |             0.02 |
| Malta                            | January-2021   |               48 |          476588 |             0.01 |
| Malta                            | February-2021  |               48 |          559054 |             0.01 |
| Malta                            | March-2021     |               77 |          823697 |             0.01 |
| Malta                            | April-2021     |               21 |          893451 |             0.00 |
| Marshall Islands                 | October-2020   |                0 |               8 |             0.00 |
| Marshall Islands                 | November-2020  |                0 |              76 |             0.00 |
| Marshall Islands                 | December-2020  |                0 |             124 |             0.00 |
| Marshall Islands                 | January-2021   |                0 |             124 |             0.00 |
| Marshall Islands                 | February-2021  |                0 |             112 |             0.00 |
| Marshall Islands                 | March-2021     |                0 |             124 |             0.00 |
| Marshall Islands                 | April-2021     |                0 |             120 |             0.00 |
| Mauritania                       | March-2020     |                1 |              46 |             2.17 |
| Mauritania                       | April-2020     |                0 |             204 |             0.00 |
| Mauritania                       | May-2020       |               22 |            4057 |             0.54 |
| Mauritania                       | June-2020      |              106 |           67050 |             0.16 |
| Mauritania                       | July-2020      |               28 |          172865 |             0.02 |
| Mauritania                       | August-2020    |                2 |          208217 |             0.00 |
| Mauritania                       | September-2020 |                2 |          219109 |             0.00 |
| Mauritania                       | October-2020   |                2 |          235602 |             0.00 |
| Mauritania                       | November-2020  |               14 |          240629 |             0.01 |
| Mauritania                       | December-2020  |              170 |          357674 |             0.05 |
| Mauritania                       | January-2021   |               75 |          491063 |             0.02 |
| Mauritania                       | February-2021  |               19 |          475129 |             0.00 |
| Mauritania                       | March-2021     |                8 |          542837 |             0.00 |
| Mauritania                       | April-2021     |                6 |          543196 |             0.00 |
| Mauritius                        | March-2020     |                5 |             841 |             0.59 |
| Mauritius                        | April-2020     |                5 |            8914 |             0.06 |
| Mauritius                        | May-2020       |                0 |           10311 |             0.00 |
| Mauritius                        | June-2020      |                0 |           10136 |             0.00 |
| Mauritius                        | July-2020      |                0 |           10622 |             0.00 |
| Mauritius                        | August-2020    |                0 |           10750 |             0.00 |
| Mauritius                        | September-2020 |                0 |           10896 |             0.00 |
| Mauritius                        | October-2020   |                0 |           12802 |             0.00 |
| Mauritius                        | November-2020  |                0 |           14299 |             0.00 |
| Mauritius                        | December-2020  |                0 |           16106 |             0.00 |
| Mauritius                        | January-2021   |                0 |           17037 |             0.00 |
| Mauritius                        | February-2021  |                0 |           16729 |             0.00 |
| Mauritius                        | March-2021     |                2 |           23585 |             0.01 |
| Mauritius                        | April-2021     |                5 |           35374 |             0.01 |
| Mexico                           | January-2020   |                0 |               0 |             NULL |
| Mexico                           | February-2020  |                0 |               5 |             0.00 |
| Mexico                           | March-2020     |               29 |            8124 |             0.36 |
| Mexico                           | April-2020     |             1830 |          229514 |             0.80 |
| Mexico                           | May-2020       |             8071 |         1560343 |             0.52 |
| Mexico                           | June-2020      |            17839 |         4692440 |             0.38 |
| Mexico                           | July-2020      |            18919 |        10107738 |             0.19 |
| Mexico                           | August-2020    |            17726 |        16108026 |             0.11 |
| Mexico                           | September-2020 |            13232 |        20309152 |             0.07 |
| Mexico                           | October-2020   |            14107 |        26077771 |             0.05 |
| Mexico                           | November-2020  |            14187 |        30342144 |             0.05 |
| Mexico                           | December-2020  |            19867 |        39586956 |             0.05 |
| Mexico                           | January-2021   |            32729 |        50652332 |             0.06 |
| Mexico                           | February-2021  |            27179 |        55678011 |             0.05 |
| Mexico                           | March-2021     |            17495 |        67295623 |             0.03 |
| Mexico                           | April-2021     |            13697 |        68840861 |             0.02 |
| Micronesia (country)             | January-2021   |                0 |              11 |             0.00 |
| Micronesia (country)             | February-2021  |                0 |              28 |             0.00 |
| Micronesia (country)             | March-2021     |                0 |              31 |             0.00 |
| Micronesia (country)             | April-2021     |                0 |              30 |             0.00 |
| Moldova                          | March-2020     |                4 |            2328 |             0.17 |
| Moldova                          | April-2020     |              112 |           62717 |             0.18 |
| Moldova                          | May-2020       |              179 |          183842 |             0.10 |
| Moldova                          | June-2020      |              250 |          370715 |             0.07 |
| Moldova                          | July-2020      |              233 |          633899 |             0.04 |
| Moldova                          | August-2020    |              217 |          948327 |             0.02 |
| Moldova                          | September-2020 |              325 |         1336462 |             0.02 |
| Moldova                          | October-2020   |              465 |         2024123 |             0.02 |
| Moldova                          | November-2020  |              519 |         2719636 |             0.02 |
| Moldova                          | December-2020  |              681 |         4002186 |             0.02 |
| Moldova                          | January-2021   |              453 |         4724038 |             0.01 |
| Moldova                          | February-2021  |              511 |         4799569 |             0.01 |
| Moldova                          | March-2021     |             1011 |         6450183 |             0.02 |
| Moldova                          | April-2021     |              852 |         7299198 |             0.01 |
| Monaco                           | February-2020  |                0 |               1 |             0.00 |
| Monaco                           | March-2020     |                1 |             433 |             0.23 |
| Monaco                           | April-2020     |                3 |            2606 |             0.12 |
| Monaco                           | May-2020       |                0 |            2993 |             0.00 |
| Monaco                           | June-2020      |                0 |            3000 |             0.00 |
| Monaco                           | July-2020      |                0 |            3437 |             0.00 |
| Monaco                           | August-2020    |                0 |            4408 |             0.00 |
| Monaco                           | September-2020 |               -2 |            5389 |            -0.04 |
| Monaco                           | October-2020   |                0 |            8263 |             0.00 |
| Monaco                           | November-2020  |                1 |           15872 |             0.01 |
| Monaco                           | December-2020  |                0 |           22056 |             0.00 |
| Monaco                           | January-2021   |               10 |           36725 |             0.03 |
| Monaco                           | February-2021  |               11 |           49492 |             0.02 |
| Monaco                           | March-2021     |                4 |           65951 |             0.01 |
| Monaco                           | April-2021     |                4 |           71688 |             0.01 |
| Mongolia                         | March-2020     |                0 |             150 |             0.00 |
| Mongolia                         | April-2020     |                0 |             784 |             0.00 |
| Mongolia                         | May-2020       |                0 |            3109 |             0.00 |
| Mongolia                         | June-2020      |                0 |            6073 |             0.00 |
| Mongolia                         | July-2020      |                0 |            8047 |             0.00 |
| Mongolia                         | August-2020    |                0 |            9204 |             0.00 |
| Mongolia                         | September-2020 |                0 |            9335 |             0.00 |
| Mongolia                         | October-2020   |                0 |           10071 |             0.00 |
| Mongolia                         | November-2020  |                0 |           15411 |             0.00 |
| Mongolia                         | December-2020  |                1 |           30313 |             0.00 |
| Mongolia                         | January-2021   |                1 |           47060 |             0.00 |
| Mongolia                         | February-2021  |                0 |           67025 |             0.00 |
| Mongolia                         | March-2021     |                6 |          149927 |             0.00 |
| Mongolia                         | April-2021     |              107 |          630670 |             0.02 |
| Montenegro                       | March-2020     |                2 |             702 |             0.28 |
| Montenegro                       | April-2020     |                5 |            8188 |             0.06 |
| Montenegro                       | May-2020       |                2 |           10037 |             0.02 |
| Montenegro                       | June-2020      |                3 |           10921 |             0.03 |
| Montenegro                       | July-2020      |               36 |           54628 |             0.07 |
| Montenegro                       | August-2020    |               52 |          124250 |             0.04 |
| Montenegro                       | September-2020 |               69 |          227189 |             0.03 |
| Montenegro                       | October-2020   |              132 |          461498 |             0.03 |
| Montenegro                       | November-2020  |              198 |          820589 |             0.02 |
| Montenegro                       | December-2020  |              183 |         1312373 |             0.01 |
| Montenegro                       | January-2021   |              123 |         1704974 |             0.01 |
| Montenegro                       | February-2021  |              198 |         1930633 |             0.01 |
| Montenegro                       | March-2021     |              271 |         2615404 |             0.01 |
| Montenegro                       | April-2021     |              221 |         2846834 |             0.01 |
| Montserrat                       | February-2021  |                0 |               0 |             NULL |
| Montserrat                       | March-2021     |                0 |               0 |             NULL |
| Montserrat                       | April-2021     |                0 |               0 |             NULL |
| Morocco                          | February-2020  |                0 |               0 |             NULL |
| Morocco                          | March-2020     |               36 |            3758 |             0.96 |
| Morocco                          | April-2020     |              134 |           71867 |             0.19 |
| Morocco                          | May-2020       |               35 |          203338 |             0.02 |
| Morocco                          | June-2020      |               23 |          284411 |             0.01 |
| Morocco                          | July-2020      |              125 |          530553 |             0.02 |
| Morocco                          | August-2020    |              788 |         1322632 |             0.06 |
| Morocco                          | September-2020 |             1053 |         2767280 |             0.04 |
| Morocco                          | October-2020   |             1501 |         5233086 |             0.03 |
| Morocco                          | November-2020  |             2151 |         8764895 |             0.02 |
| Morocco                          | December-2020  |             1542 |        12547642 |             0.01 |
| Morocco                          | January-2021   |              887 |        14188137 |             0.01 |
| Morocco                          | February-2021  |              348 |        13392533 |             0.00 |
| Morocco                          | March-2021     |              195 |        15182695 |             0.00 |
| Morocco                          | April-2021     |              205 |        15128193 |             0.00 |
| Mozambique                       | March-2020     |                0 |              56 |             0.00 |
| Mozambique                       | April-2020     |                0 |            1062 |             0.00 |
| Mozambique                       | May-2020       |                2 |            4381 |             0.05 |
| Mozambique                       | June-2020      |                4 |           17887 |             0.02 |
| Mozambique                       | July-2020      |                5 |           41760 |             0.01 |
| Mozambique                       | August-2020    |               12 |           88562 |             0.01 |
| Mozambique                       | September-2020 |               38 |          179950 |             0.02 |
| Mozambique                       | October-2020   |               31 |          332795 |             0.01 |
| Mozambique                       | November-2020  |               39 |          432481 |             0.01 |
| Mozambique                       | December-2020  |               35 |          532505 |             0.01 |
| Mozambique                       | January-2021   |              201 |          831521 |             0.02 |
| Mozambique                       | February-2021  |              274 |         1405822 |             0.02 |
| Mozambique                       | March-2021     |              134 |         2000023 |             0.01 |
| Mozambique                       | April-2021     |               39 |         2069494 |             0.00 |
| Myanmar                          | March-2020     |                1 |              55 |             1.82 |
| Myanmar                          | April-2020     |                5 |            2408 |             0.21 |
| Myanmar                          | May-2020       |                0 |            5780 |             0.00 |
| Myanmar                          | June-2020      |                0 |            8018 |             0.00 |
| Myanmar                          | July-2020      |                0 |           10335 |             0.00 |
| Myanmar                          | August-2020    |                0 |           13862 |             0.00 |
| Myanmar                          | September-2020 |              304 |          150402 |             0.20 |
| Myanmar                          | October-2020   |              927 |         1037537 |             0.09 |
| Myanmar                          | November-2020  |              704 |         2128623 |             0.03 |
| Myanmar                          | December-2020  |              741 |         3427806 |             0.02 |
| Myanmar                          | January-2021   |              449 |         4135212 |             0.01 |
| Myanmar                          | February-2021  |               68 |         3962034 |             0.00 |
| Myanmar                          | March-2021     |                7 |         4407423 |             0.00 |
| Myanmar                          | April-2021     |                3 |         4278611 |             0.00 |
| Namibia                          | March-2020     |                0 |              97 |             0.00 |
| Namibia                          | April-2020     |                0 |             472 |             0.00 |
| Namibia                          | May-2020       |                0 |             554 |             0.00 |
| Namibia                          | June-2020      |                0 |            1843 |             0.00 |
| Namibia                          | July-2020      |               10 |           33954 |             0.03 |
| Namibia                          | August-2020    |               65 |          137480 |             0.05 |
| Namibia                          | September-2020 |               46 |          293487 |             0.02 |
| Namibia                          | October-2020   |               12 |          377670 |             0.00 |
| Namibia                          | November-2020  |               18 |          407143 |             0.00 |
| Namibia                          | December-2020  |               54 |          559188 |             0.01 |
| Namibia                          | January-2021   |              147 |          923307 |             0.02 |
| Namibia                          | February-2021  |               72 |         1015143 |             0.01 |
| Namibia                          | March-2021     |               99 |         1287688 |             0.01 |
| Namibia                          | April-2021     |              119 |         1389191 |             0.01 |
| Nauru                            | April-2021     |                0 |               0 |             NULL |
| Nepal                            | January-2020   |                0 |               7 |             0.00 |
| Nepal                            | February-2020  |                0 |              29 |             0.00 |
| Nepal                            | March-2020     |                0 |              56 |             0.00 |
| Nepal                            | April-2020     |                0 |             792 |             0.00 |
| Nepal                            | May-2020       |                8 |           13506 |             0.06 |
| Nepal                            | June-2020      |               21 |          210352 |             0.01 |
| Nepal                            | July-2020      |               27 |          535535 |             0.01 |
| Nepal                            | August-2020    |              172 |          863563 |             0.02 |
| Nepal                            | September-2020 |              270 |         1747272 |             0.02 |
| Nepal                            | October-2020   |              439 |         3896377 |             0.01 |
| Nepal                            | November-2020  |              571 |         6233158 |             0.01 |
| Nepal                            | December-2020  |              348 |         7741083 |             0.00 |
| Nepal                            | January-2021   |              173 |         8268041 |             0.00 |
| Nepal                            | February-2021  |              745 |         7636928 |             0.01 |
| Nepal                            | March-2021     |              256 |         8542862 |             0.00 |
| Nepal                            | April-2021     |              249 |         8652964 |             0.00 |
| Netherlands                      | February-2020  |                0 |               8 |             0.00 |
| Netherlands                      | March-2020     |             1040 |          102010 |             1.02 |
| Netherlands                      | April-2020     |             3771 |          847556 |             0.44 |
| Netherlands                      | May-2020       |             1164 |         1357150 |             0.09 |
| Netherlands                      | June-2020      |              157 |         1467908 |             0.01 |
| Netherlands                      | July-2020      |               34 |         1610265 |             0.00 |
| Netherlands                      | August-2020    |               86 |         1986507 |             0.00 |
| Netherlands                      | September-2020 |              205 |         2803172 |             0.01 |
| Netherlands                      | October-2020   |             1002 |         7024864 |             0.01 |
| Netherlands                      | November-2020  |             1994 |        13649806 |             0.01 |
| Netherlands                      | December-2020  |             2072 |        20507503 |             0.01 |
| Netherlands                      | January-2021   |             2583 |        28343170 |             0.01 |
| Netherlands                      | February-2021  |             1580 |        29303549 |             0.01 |
| Netherlands                      | March-2021     |             1001 |        36901518 |             0.00 |
| Netherlands                      | April-2021     |              709 |        42290027 |             0.00 |
| New Zealand                      | February-2020  |                0 |               2 |             0.00 |
| New Zealand                      | March-2020     |                1 |            3637 |             0.03 |
| New Zealand                      | April-2020     |               18 |           38859 |             0.05 |
| New Zealand                      | May-2020       |                3 |           46429 |             0.01 |
| New Zealand                      | June-2020      |                0 |           45317 |             0.00 |
| New Zealand                      | July-2020      |                0 |           47976 |             0.00 |
| New Zealand                      | August-2020    |                0 |           50692 |             0.00 |
| New Zealand                      | September-2020 |                3 |           54113 |             0.01 |
| New Zealand                      | October-2020   |                0 |           58768 |             0.00 |
| New Zealand                      | November-2020  |                0 |           60239 |             0.00 |
| New Zealand                      | December-2020  |                0 |           65370 |             0.00 |
| New Zealand                      | January-2021   |                0 |           69608 |             0.00 |
| New Zealand                      | February-2021  |                1 |           65507 |             0.00 |
| New Zealand                      | March-2021     |                0 |           75612 |             0.00 |
| New Zealand                      | April-2021     |                0 |           77304 |             0.00 |
| Nicaragua                        | March-2020     |                1 |              33 |             3.03 |
| Nicaragua                        | April-2020     |                2 |             269 |             0.74 |
| Nicaragua                        | May-2020       |               32 |            6802 |             0.47 |
| Nicaragua                        | June-2020      |               48 |           49303 |             0.10 |
| Nicaragua                        | July-2020      |               33 |           95826 |             0.03 |
| Nicaragua                        | August-2020    |               21 |          128770 |             0.02 |
| Nicaragua                        | September-2020 |               14 |          146980 |             0.01 |
| Nicaragua                        | October-2020   |                5 |          165777 |             0.00 |
| Nicaragua                        | November-2020  |                4 |          170201 |             0.00 |
| Nicaragua                        | December-2020  |                5 |          183612 |             0.00 |
| Nicaragua                        | January-2021   |                4 |          190873 |             0.00 |
| Nicaragua                        | February-2021  |                4 |          178231 |             0.00 |
| Nicaragua                        | March-2021     |                5 |          203458 |             0.00 |
| Nicaragua                        | April-2021     |                4 |          203357 |             0.00 |
| Niger                            | March-2020     |                3 |             119 |             2.52 |
| Niger                            | April-2020     |               29 |           15083 |             0.19 |
| Niger                            | May-2020       |               32 |           26985 |             0.12 |
| Niger                            | June-2020      |                3 |           30260 |             0.01 |
| Niger                            | July-2020      |                2 |           34308 |             0.01 |
| Niger                            | August-2020    |                0 |           36069 |             0.00 |
| Niger                            | September-2020 |                0 |           35530 |             0.00 |
| Niger                            | October-2020   |                0 |           37451 |             0.00 |
| Niger                            | November-2020  |                3 |           39812 |             0.01 |
| Niger                            | December-2020  |               32 |           75726 |             0.04 |
| Niger                            | January-2021   |               55 |          125511 |             0.04 |
| Niger                            | February-2021  |               13 |          130884 |             0.01 |
| Niger                            | March-2021     |               14 |          151178 |             0.01 |
| Niger                            | April-2021     |                5 |          153386 |             0.00 |
| Nigeria                          | February-2020  |                0 |               2 |             0.00 |
| Nigeria                          | March-2020     |                2 |             843 |             0.24 |
| Nigeria                          | April-2020     |               56 |           19506 |             0.29 |
| Nigeria                          | May-2020       |              229 |          180866 |             0.13 |
| Nigeria                          | June-2020      |              303 |          521195 |             0.06 |
| Nigeria                          | July-2020      |              289 |         1081480 |             0.03 |
| Nigeria                          | August-2020    |              134 |         1523808 |             0.01 |
| Nigeria                          | September-2020 |               99 |         1697188 |             0.01 |
| Nigeria                          | October-2020   |               32 |         1889825 |             0.00 |
| Nigeria                          | November-2020  |               29 |         1957643 |             0.00 |
| Nigeria                          | December-2020  |              116 |         2359755 |             0.00 |
| Nigeria                          | January-2021   |              297 |         3386814 |             0.01 |
| Nigeria                          | February-2021  |              321 |         4086780 |             0.01 |
| Nigeria                          | March-2021     |              150 |         4974919 |             0.00 |
| Nigeria                          | April-2021     |                6 |         4922431 |             0.00 |
| North Macedonia                  | February-2020  |                0 |               4 |             0.00 |
| North Macedonia                  | March-2020     |                9 |            2469 |             0.36 |
| North Macedonia                  | April-2020     |               68 |           29086 |             0.23 |
| North Macedonia                  | May-2020       |               56 |           55465 |             0.10 |
| North Macedonia                  | June-2020      |              169 |          127852 |             0.13 |
| North Macedonia                  | July-2020      |              184 |          267796 |             0.07 |
| North Macedonia                  | August-2020    |              117 |          393574 |             0.03 |
| North Macedonia                  | September-2020 |              136 |          484487 |             0.03 |
| North Macedonia                  | October-2020   |              255 |          721228 |             0.04 |
| North Macedonia                  | November-2020  |              769 |         1422228 |             0.05 |
| North Macedonia                  | December-2020  |              740 |         2316938 |             0.03 |
| North Macedonia                  | January-2021   |              352 |         2736461 |             0.01 |
| North Macedonia                  | February-2021  |              282 |         2725082 |             0.01 |
| North Macedonia                  | March-2021     |              644 |         3572167 |             0.02 |
| North Macedonia                  | April-2021     |             1074 |         4319854 |             0.02 |
| Northern Cyprus                  | January-2021   |                0 |               0 |             NULL |
| Northern Cyprus                  | February-2021  |                0 |               0 |             NULL |
| Northern Cyprus                  | March-2021     |                0 |               0 |             NULL |
| Northern Cyprus                  | April-2021     |                0 |               0 |             NULL |
| Norway                           | February-2020  |                0 |              23 |             0.00 |
| Norway                           | March-2020     |               39 |           51448 |             0.08 |
| Norway                           | April-2020     |              171 |          200308 |             0.09 |
| Norway                           | May-2020       |               26 |          253969 |             0.01 |
| Norway                           | June-2020      |               14 |          259993 |             0.01 |
| Norway                           | July-2020      |                5 |          279850 |             0.00 |
| Norway                           | August-2020    |                9 |          309769 |             0.00 |
| Norway                           | September-2020 |               10 |          373709 |             0.00 |
| Norway                           | October-2020   |                8 |          512670 |             0.00 |
| Norway                           | November-2020  |               50 |          868805 |             0.01 |
| Norway                           | December-2020  |              104 |         1318834 |             0.01 |
| Norway                           | January-2021   |              128 |         1785238 |             0.01 |
| Norway                           | February-2021  |               58 |         1873818 |             0.00 |
| Norway                           | March-2021     |               51 |         2572627 |             0.00 |
| Norway                           | April-2021     |               83 |         3171867 |             0.00 |
| Oman                             | February-2020  |                0 |              22 |             0.00 |
| Oman                             | March-2020     |                1 |            1700 |             0.06 |
| Oman                             | April-2020     |               10 |           32202 |             0.03 |
| Oman                             | May-2020       |               38 |          169194 |             0.02 |
| Oman                             | June-2020      |              127 |          752585 |             0.02 |
| Oman                             | July-2020      |              245 |         1918861 |             0.01 |
| Oman                             | August-2020    |              264 |         2564645 |             0.01 |
| Oman                             | September-2020 |              250 |         2740993 |             0.01 |
| Oman                             | October-2020   |              273 |         3346098 |             0.01 |
| Oman                             | November-2020  |              215 |         3601350 |             0.01 |
| Oman                             | December-2020  |               76 |         3926319 |             0.00 |
| Oman                             | January-2021   |               30 |         4078314 |             0.00 |
| Oman                             | February-2021  |               41 |         3852400 |             0.00 |
| Oman                             | March-2021     |              108 |         4607228 |             0.00 |
| Oman                             | April-2021     |              332 |         5301318 |             0.01 |
| Pakistan                         | February-2020  |                0 |              14 |             0.00 |
| Pakistan                         | March-2020     |               27 |           17691 |             0.15 |
| Pakistan                         | April-2020     |              390 |          246405 |             0.16 |
| Pakistan                         | May-2020       |             1126 |         1316336 |             0.09 |
| Pakistan                         | June-2020      |             2852 |         4450339 |             0.06 |
| Pakistan                         | July-2020      |             1556 |         7910429 |             0.02 |
| Pakistan                         | August-2020    |              343 |         8934372 |             0.00 |
| Pakistan                         | September-2020 |              190 |         9118734 |             0.00 |
| Pakistan                         | October-2020   |              339 |        10005964 |             0.00 |
| Pakistan                         | November-2020  |             1268 |        10891173 |             0.01 |
| Pakistan                         | December-2020  |             2085 |        13839663 |             0.02 |
| Pakistan                         | January-2021   |             1507 |        16029828 |             0.01 |
| Pakistan                         | February-2021  |             1213 |        15805181 |             0.01 |
| Pakistan                         | March-2021     |             1634 |        19174307 |             0.01 |
| Pakistan                         | April-2021     |             3427 |        22487129 |             0.02 |
| Palestine                        | March-2020     |                1 |            1355 |             0.07 |
| Palestine                        | April-2020     |                1 |            8597 |             0.01 |
| Palestine                        | May-2020       |                1 |           12240 |             0.01 |
| Palestine                        | June-2020      |                5 |           25938 |             0.02 |
| Palestine                        | July-2020      |               74 |          230938 |             0.03 |
| Palestine                        | August-2020    |               70 |          519581 |             0.01 |
| Palestine                        | September-2020 |              159 |          965368 |             0.02 |
| Palestine                        | October-2020   |              172 |         1445125 |             0.01 |
| Palestine                        | November-2020  |              249 |         1983791 |             0.01 |
| Palestine                        | December-2020  |              668 |         3560267 |             0.02 |
| Palestine                        | January-2021   |              433 |         4668798 |             0.01 |
| Palestine                        | February-2021  |              209 |         4737219 |             0.00 |
| Palestine                        | March-2021     |              585 |         6630876 |             0.01 |
| Palestine                        | April-2021     |              622 |         8237354 |             0.01 |
| Panama                           | March-2020     |               30 |            7317 |             0.41 |
| Panama                           | April-2020     |              158 |          112687 |             0.14 |
| Panama                           | May-2020       |              148 |          296760 |             0.05 |
| Panama                           | June-2020      |              295 |          671302 |             0.04 |
| Panama                           | July-2020      |              790 |         1544999 |             0.05 |
| Panama                           | August-2020    |              581 |         2495408 |             0.02 |
| Panama                           | September-2020 |              370 |         3095304 |             0.01 |
| Panama                           | October-2020   |              328 |         3823490 |             0.01 |
| Panama                           | November-2020  |              379 |         4442214 |             0.01 |
| Panama                           | December-2020  |              943 |         6281785 |             0.02 |
| Panama                           | January-2021   |             1248 |         9023901 |             0.01 |
| Panama                           | February-2021  |              575 |         9296807 |             0.01 |
| Panama                           | March-2021     |              269 |        10808142 |             0.00 |
| Panama                           | April-2021     |              118 |        10799722 |             0.00 |
| Papua New Guinea                 | March-2020     |                0 |              12 |             0.00 |
| Papua New Guinea                 | April-2020     |                0 |             139 |             0.00 |
| Papua New Guinea                 | May-2020       |                0 |             248 |             0.00 |
| Papua New Guinea                 | June-2020      |                0 |             261 |             0.00 |
| Papua New Guinea                 | July-2020      |                2 |             786 |             0.25 |
| Papua New Guinea                 | August-2020    |                3 |            9181 |             0.03 |
| Papua New Guinea                 | September-2020 |                2 |           15304 |             0.01 |
| Papua New Guinea                 | October-2020   |                0 |           17613 |             0.00 |
| Papua New Guinea                 | November-2020  |                0 |           18326 |             0.00 |
| Papua New Guinea                 | December-2020  |                2 |           22656 |             0.01 |
| Papua New Guinea                 | January-2021   |                0 |           25582 |             0.00 |
| Papua New Guinea                 | February-2021  |                3 |           27487 |             0.01 |
| Papua New Guinea                 | March-2021     |               48 |           87886 |             0.05 |
| Papua New Guinea                 | April-2021     |               47 |          271554 |             0.02 |
| Paraguay                         | March-2020     |                3 |             546 |             0.55 |
| Paraguay                         | April-2020     |                7 |            5046 |             0.14 |
| Paraguay                         | May-2020       |                1 |           22319 |             0.00 |
| Paraguay                         | June-2020      |                6 |           41461 |             0.01 |
| Paraguay                         | July-2020      |               32 |          107086 |             0.03 |
| Paraguay                         | August-2020    |              277 |          322154 |             0.09 |
| Paraguay                         | September-2020 |              531 |          895368 |             0.06 |
| Paraguay                         | October-2020   |              547 |         1643914 |             0.03 |
| Paraguay                         | November-2020  |              352 |         2172533 |             0.02 |
| Paraguay                         | December-2020  |              506 |         2979709 |             0.02 |
| Paraguay                         | January-2021   |              456 |         3746546 |             0.01 |
| Paraguay                         | February-2021  |              463 |         4076019 |             0.01 |
| Paraguay                         | March-2021     |             1025 |         5750218 |             0.02 |
| Paraguay                         | April-2021     |             2179 |         7379850 |             0.03 |
| Peru                             | January-2020   |                0 |               0 |             NULL |
| Peru                             | February-2020  |                0 |               0 |             NULL |
| Peru                             | March-2020     |               30 |            7702 |             0.39 |
| Peru                             | April-2020     |             1021 |          410944 |             0.25 |
| Peru                             | May-2020       |             3455 |         2852556 |             0.12 |
| Peru                             | June-2020      |             5171 |         6934846 |             0.07 |
| Peru                             | July-2020      |             9344 |        10661731 |             0.09 |
| Peru                             | August-2020    |             9767 |        16405207 |             0.06 |
| Peru                             | September-2020 |             3608 |        22054476 |             0.02 |
| Peru                             | October-2020   |             2015 |        26653391 |             0.01 |
| Peru                             | November-2020  |             1512 |        28025436 |             0.01 |
| Peru                             | December-2020  |             1757 |        30624534 |             0.01 |
| Peru                             | January-2021   |             3346 |        32876154 |             0.01 |
| Peru                             | February-2021  |             5273 |        34491490 |             0.02 |
| Peru                             | March-2021     |             5709 |        44328085 |             0.01 |
| Peru                             | April-2021     |             9469 |        50368511 |             0.02 |
| Philippines                      | January-2020   |                0 |               2 |             0.00 |
| Philippines                      | February-2020  |                1 |              80 |             1.25 |
| Philippines                      | March-2020     |               87 |           11453 |             0.76 |
| Philippines                      | April-2020     |              480 |          163684 |             0.29 |
| Philippines                      | May-2020       |              389 |          386438 |             0.10 |
| Philippines                      | June-2020      |              309 |          813411 |             0.04 |
| Philippines                      | July-2020      |              757 |         1949430 |             0.04 |
| Philippines                      | August-2020    |             1535 |         4980560 |             0.03 |
| Philippines                      | September-2020 |             1946 |         8070661 |             0.02 |
| Philippines                      | October-2020   |             1717 |        10848463 |             0.02 |
| Philippines                      | November-2020  |             1171 |        12238336 |             0.01 |
| Philippines                      | December-2020  |              852 |        14069315 |             0.01 |
| Philippines                      | January-2021   |             1505 |        15468721 |             0.01 |
| Philippines                      | February-2021  |             1569 |        15404710 |             0.01 |
| Philippines                      | March-2021     |              979 |        19944409 |             0.00 |
| Philippines                      | April-2021     |             3937 |        27170027 |             0.01 |
| Poland                           | March-2020     |               33 |           16224 |             0.20 |
| Poland                           | April-2020     |              611 |          235230 |             0.26 |
| Poland                           | May-2020       |              420 |          568704 |             0.07 |
| Poland                           | June-2020      |              399 |          890824 |             0.04 |
| Poland                           | July-2020      |              253 |         1223582 |             0.02 |
| Poland                           | August-2020    |              323 |         1758274 |             0.02 |
| Poland                           | September-2020 |              474 |         2314353 |             0.02 |
| Poland                           | October-2020   |             3118 |         5617354 |             0.06 |
| Poland                           | November-2020  |            11519 |        21289192 |             0.05 |
| Poland                           | December-2020  |            11404 |        35868875 |             0.03 |
| Poland                           | January-2021   |             8626 |        43986631 |             0.02 |
| Poland                           | February-2021  |             6589 |        44741606 |             0.01 |
| Poland                           | March-2021     |             9276 |        61090282 |             0.02 |
| Poland                           | April-2021     |            14457 |        78591316 |             0.02 |
| Portugal                         | February-2020  |                0 |               0 |             NULL |
| Portugal                         | March-2020     |              160 |           46919 |             0.34 |
| Portugal                         | April-2020     |              829 |          533042 |             0.16 |
| Portugal                         | May-2020       |              421 |          891512 |             0.05 |
| Portugal                         | June-2020      |              166 |         1120468 |             0.01 |
| Portugal                         | July-2020      |              159 |         1466385 |             0.01 |
| Portugal                         | August-2020    |               87 |         1681411 |             0.01 |
| Portugal                         | September-2020 |              149 |         1979547 |             0.01 |
| Portugal                         | October-2020   |              536 |         3100387 |             0.02 |
| Portugal                         | November-2020  |             1998 |         6631134 |             0.03 |
| Portugal                         | December-2020  |             2401 |        11078455 |             0.02 |
| Portugal                         | January-2021   |             5576 |        17049576 |             0.03 |
| Portugal                         | February-2021  |             3835 |        21832473 |             0.02 |
| Portugal                         | March-2021     |              531 |        25249953 |             0.00 |
| Portugal                         | April-2021     |              126 |        24884086 |             0.00 |
| Qatar                            | February-2020  |                0 |               1 |             0.00 |
| Qatar                            | March-2020     |                2 |           10292 |             0.02 |
| Qatar                            | April-2020     |                8 |          156835 |             0.01 |
| Qatar                            | May-2020       |               28 |         1004693 |             0.00 |
| Qatar                            | June-2020      |               75 |         2393921 |             0.00 |
| Qatar                            | July-2020      |               61 |         3253053 |             0.00 |
| Qatar                            | August-2020    |               23 |         3564216 |             0.00 |
| Qatar                            | September-2020 |               17 |         3670670 |             0.00 |
| Qatar                            | October-2020   |               18 |         4003427 |             0.00 |
| Qatar                            | November-2020  |                5 |         4075334 |             0.00 |
| Qatar                            | December-2020  |                8 |         4383960 |             0.00 |
| Qatar                            | January-2021   |                3 |         4566164 |             0.00 |
| Qatar                            | February-2021  |               10 |         4411295 |             0.00 |
| Qatar                            | March-2021     |               33 |         5315332 |             0.00 |
| Qatar                            | April-2021     |              167 |         5816640 |             0.00 |
| Romania                          | February-2020  |                0 |               8 |             0.00 |
| Romania                          | March-2020     |               82 |           14734 |             0.56 |
| Romania                          | April-2020     |              635 |          222963 |             0.28 |
| Romania                          | May-2020       |              549 |          507655 |             0.11 |
| Romania                          | June-2020      |              385 |          680012 |             0.06 |
| Romania                          | July-2020      |              692 |         1133525 |             0.06 |
| Romania                          | August-2020    |             1278 |         2170182 |             0.06 |
| Romania                          | September-2020 |             1204 |         3212048 |             0.04 |
| Romania                          | October-2020   |             2143 |         5464640 |             0.04 |
| Romania                          | November-2020  |             4363 |        10889047 |             0.04 |
| Romania                          | December-2020  |             4436 |        17531041 |             0.03 |
| Romania                          | January-2021   |             2568 |        21284511 |             0.01 |
| Romania                          | February-2021  |             2015 |        21393593 |             0.01 |
| Romania                          | March-2021     |             3188 |        27072367 |             0.01 |
| Romania                          | April-2021     |             4571 |        30490112 |             0.01 |
| Russia                           | January-2020   |                0 |               2 |             0.00 |
| Russia                           | February-2020  |                0 |              58 |             0.00 |
| Russia                           | March-2020     |               17 |           12224 |             0.14 |
| Russia                           | April-2020     |             1056 |         1129437 |             0.09 |
| Russia                           | May-2020       |             3620 |         8257093 |             0.04 |
| Russia                           | June-2020      |             4613 |        16097579 |             0.03 |
| Russia                           | July-2020      |             4633 |        23233041 |             0.02 |
| Russia                           | August-2020    |             3189 |        28508044 |             0.01 |
| Russia                           | September-2020 |             3502 |        32289140 |             0.01 |
| Russia                           | October-2020   |             7157 |        42549555 |             0.02 |
| Russia                           | November-2020  |            11704 |        57925419 |             0.02 |
| Russia                           | December-2020  |            16780 |        84102182 |             0.02 |
| Russia                           | January-2021   |            15758 |       108422409 |             0.01 |
| Russia                           | February-2021  |            12671 |       112712911 |             0.01 |
| Russia                           | March-2021     |            12519 |       135088504 |             0.01 |
| Russia                           | April-2021     |            11071 |       138817103 |             0.01 |
| Rwanda                           | March-2020     |                0 |             579 |             0.00 |
| Rwanda                           | April-2020     |                0 |            4265 |             0.00 |
| Rwanda                           | May-2020       |                1 |            9340 |             0.01 |
| Rwanda                           | June-2020      |                1 |           18926 |             0.01 |
| Rwanda                           | July-2020      |                3 |           46037 |             0.01 |
| Rwanda                           | August-2020    |               11 |           83766 |             0.01 |
| Rwanda                           | September-2020 |               13 |          137668 |             0.01 |
| Rwanda                           | October-2020   |                6 |          154093 |             0.00 |
| Rwanda                           | November-2020  |               14 |          164524 |             0.01 |
| Rwanda                           | December-2020  |               43 |          216567 |             0.02 |
| Rwanda                           | January-2021   |              104 |          348874 |             0.03 |
| Rwanda                           | February-2021  |               65 |          485642 |             0.01 |
| Rwanda                           | March-2021     |               46 |          631948 |             0.01 |
| Rwanda                           | April-2021     |               28 |          711088 |             0.00 |
| Saint Helena                     | February-2021  |                0 |               0 |             NULL |
| Saint Helena                     | March-2021     |                0 |               0 |             NULL |
| Saint Helena                     | April-2021     |                0 |               0 |             NULL |
| Saint Kitts and Nevis            | March-2020     |                0 |              25 |             0.00 |
| Saint Kitts and Nevis            | April-2020     |                0 |             385 |             0.00 |
| Saint Kitts and Nevis            | May-2020       |                0 |             465 |             0.00 |
| Saint Kitts and Nevis            | June-2020      |                0 |             450 |             0.00 |
| Saint Kitts and Nevis            | July-2020      |                0 |             515 |             0.00 |
| Saint Kitts and Nevis            | August-2020    |                0 |             527 |             0.00 |
| Saint Kitts and Nevis            | September-2020 |                0 |             530 |             0.00 |
| Saint Kitts and Nevis            | October-2020   |                0 |             589 |             0.00 |
| Saint Kitts and Nevis            | November-2020  |                0 |             593 |             0.00 |
| Saint Kitts and Nevis            | December-2020  |                0 |             862 |             0.00 |
| Saint Kitts and Nevis            | January-2021   |                0 |            1072 |             0.00 |
| Saint Kitts and Nevis            | February-2021  |                0 |            1130 |             0.00 |
| Saint Kitts and Nevis            | March-2021     |                0 |            1325 |             0.00 |
| Saint Kitts and Nevis            | April-2021     |                0 |            1320 |             0.00 |
| Saint Lucia                      | March-2020     |                0 |              66 |             0.00 |
| Saint Lucia                      | April-2020     |                0 |             442 |             0.00 |
| Saint Lucia                      | May-2020       |                0 |             556 |             0.00 |
| Saint Lucia                      | June-2020      |                0 |             567 |             0.00 |
| Saint Lucia                      | July-2020      |                0 |             703 |             0.00 |
| Saint Lucia                      | August-2020    |                0 |             789 |             0.00 |
| Saint Lucia                      | September-2020 |                0 |             802 |             0.00 |
| Saint Lucia                      | October-2020   |                0 |            1254 |             0.00 |
| Saint Lucia                      | November-2020  |                2 |            5201 |             0.04 |
| Saint Lucia                      | December-2020  |                3 |            8909 |             0.03 |
| Saint Lucia                      | January-2021   |                8 |           20063 |             0.04 |
| Saint Lucia                      | February-2021  |               22 |           68586 |             0.03 |
| Saint Lucia                      | March-2021     |               25 |          124502 |             0.02 |
| Saint Lucia                      | April-2021     |               14 |          131631 |             0.01 |
| Saint Vincent and the Grenadines | March-2020     |                0 |              18 |             0.00 |
| Saint Vincent and the Grenadines | April-2020     |                0 |             329 |             0.00 |
| Saint Vincent and the Grenadines | May-2020       |                0 |             567 |             0.00 |
| Saint Vincent and the Grenadines | June-2020      |                0 |             834 |             0.00 |
| Saint Vincent and the Grenadines | July-2020      |                0 |            1233 |             0.00 |
| Saint Vincent and the Grenadines | August-2020    |                0 |            1779 |             0.00 |
| Saint Vincent and the Grenadines | September-2020 |                0 |            1894 |             0.00 |
| Saint Vincent and the Grenadines | October-2020   |                0 |            2092 |             0.00 |
| Saint Vincent and the Grenadines | November-2020  |                0 |            2400 |             0.00 |
| Saint Vincent and the Grenadines | December-2020  |                0 |            3070 |             0.00 |
| Saint Vincent and the Grenadines | January-2021   |                2 |           14455 |             0.01 |
| Saint Vincent and the Grenadines | February-2021  |                6 |           38221 |             0.02 |
| Saint Vincent and the Grenadines | March-2021     |                2 |           52231 |             0.00 |
| Saint Vincent and the Grenadines | April-2021     |                1 |           54187 |             0.00 |
| Samoa                            | November-2020  |                0 |              17 |             0.00 |
| Samoa                            | December-2020  |                0 |              62 |             0.00 |
| Samoa                            | January-2021   |                0 |              62 |             0.00 |
| Samoa                            | February-2021  |                0 |              70 |             0.00 |
| Samoa                            | March-2021     |                0 |              93 |             0.00 |
| Samoa                            | April-2021     |                0 |              90 |             0.00 |
| San Marino                       | February-2020  |                0 |               3 |             0.00 |
| San Marino                       | March-2020     |               26 |            3461 |             0.75 |
| San Marino                       | April-2020     |               15 |           12054 |             0.12 |
| San Marino                       | May-2020       |                1 |           19843 |             0.01 |
| San Marino                       | June-2020      |                0 |           20723 |             0.00 |
| San Marino                       | July-2020      |                0 |           21661 |             0.00 |
| San Marino                       | August-2020    |                0 |           21784 |             0.00 |
| San Marino                       | September-2020 |                0 |           21717 |             0.00 |
| San Marino                       | October-2020   |                0 |           24252 |             0.00 |
| San Marino                       | November-2020  |                4 |           38064 |             0.01 |
| San Marino                       | December-2020  |               13 |           62595 |             0.02 |
| San Marino                       | January-2021   |                8 |           85076 |             0.01 |
| San Marino                       | February-2021  |                7 |           93487 |             0.01 |
| San Marino                       | March-2021     |               10 |          130848 |             0.01 |
| San Marino                       | April-2021     |                6 |          149013 |             0.00 |
| Sao Tome and Principe            | April-2020     |                0 |             118 |             0.00 |
| Sao Tome and Principe            | May-2020       |               12 |            7624 |             0.16 |
| Sao Tome and Principe            | June-2020      |                1 |           18865 |             0.01 |
| Sao Tome and Principe            | July-2020      |                2 |           23753 |             0.01 |
| Sao Tome and Principe            | August-2020    |                0 |           27436 |             0.00 |
| Sao Tome and Principe            | September-2020 |                0 |           27146 |             0.00 |
| Sao Tome and Principe            | October-2020   |                1 |           28809 |             0.00 |
| Sao Tome and Principe            | November-2020  |                1 |           29081 |             0.00 |
| Sao Tome and Principe            | December-2020  |                0 |           31257 |             0.00 |
| Sao Tome and Principe            | January-2021   |                0 |           34943 |             0.00 |
| Sao Tome and Principe            | February-2021  |               12 |           42060 |             0.03 |
| Sao Tome and Principe            | March-2021     |                5 |           64204 |             0.01 |
| Sao Tome and Principe            | April-2021     |                1 |           68164 |             0.00 |
| Saudi Arabia                     | March-2020     |               10 |           12266 |             0.08 |
| Saudi Arabia                     | April-2020     |              152 |          262096 |             0.06 |
| Saudi Arabia                     | May-2020       |              341 |         1660260 |             0.02 |
| Saudi Arabia                     | June-2020      |             1146 |         4063590 |             0.03 |
| Saudi Arabia                     | July-2020      |             1217 |         7458294 |             0.02 |
| Saudi Arabia                     | August-2020    |             1031 |         9232859 |             0.01 |
| Saudi Arabia                     | September-2020 |              871 |         9799409 |             0.01 |
| Saudi Arabia                     | October-2020   |              634 |        10580404 |             0.01 |
| Saudi Arabia                     | November-2020  |              494 |        10591512 |             0.00 |
| Saudi Arabia                     | December-2020  |              327 |        11170841 |             0.00 |
| Saudi Arabia                     | January-2021   |              152 |        11315754 |             0.00 |
| Saudi Arabia                     | February-2021  |              119 |        10439661 |             0.00 |
| Saudi Arabia                     | March-2021     |              175 |        11883601 |             0.00 |
| Saudi Arabia                     | April-2021     |              288 |        12092823 |             0.00 |
| Senegal                          | February-2020  |                0 |               0 |             NULL |
| Senegal                          | March-2020     |                0 |            1444 |             0.00 |
| Senegal                          | April-2020     |                9 |           12025 |             0.07 |
| Senegal                          | May-2020       |               33 |           72254 |             0.05 |
| Senegal                          | June-2020      |               70 |          157369 |             0.04 |
| Senegal                          | July-2020      |               93 |          264469 |             0.04 |
| Senegal                          | August-2020    |               79 |          372440 |             0.02 |
| Senegal                          | September-2020 |               27 |          432699 |             0.01 |
| Senegal                          | October-2020   |               13 |          476074 |             0.00 |
| Senegal                          | November-2020  |                9 |          474263 |             0.00 |
| Senegal                          | December-2020  |               77 |          540600 |             0.01 |
| Senegal                          | January-2021   |              218 |          704660 |             0.03 |
| Senegal                          | February-2021  |              244 |          865118 |             0.03 |
| Senegal                          | March-2021     |              179 |         1146849 |             0.02 |
| Senegal                          | April-2021     |               56 |         1188702 |             0.00 |
| Serbia                           | February-2020  |                0 |               0 |             NULL |
| Serbia                           | March-2020     |               16 |            5865 |             0.27 |
| Serbia                           | April-2020     |              163 |          149995 |             0.11 |
| Serbia                           | May-2020       |               64 |          324948 |             0.02 |
| Serbia                           | June-2020      |               34 |          377220 |             0.01 |
| Serbia                           | July-2020      |              296 |          618471 |             0.05 |
| Serbia                           | August-2020    |              140 |          906472 |             0.02 |
| Serbia                           | September-2020 |               36 |          976669 |             0.00 |
| Serbia                           | October-2020   |               71 |         1146697 |             0.01 |
| Serbia                           | November-2020  |              784 |         2898418 |             0.03 |
| Serbia                           | December-2020  |             1607 |         8500530 |             0.02 |
| Serbia                           | January-2021   |              809 |        11459767 |             0.01 |
| Serbia                           | February-2021  |              423 |        11879989 |             0.00 |
| Serbia                           | March-2021     |              865 |        16376145 |             0.01 |
| Serbia                           | April-2021     |             1054 |        19596057 |             0.01 |
| Seychelles                       | March-2020     |                0 |             111 |             0.00 |
| Seychelles                       | April-2020     |                0 |             325 |             0.00 |
| Seychelles                       | May-2020       |                0 |             341 |             0.00 |
| Seychelles                       | June-2020      |                0 |             534 |             0.00 |
| Seychelles                       | July-2020      |                0 |            3122 |             0.00 |
| Seychelles                       | August-2020    |                0 |            3972 |             0.00 |
| Seychelles                       | September-2020 |                0 |            4195 |             0.00 |
| Seychelles                       | October-2020   |                0 |            4631 |             0.00 |
| Seychelles                       | November-2020  |                0 |            4863 |             0.00 |
| Seychelles                       | December-2020  |                0 |            6178 |             0.00 |
| Seychelles                       | January-2021   |                4 |           22300 |             0.02 |
| Seychelles                       | February-2021  |                7 |           55056 |             0.01 |
| Seychelles                       | March-2021     |               11 |          106823 |             0.01 |
| Seychelles                       | April-2021     |                6 |          144133 |             0.00 |
| Sierra Leone                     | March-2020     |                0 |               1 |             0.00 |
| Sierra Leone                     | April-2020     |                7 |            1108 |             0.63 |
| Sierra Leone                     | May-2020       |               39 |           14797 |             0.26 |
| Sierra Leone                     | June-2020      |               14 |           35399 |             0.04 |
| Sierra Leone                     | July-2020      |                7 |           51771 |             0.01 |
| Sierra Leone                     | August-2020    |                3 |           60266 |             0.00 |
| Sierra Leone                     | September-2020 |                2 |           63761 |             0.00 |
| Sierra Leone                     | October-2020   |                2 |           71801 |             0.00 |
| Sierra Leone                     | November-2020  |                0 |           71748 |             0.00 |
| Sierra Leone                     | December-2020  |                2 |           76929 |             0.00 |
| Sierra Leone                     | January-2021   |                3 |           92626 |             0.00 |
| Sierra Leone                     | February-2021  |                0 |          106690 |             0.00 |
| Sierra Leone                     | March-2021     |                0 |          122060 |             0.00 |
| Sierra Leone                     | April-2021     |                0 |          120558 |             0.00 |
| Singapore                        | January-2020   |                0 |              53 |             0.00 |
| Singapore                        | February-2020  |                0 |            1795 |             0.00 |
| Singapore                        | March-2020     |                3 |           11276 |             0.03 |
| Singapore                        | April-2020     |               12 |          188949 |             0.01 |
| Singapore                        | May-2020       |                8 |          824865 |             0.00 |
| Singapore                        | June-2020      |                3 |         1210239 |             0.00 |
| Singapore                        | July-2020      |                1 |         1472037 |             0.00 |
| Singapore                        | August-2020    |                0 |         1719511 |             0.00 |
| Singapore                        | September-2020 |                0 |         1721643 |             0.00 |
| Singapore                        | October-2020   |                1 |         1794938 |             0.00 |
| Singapore                        | November-2020  |                1 |         1743530 |             0.00 |
| Singapore                        | December-2020  |                0 |         1809806 |             0.00 |
| Singapore                        | January-2021   |                0 |         1831362 |             0.00 |
| Singapore                        | February-2021  |                0 |         1673891 |             0.00 |
| Singapore                        | March-2021     |                1 |         1864345 |             0.00 |
| Singapore                        | April-2021     |                0 |         1822946 |             0.00 |
| Slovakia                         | March-2020     |                0 |            3440 |             0.00 |
| Slovakia                         | April-2020     |               23 |           28263 |             0.08 |
| Slovakia                         | May-2020       |                5 |           45753 |             0.01 |
| Slovakia                         | June-2020      |                0 |           47133 |             0.00 |
| Slovakia                         | July-2020      |                1 |           60846 |             0.00 |
| Slovakia                         | August-2020    |                4 |           92437 |             0.00 |
| Slovakia                         | September-2020 |               15 |          187265 |             0.01 |
| Slovakia                         | October-2020   |              171 |          891676 |             0.02 |
| Slovakia                         | November-2020  |              620 |         2567554 |             0.02 |
| Slovakia                         | December-2020  |             1299 |         4363337 |             0.03 |
| Slovakia                         | January-2021   |             2504 |         6785954 |             0.04 |
| Slovakia                         | February-2021  |             2547 |         7798032 |             0.03 |
| Slovakia                         | March-2021     |             2530 |        10497944 |             0.02 |
| Slovakia                         | April-2021     |             1965 |        11201875 |             0.02 |
| Slovenia                         | February-2020  |                0 |               0 |             NULL |
| Slovenia                         | March-2020     |               15 |            8609 |             0.17 |
| Slovenia                         | April-2020     |               76 |           36605 |             0.21 |
| Slovenia                         | May-2020       |               17 |           45272 |             0.04 |
| Slovenia                         | June-2020      |                3 |           45374 |             0.01 |
| Slovenia                         | July-2020      |                8 |           58783 |             0.01 |
| Slovenia                         | August-2020    |               14 |           76193 |             0.02 |
| Slovenia                         | September-2020 |               17 |          121393 |             0.01 |
| Slovenia                         | October-2020   |              188 |          454130 |             0.04 |
| Slovenia                         | November-2020  |             1097 |         1671542 |             0.07 |
| Slovenia                         | December-2020  |             1262 |         3098836 |             0.04 |
| Slovenia                         | January-2021   |              806 |         4541774 |             0.02 |
| Slovenia                         | February-2021  |              333 |         5025008 |             0.01 |
| Slovenia                         | March-2021     |              211 |         6272871 |             0.00 |
| Slovenia                         | April-2021     |              203 |         6883212 |             0.00 |
| Solomon Islands                  | October-2020   |                0 |              87 |             0.00 |
| Solomon Islands                  | November-2020  |                0 |             458 |             0.00 |
| Solomon Islands                  | December-2020  |                0 |             527 |             0.00 |
| Solomon Islands                  | January-2021   |                0 |             527 |             0.00 |
| Solomon Islands                  | February-2021  |                0 |             495 |             0.00 |
| Solomon Islands                  | March-2021     |                0 |             559 |             0.00 |
| Solomon Islands                  | April-2021     |                0 |             585 |             0.00 |
| Somalia                          | March-2020     |                0 |              29 |             0.00 |
| Somalia                          | April-2020     |               28 |            5314 |             0.53 |
| Somalia                          | May-2020       |               50 |           40774 |             0.12 |
| Somalia                          | June-2020      |               12 |           77531 |             0.02 |
| Somalia                          | July-2020      |                3 |           95846 |             0.00 |
| Somalia                          | August-2020    |                5 |          100817 |             0.00 |
| Somalia                          | September-2020 |                1 |          102629 |             0.00 |
| Somalia                          | October-2020   |                5 |          118956 |             0.00 |
| Somalia                          | November-2020  |                9 |          129609 |             0.01 |
| Somalia                          | December-2020  |               17 |          143124 |             0.01 |
| Somalia                          | January-2021   |                0 |          146980 |             0.00 |
| Somalia                          | February-2021  |              109 |          154727 |             0.07 |
| Somalia                          | March-2021     |              290 |          292095 |             0.10 |
| Somalia                          | April-2021     |              184 |          384553 |             0.05 |
| South Africa                     | February-2020  |                0 |               0 |             NULL |
| South Africa                     | March-2020     |                5 |           10173 |             0.05 |
| South Africa                     | April-2020     |               98 |           88044 |             0.11 |
| South Africa                     | May-2020       |              580 |          497374 |             0.12 |
| South Africa                     | June-2020      |             1974 |         2421471 |             0.08 |
| South Africa                     | July-2020      |             5348 |        10057917 |             0.05 |
| South Africa                     | August-2020    |             6144 |        17952588 |             0.03 |
| South Africa                     | September-2020 |             2585 |        19588033 |             0.01 |
| South Africa                     | October-2020   |             2542 |        21710951 |             0.01 |
| South Africa                     | November-2020  |             2259 |        22626679 |             0.01 |
| South Africa                     | December-2020  |             6934 |        27842916 |             0.02 |
| South Africa                     | January-2021   |            15695 |        40240702 |             0.04 |
| South Africa                     | February-2021  |             5829 |        41711243 |             0.01 |
| South Africa                     | March-2021     |             2853 |        47472251 |             0.01 |
| South Africa                     | April-2021     |             1504 |        46922791 |             0.00 |
| South Korea                      | January-2020   |                0 |              36 |             0.00 |
| South Korea                      | February-2020  |               16 |           12128 |             0.13 |
| South Korea                      | March-2020     |              146 |          244918 |             0.06 |
| South Korea                      | April-2020     |               86 |          315431 |             0.03 |
| South Korea                      | May-2020       |               23 |          342959 |             0.01 |
| South Korea                      | June-2020      |               11 |          365805 |             0.00 |
| South Korea                      | July-2020      |               19 |          423421 |             0.00 |
| South Korea                      | August-2020    |               23 |          505449 |             0.00 |
| South Korea                      | September-2020 |               91 |          673170 |             0.01 |
| South Korea                      | October-2020   |               51 |          780435 |             0.01 |
| South Korea                      | November-2020  |               60 |          888618 |             0.01 |
| South Korea                      | December-2020  |              391 |         1463251 |             0.03 |
| South Korea                      | January-2021   |              508 |         2220738 |             0.02 |
| South Korea                      | February-2021  |              180 |         2364057 |             0.01 |
| South Korea                      | March-2021     |              130 |         3003141 |             0.00 |
| South Korea                      | April-2021     |               96 |         3395144 |             0.00 |
| South Sudan                      | April-2020     |                0 |             191 |             0.00 |
| South Sudan                      | May-2020       |               10 |           12050 |             0.08 |
| South Sudan                      | June-2020      |               28 |           49168 |             0.06 |
| South Sudan                      | July-2020      |                8 |           66680 |             0.01 |
| South Sudan                      | August-2020    |                1 |           76852 |             0.00 |
| South Sudan                      | September-2020 |                2 |           78188 |             0.00 |
| South Sudan                      | October-2020   |                9 |           87229 |             0.01 |
| South Sudan                      | November-2020  |                3 |           90188 |             0.00 |
| South Sudan                      | December-2020  |                2 |          101635 |             0.00 |
| South Sudan                      | January-2021   |                1 |          115032 |             0.00 |
| South Sudan                      | February-2021  |               29 |          158760 |             0.02 |
| South Sudan                      | March-2021     |               16 |          291531 |             0.01 |
| South Sudan                      | April-2021     |                6 |          312418 |             0.00 |
| Spain                            | February-2020  |                0 |             151 |             0.00 |
| Spain                            | March-2020     |             8464 |          742546 |             1.14 |
| Spain                            | April-2020     |            16079 |         5236777 |             0.31 |
| Spain                            | May-2020       |             2584 |         7102653 |             0.04 |
| Spain                            | June-2020      |             1228 |         7331192 |             0.02 |
| Spain                            | July-2020      |               90 |         8134290 |             0.00 |
| Spain                            | August-2020    |              649 |        11159043 |             0.01 |
| Spain                            | September-2020 |             2697 |        18316260 |             0.01 |
| Spain                            | October-2020   |             4087 |        29494693 |             0.01 |
| Spain                            | November-2020  |             9191 |        43932783 |             0.02 |
| Spain                            | December-2020  |             5768 |        55067758 |             0.01 |
| Spain                            | January-2021   |             7482 |        71180786 |             0.01 |
| Spain                            | February-2021  |            10823 |        85568038 |             0.01 |
| Spain                            | March-2021     |             6317 |        99280629 |             0.01 |
| Spain                            | April-2021     |             2757 |       101966198 |             0.00 |
| Sri Lanka                        | January-2020   |                0 |               5 |             0.00 |
| Sri Lanka                        | February-2020  |                0 |              29 |             0.00 |
| Sri Lanka                        | March-2020     |                2 |            1471 |             0.14 |
| Sri Lanka                        | April-2020     |                5 |            9067 |             0.06 |
| Sri Lanka                        | May-2020       |                3 |           31986 |             0.01 |
| Sri Lanka                        | June-2020      |                1 |           57101 |             0.00 |
| Sri Lanka                        | July-2020      |                0 |           78455 |             0.00 |
| Sri Lanka                        | August-2020    |                1 |           90093 |             0.00 |
| Sri Lanka                        | September-2020 |                1 |           97197 |             0.00 |
| Sri Lanka                        | October-2020   |                7 |          184458 |             0.00 |
| Sri Lanka                        | November-2020  |               98 |          519494 |             0.02 |
| Sri Lanka                        | December-2020  |               86 |         1064723 |             0.01 |
| Sri Lanka                        | January-2021   |              112 |         1640683 |             0.01 |
| Sri Lanka                        | February-2021  |              148 |         2102971 |             0.01 |
| Sri Lanka                        | March-2021     |              104 |         2741305 |             0.00 |
| Sri Lanka                        | April-2021     |              110 |         2923063 |             0.00 |
| Sudan                            | March-2020     |                2 |              48 |             4.17 |
| Sudan                            | April-2020     |               29 |            2897 |             1.00 |
| Sudan                            | May-2020       |              255 |           71755 |             0.36 |
| Sudan                            | June-2020      |              286 |          221561 |             0.13 |
| Sudan                            | July-2020      |              174 |          327938 |             0.05 |
| Sudan                            | August-2020    |               77 |          385040 |             0.02 |
| Sudan                            | September-2020 |               13 |          404872 |             0.00 |
| Sudan                            | October-2020   |                1 |          424972 |             0.00 |
| Sudan                            | November-2020  |              412 |          459778 |             0.09 |
| Sudan                            | December-2020  |              219 |          686746 |             0.03 |
| Sudan                            | January-2021   |              339 |          860954 |             0.04 |
| Sudan                            | February-2021  |               73 |          838465 |             0.01 |
| Sudan                            | March-2021     |              183 |          959112 |             0.02 |
| Sudan                            | April-2021     |              286 |          982035 |             0.03 |
| Suriname                         | March-2020     |                0 |              88 |             0.00 |
| Suriname                         | April-2020     |                1 |             300 |             0.33 |
| Suriname                         | May-2020       |                0 |             342 |             0.00 |
| Suriname                         | June-2020      |               12 |            7377 |             0.16 |
| Suriname                         | July-2020      |               13 |           30514 |             0.04 |
| Suriname                         | August-2020    |               45 |           92088 |             0.05 |
| Suriname                         | September-2020 |               33 |          137565 |             0.02 |
| Suriname                         | October-2020   |                7 |          157566 |             0.00 |
| Suriname                         | November-2020  |                6 |          158057 |             0.00 |
| Suriname                         | December-2020  |                5 |          172469 |             0.00 |
| Suriname                         | January-2021   |               32 |          230537 |             0.01 |
| Suriname                         | February-2021  |               18 |          245498 |             0.01 |
| Suriname                         | March-2021     |                5 |          279961 |             0.00 |
| Suriname                         | April-2021     |               27 |          287403 |             0.01 |
| Sweden                           | February-2020  |                0 |              55 |             0.00 |
| Sweden                           | March-2020     |              385 |           47284 |             0.81 |
| Sweden                           | April-2020     |             2201 |          391340 |             0.56 |
| Sweden                           | May-2020       |             1809 |          938735 |             0.19 |
| Sweden                           | June-2020      |              938 |         1611074 |             0.06 |
| Sweden                           | July-2020      |              410 |         2280371 |             0.02 |
| Sweden                           | August-2020    |               78 |         2519171 |             0.00 |
| Sweden                           | September-2020 |               72 |         2632351 |             0.00 |
| Sweden                           | October-2020   |               45 |         3240753 |             0.00 |
| Sweden                           | November-2020  |              743 |         5546377 |             0.01 |
| Sweden                           | December-2020  |             2046 |        10695430 |             0.02 |
| Sweden                           | January-2021   |             2864 |        15946013 |             0.02 |
| Sweden                           | February-2021  |             1235 |        17201658 |             0.01 |
| Sweden                           | March-2021     |              639 |        22569251 |             0.00 |
| Sweden                           | April-2021     |              583 |        26658585 |             0.00 |
| Switzerland                      | February-2020  |                0 |              36 |             0.00 |
| Switzerland                      | March-2020     |              433 |          155101 |             0.28 |
| Switzerland                      | April-2020     |             1304 |          767858 |             0.17 |
| Switzerland                      | May-2020       |              183 |          943988 |             0.02 |
| Switzerland                      | June-2020      |               43 |          935609 |             0.00 |
| Switzerland                      | July-2020      |               18 |         1033677 |             0.00 |
| Switzerland                      | August-2020    |               25 |         1188157 |             0.00 |
| Switzerland                      | September-2020 |               68 |         1438863 |             0.00 |
| Switzerland                      | October-2020   |              223 |         2627252 |             0.01 |
| Switzerland                      | November-2020  |             2518 |         7765995 |             0.03 |
| Switzerland                      | December-2020  |             2830 |        12135482 |             0.02 |
| Switzerland                      | January-2021   |             1736 |        15277220 |             0.01 |
| Switzerland                      | February-2021  |              585 |        15173740 |             0.00 |
| Switzerland                      | March-2021     |              371 |        17873268 |             0.00 |
| Switzerland                      | April-2021     |              295 |        18901590 |             0.00 |
| Syria                            | March-2020     |                2 |              52 |             3.85 |
| Syria                            | April-2020     |                1 |             921 |             0.11 |
| Syria                            | May-2020       |                2 |            2083 |             0.10 |
| Syria                            | June-2020      |                4 |            5546 |             0.07 |
| Syria                            | July-2020      |               34 |           15250 |             0.22 |
| Syria                            | August-2020    |               69 |           53007 |             0.13 |
| Syria                            | September-2020 |               88 |          107816 |             0.08 |
| Syria                            | October-2020   |               88 |          154191 |             0.06 |
| Syria                            | November-2020  |              129 |          203042 |             0.06 |
| Syria                            | December-2020  |              294 |          299051 |             0.10 |
| Syria                            | January-2021   |              210 |          399586 |             0.05 |
| Syria                            | February-2021  |              106 |          416099 |             0.03 |
| Syria                            | March-2021     |              238 |          525778 |             0.05 |
| Syria                            | April-2021     |              327 |          625640 |             0.05 |
| Taiwan                           | January-2020   |                0 |              52 |             0.00 |
| Taiwan                           | February-2020  |                1 |             616 |             0.16 |
| Taiwan                           | March-2020     |                4 |            3877 |             0.10 |
| Taiwan                           | April-2020     |                1 |           11888 |             0.01 |
| Taiwan                           | May-2020       |                1 |           13625 |             0.01 |
| Taiwan                           | June-2020      |                0 |           13341 |             0.00 |
| Taiwan                           | July-2020      |                0 |           14062 |             0.00 |
| Taiwan                           | August-2020    |                0 |           14954 |             0.00 |
| Taiwan                           | September-2020 |                0 |           15038 |             0.00 |
| Taiwan                           | October-2020   |                0 |           16593 |             0.00 |
| Taiwan                           | November-2020  |                0 |           18038 |             0.00 |
| Taiwan                           | December-2020  |                0 |           23118 |             0.00 |
| Taiwan                           | January-2021   |                1 |           26502 |             0.00 |
| Taiwan                           | February-2021  |                1 |           26198 |             0.00 |
| Taiwan                           | March-2021     |                1 |           30735 |             0.00 |
| Taiwan                           | April-2021     |                2 |           32190 |             0.01 |
| Tajikistan                       | April-2020     |                0 |              15 |             0.00 |
| Tajikistan                       | May-2020       |               47 |           51539 |             0.09 |
| Tajikistan                       | June-2020      |                5 |          152296 |             0.00 |
| Tajikistan                       | July-2020      |                8 |          208547 |             0.00 |
| Tajikistan                       | August-2020    |                8 |          249268 |             0.00 |
| Tajikistan                       | September-2020 |                8 |          275116 |             0.00 |
| Tajikistan                       | October-2020   |                6 |          322893 |             0.00 |
| Tajikistan                       | November-2020  |                4 |          348944 |             0.00 |
| Tajikistan                       | December-2020  |                4 |          396783 |             0.00 |
| Tajikistan                       | January-2021   |                0 |          412497 |             0.00 |
| Tajikistan                       | February-2021  |                0 |          372624 |             0.00 |
| Tajikistan                       | March-2021     |                0 |          412548 |             0.00 |
| Tajikistan                       | April-2021     |                0 |          399240 |             0.00 |
| Tanzania                         | March-2020     |                1 |             163 |             0.61 |
| Tanzania                         | April-2020     |               15 |            4575 |             0.33 |
| Tanzania                         | May-2020       |                5 |           15576 |             0.03 |
| Tanzania                         | June-2020      |                0 |           15270 |             0.00 |
| Tanzania                         | July-2020      |                0 |           15779 |             0.00 |
| Tanzania                         | August-2020    |                0 |           15779 |             0.00 |
| Tanzania                         | September-2020 |                0 |           15270 |             0.00 |
| Tanzania                         | October-2020   |                0 |           15779 |             0.00 |
| Tanzania                         | November-2020  |                0 |           15270 |             0.00 |
| Tanzania                         | December-2020  |                0 |           15779 |             0.00 |
| Tanzania                         | January-2021   |                0 |           15779 |             0.00 |
| Tanzania                         | February-2021  |                0 |           14252 |             0.00 |
| Tanzania                         | March-2021     |                0 |           15779 |             0.00 |
| Tanzania                         | April-2021     |                0 |           15270 |             0.00 |
| Thailand                         | January-2020   |                0 |              96 |             0.00 |
| Thailand                         | February-2020  |                0 |             933 |             0.00 |
| Thailand                         | March-2020     |               10 |           13480 |             0.07 |
| Thailand                         | April-2020     |               44 |           77098 |             0.06 |
| Thailand                         | May-2020       |                3 |           93701 |             0.00 |
| Thailand                         | June-2020      |                1 |           93991 |             0.00 |
| Thailand                         | July-2020      |                0 |          100363 |             0.00 |
| Thailand                         | August-2020    |                0 |          104473 |             0.00 |
| Thailand                         | September-2020 |                1 |          104554 |             0.00 |
| Thailand                         | October-2020   |                0 |          114072 |             0.00 |
| Thailand                         | November-2020  |                1 |          116509 |             0.00 |
| Thailand                         | December-2020  |                3 |          154099 |             0.00 |
| Thailand                         | January-2021   |               14 |          380681 |             0.00 |
| Thailand                         | February-2021  |                6 |          680096 |             0.00 |
| Thailand                         | March-2021     |               11 |          847502 |             0.00 |
| Thailand                         | April-2021     |              109 |         1243742 |             0.01 |
| Timor                            | March-2020     |                0 |              10 |             0.00 |
| Timor                            | April-2020     |                0 |             365 |             0.00 |
| Timor                            | May-2020       |                0 |             744 |             0.00 |
| Timor                            | June-2020      |                0 |             720 |             0.00 |
| Timor                            | July-2020      |                0 |             744 |             0.00 |
| Timor                            | August-2020    |                0 |             787 |             0.00 |
| Timor                            | September-2020 |                0 |             812 |             0.00 |
| Timor                            | October-2020   |                0 |             894 |             0.00 |
| Timor                            | November-2020  |                0 |             900 |             0.00 |
| Timor                            | December-2020  |                0 |            1054 |             0.00 |
| Timor                            | January-2021   |                0 |            1705 |             0.00 |
| Timor                            | February-2021  |                0 |            2678 |             0.00 |
| Timor                            | March-2021     |                0 |            8190 |             0.00 |
| Timor                            | April-2021     |                3 |           38592 |             0.01 |
| Togo                             | March-2020     |                1 |             278 |             0.36 |
| Togo                             | April-2020     |                8 |            2313 |             0.35 |
| Togo                             | May-2020       |                4 |            8434 |             0.05 |
| Togo                             | June-2020      |                1 |           16202 |             0.01 |
| Togo                             | July-2020      |                5 |           23804 |             0.02 |
| Togo                             | August-2020    |                9 |           36091 |             0.02 |
| Togo                             | September-2020 |               20 |           48078 |             0.04 |
| Togo                             | October-2020   |                9 |           63293 |             0.01 |
| Togo                             | November-2020  |                7 |           80374 |             0.01 |
| Togo                             | December-2020  |                4 |          102862 |             0.00 |
| Togo                             | January-2021   |                9 |          132772 |             0.01 |
| Togo                             | February-2021  |                7 |          166043 |             0.00 |
| Togo                             | March-2021     |               25 |          262504 |             0.01 |
| Togo                             | April-2021     |               14 |          364486 |             0.00 |
| Tonga                            | April-2021     |                0 |               0 |             NULL |
| Trinidad and Tobago              | March-2020     |                3 |             757 |             0.40 |
| Trinidad and Tobago              | April-2020     |                5 |            3315 |             0.15 |
| Trinidad and Tobago              | May-2020       |                0 |            3598 |             0.00 |
| Trinidad and Tobago              | June-2020      |                0 |            3629 |             0.00 |
| Trinidad and Tobago              | July-2020      |                0 |            4310 |             0.00 |
| Trinidad and Tobago              | August-2020    |               14 |           22008 |             0.06 |
| Trinidad and Tobago              | September-2020 |               54 |           98238 |             0.05 |
| Trinidad and Tobago              | October-2020   |               32 |          161320 |             0.02 |
| Trinidad and Tobago              | November-2020  |               12 |          184145 |             0.01 |
| Trinidad and Tobago              | December-2020  |                7 |          214764 |             0.00 |
| Trinidad and Tobago              | January-2021   |                7 |          228015 |             0.00 |
| Trinidad and Tobago              | February-2021  |                5 |          214119 |             0.00 |
| Trinidad and Tobago              | March-2021     |                3 |          242510 |             0.00 |
| Trinidad and Tobago              | April-2021     |               27 |          267657 |             0.01 |
| Tunisia                          | March-2020     |               10 |            2476 |             0.40 |
| Tunisia                          | April-2020     |               31 |           23056 |             0.13 |
| Tunisia                          | May-2020       |                7 |           32212 |             0.02 |
| Tunisia                          | June-2020      |                2 |           33677 |             0.01 |
| Tunisia                          | July-2020      |                0 |           41174 |             0.00 |
| Tunisia                          | August-2020    |               27 |           72295 |             0.04 |
| Tunisia                          | September-2020 |              188 |          273502 |             0.07 |
| Tunisia                          | October-2020   |             1052 |         1173458 |             0.09 |
| Tunisia                          | November-2020  |             1943 |         2394119 |             0.08 |
| Tunisia                          | December-2020  |             1416 |         3603614 |             0.04 |
| Tunisia                          | January-2021   |             2078 |         5450840 |             0.04 |
| Tunisia                          | February-2021  |             1247 |         6240176 |             0.02 |
| Tunisia                          | March-2021     |              811 |         7531509 |             0.01 |
| Tunisia                          | April-2021     |             1910 |         8436921 |             0.02 |
| Turkey                           | March-2020     |              214 |           58776 |             0.36 |
| Turkey                           | April-2020     |             2960 |         2098207 |             0.14 |
| Turkey                           | May-2020       |             1366 |         4521709 |             0.03 |
| Turkey                           | June-2020      |              591 |         5429570 |             0.01 |
| Turkey                           | July-2020      |              560 |         6712753 |             0.01 |
| Turkey                           | August-2020    |              679 |         7744882 |             0.01 |
| Turkey                           | September-2020 |             1825 |         8864996 |             0.02 |
| Turkey                           | October-2020   |             2057 |        10707361 |             0.02 |
| Turkey                           | November-2020  |             3494 |        13199045 |             0.03 |
| Turkey                           | December-2020  |             7135 |        51443548 |             0.01 |
| Turkey                           | January-2021   |             5112 |        73376598 |             0.01 |
| Turkey                           | February-2021  |             2576 |        72545924 |             0.00 |
| Turkey                           | March-2021     |             2968 |        91423494 |             0.00 |
| Turkey                           | April-2021     |             8594 |       123292520 |             0.01 |
| Turks and Caicos Islands         | January-2021   |                0 |               0 |             NULL |
| Turks and Caicos Islands         | February-2021  |                0 |               0 |             NULL |
| Turks and Caicos Islands         | March-2021     |                0 |               0 |             NULL |
| Turks and Caicos Islands         | April-2021     |                0 |               0 |             NULL |
| Uganda                           | March-2020     |                0 |             211 |             0.00 |
| Uganda                           | April-2020     |                0 |            1797 |             0.00 |
| Uganda                           | May-2020       |                0 |            5937 |             0.00 |
| Uganda                           | June-2020      |                0 |           21150 |             0.00 |
| Uganda                           | July-2020      |                3 |           32169 |             0.01 |
| Uganda                           | August-2020    |               29 |           54950 |             0.05 |
| Uganda                           | September-2020 |               43 |          161746 |             0.03 |
| Uganda                           | October-2020   |               36 |          320818 |             0.01 |
| Uganda                           | November-2020  |               94 |          489403 |             0.02 |
| Uganda                           | December-2020  |               46 |          882278 |             0.01 |
| Uganda                           | January-2021   |               73 |         1179121 |             0.01 |
| Uganda                           | February-2021  |               10 |         1120741 |             0.00 |
| Uganda                           | March-2021     |                1 |         1258743 |             0.00 |
| Uganda                           | April-2021     |                7 |         1239637 |             0.00 |
| Ukraine                          | March-2020     |               17 |            3064 |             0.55 |
| Ukraine                          | April-2020     |              244 |          137421 |             0.18 |
| Ukraine                          | May-2020       |              447 |          543592 |             0.08 |
| Ukraine                          | June-2020      |              465 |         1011298 |             0.05 |
| Ukraine                          | July-2020      |              544 |         1797522 |             0.03 |
| Ukraine                          | August-2020    |              888 |         2952987 |             0.03 |
| Ukraine                          | September-2020 |             1616 |         5019534 |             0.03 |
| Ukraine                          | October-2020   |             3178 |         9292272 |             0.03 |
| Ukraine                          | November-2020  |             5332 |        16972054 |             0.03 |
| Ukraine                          | December-2020  |             6550 |        29178756 |             0.02 |
| Ukraine                          | January-2021   |             4579 |        36713095 |             0.01 |
| Ukraine                          | February-2021  |             3544 |        37009908 |             0.01 |
| Ukraine                          | March-2021     |             7052 |        47885644 |             0.01 |
| Ukraine                          | April-2021     |            11467 |        58596168 |             0.02 |
| United Arab Emirates             | January-2020   |                0 |              12 |             0.00 |
| United Arab Emirates             | February-2020  |                0 |             268 |             0.00 |
| United Arab Emirates             | March-2020     |                6 |            5515 |             0.11 |
| United Arab Emirates             | April-2020     |               99 |          175824 |             0.06 |
| United Arab Emirates             | May-2020       |              159 |          718686 |             0.02 |
| United Arab Emirates             | June-2020      |               51 |         1274693 |             0.00 |
| United Arab Emirates             | July-2020      |               36 |         1724036 |             0.00 |
| United Arab Emirates             | August-2020    |               33 |         2009206 |             0.00 |
| United Arab Emirates             | September-2020 |               35 |         2450597 |             0.00 |
| United Arab Emirates             | October-2020   |               76 |         3511783 |             0.00 |
| United Arab Emirates             | November-2020  |               77 |         4535051 |             0.00 |
| United Arab Emirates             | December-2020  |               97 |         5847851 |             0.00 |
| United Arab Emirates             | January-2021   |              181 |         7811891 |             0.00 |
| United Arab Emirates             | February-2021  |              371 |         9796313 |             0.00 |
| United Arab Emirates             | March-2021     |              276 |        13316657 |             0.00 |
| United Arab Emirates             | April-2021     |               90 |        14769790 |             0.00 |
| United Kingdom                   | January-2020   |                0 |               2 |             0.00 |
| United Kingdom                   | February-2020  |                0 |             606 |             0.00 |
| United Kingdom                   | March-2020     |             2457 |          283199 |             0.87 |
| United Kingdom                   | April-2020     |            24297 |         3328344 |             0.73 |
| United Kingdom                   | May-2020       |            10773 |         7016710 |             0.15 |
| United Kingdom                   | June-2020      |             2952 |         8213357 |             0.04 |
| United Kingdom                   | July-2020      |              795 |         9120400 |             0.01 |
| United Kingdom                   | August-2020    |              315 |         9933759 |             0.00 |
| United Kingdom                   | September-2020 |              644 |        11564506 |             0.01 |
| United Kingdom                   | October-2020   |             4412 |        22002570 |             0.02 |
| United Kingdom                   | November-2020  |            11900 |        40830975 |             0.03 |
| United Kingdom                   | December-2020  |            15077 |        61365366 |             0.02 |
| United Kingdom                   | January-2021   |            32745 |       102180395 |             0.03 |
| United Kingdom                   | February-2021  |            16716 |       113211684 |             0.01 |
| United Kingdom                   | March-2021     |             3872 |       132721966 |             0.00 |
| United Kingdom                   | April-2021     |              820 |       131952179 |             0.00 |
| United States                    | January-2020   |                0 |              41 |             0.00 |
| United States                    | February-2020  |                1 |             402 |             0.25 |
| United States                    | March-2020     |             5368 |         1120122 |             0.48 |
| United States                    | April-2020     |            60862 |        19959287 |             0.30 |
| United States                    | May-2020       |            41602 |        45533906 |             0.09 |
| United States                    | June-2020      |            19767 |        64964762 |             0.03 |
| United States                    | July-2020      |            26547 |       111371152 |             0.02 |
| United States                    | August-2020    |            29655 |       166357378 |             0.02 |
| United States                    | September-2020 |            23399 |       199220181 |             0.01 |
| United States                    | October-2020   |            24532 |       251406215 |             0.01 |
| United States                    | November-2020  |            39263 |       339796331 |             0.01 |
| United States                    | December-2020  |            81097 |       528139775 |             0.02 |
| United States                    | January-2021   |            97248 |       730894746 |             0.01 |
| United States                    | February-2021  |            65623 |       774254261 |             0.01 |
| United States                    | March-2021     |            37531 |       916643837 |             0.00 |
| United States                    | April-2021     |            23737 |       944543693 |             0.00 |
| Uruguay                          | March-2020     |                1 |            3023 |             0.03 |
| Uruguay                          | April-2020     |               16 |           15144 |             0.11 |
| Uruguay                          | May-2020       |                5 |           22718 |             0.02 |
| Uruguay                          | June-2020      |                5 |           25962 |             0.02 |
| Uruguay                          | July-2020      |                8 |           32857 |             0.02 |
| Uruguay                          | August-2020    |                9 |           44615 |             0.02 |
| Uruguay                          | September-2020 |                4 |           55050 |             0.01 |
| Uruguay                          | October-2020   |               10 |           77922 |             0.01 |
| Uruguay                          | November-2020  |               19 |          125784 |             0.02 |
| Uruguay                          | December-2020  |              104 |          358979 |             0.03 |
| Uruguay                          | January-2021   |              255 |          960688 |             0.03 |
| Uruguay                          | February-2021  |              172 |         1383421 |             0.01 |
| Uruguay                          | March-2021     |              366 |         2381456 |             0.02 |
| Uruguay                          | April-2021     |             1642 |         4664168 |             0.04 |
| Uzbekistan                       | March-2020     |                2 |            1062 |             0.19 |
| Uzbekistan                       | April-2020     |                7 |           35053 |             0.02 |
| Uzbekistan                       | May-2020       |                6 |           85596 |             0.01 |
| Uzbekistan                       | June-2020      |               11 |          168606 |             0.01 |
| Uzbekistan                       | July-2020      |              115 |          479255 |             0.02 |
| Uzbekistan                       | August-2020    |              179 |         1068133 |             0.02 |
| Uzbekistan                       | September-2020 |              150 |         1468909 |             0.01 |
| Uzbekistan                       | October-2020   |               96 |         1935712 |             0.00 |
| Uzbekistan                       | November-2020  |               44 |         2106636 |             0.00 |
| Uzbekistan                       | December-2020  |                4 |         2334877 |             0.00 |
| Uzbekistan                       | January-2021   |                7 |         2415594 |             0.00 |
| Uzbekistan                       | February-2021  |                1 |         2222824 |             0.00 |
| Uzbekistan                       | March-2021     |                7 |         2511079 |             0.00 |
| Uzbekistan                       | April-2021     |               20 |         2590272 |             0.00 |
| Vanuatu                          | November-2020  |                0 |              21 |             0.00 |
| Vanuatu                          | December-2020  |                0 |              31 |             0.00 |
| Vanuatu                          | January-2021   |                0 |              31 |             0.00 |
| Vanuatu                          | February-2021  |                0 |              28 |             0.00 |
| Vanuatu                          | March-2021     |                0 |              79 |             0.00 |
| Vanuatu                          | April-2021     |                1 |             100 |             1.00 |
| Vatican                          | March-2020     |                0 |              58 |             0.00 |
| Vatican                          | April-2020     |                0 |             247 |             0.00 |
| Vatican                          | May-2020       |                0 |             367 |             0.00 |
| Vatican                          | June-2020      |                0 |             360 |             0.00 |
| Vatican                          | July-2020      |                0 |             372 |             0.00 |
| Vatican                          | August-2020    |                0 |             372 |             0.00 |
| Vatican                          | September-2020 |                0 |             360 |             0.00 |
| Vatican                          | October-2020   |                0 |             646 |             0.00 |
| Vatican                          | November-2020  |                0 |             810 |             0.00 |
| Vatican                          | December-2020  |                0 |             837 |             0.00 |
| Vatican                          | January-2021   |                0 |             837 |             0.00 |
| Vatican                          | February-2021  |                0 |             756 |             0.00 |
| Vatican                          | March-2021     |                0 |             837 |             0.00 |
| Vatican                          | April-2021     |                0 |             810 |             0.00 |
| Venezuela                        | March-2020     |                3 |            1296 |             0.23 |
| Venezuela                        | April-2020     |               13 |            6845 |             0.19 |
| Venezuela                        | May-2020       |               -2 |           22391 |            -0.01 |
| Venezuela                        | June-2020      |               37 |          101886 |             0.04 |
| Venezuela                        | July-2020      |              113 |          349975 |             0.03 |
| Venezuela                        | August-2020    |              222 |         1023744 |             0.02 |
| Venezuela                        | September-2020 |              242 |         1870624 |             0.01 |
| Venezuela                        | October-2020   |              170 |         2638216 |             0.01 |
| Venezuela                        | November-2020  |               99 |         2924109 |             0.00 |
| Venezuela                        | December-2020  |              131 |         3361140 |             0.00 |
| Venezuela                        | January-2021   |              161 |         3711664 |             0.00 |
| Venezuela                        | February-2021  |              155 |         3732780 |             0.00 |
| Venezuela                        | March-2021     |              258 |         4592207 |             0.01 |
| Venezuela                        | April-2021     |              534 |         5402012 |             0.01 |
| Vietnam                          | January-2020   |                0 |              18 |             0.00 |
| Vietnam                          | February-2020  |                0 |             398 |             0.00 |
| Vietnam                          | March-2020     |                0 |            2514 |             0.00 |
| Vietnam                          | April-2020     |                0 |            7778 |             0.00 |
| Vietnam                          | May-2020       |                0 |            9465 |             0.00 |
| Vietnam                          | June-2020      |                0 |           10196 |             0.00 |
| Vietnam                          | July-2020      |                3 |           12278 |             0.02 |
| Vietnam                          | August-2020    |               31 |           28091 |             0.11 |
| Vietnam                          | September-2020 |                1 |           31897 |             0.00 |
| Vietnam                          | October-2020   |                0 |           35048 |             0.00 |
| Vietnam                          | November-2020  |                0 |           38113 |             0.00 |
| Vietnam                          | December-2020  |                0 |           43541 |             0.00 |
| Vietnam                          | January-2021   |                0 |           48059 |             0.00 |
| Vietnam                          | February-2021  |                0 |           61812 |             0.00 |
| Vietnam                          | March-2021     |                0 |           78997 |             0.00 |
| Vietnam                          | April-2021     |                0 |           82567 |             0.00 |
| Yemen                            | April-2020     |                2 |              31 |             6.45 |
| Yemen                            | May-2020       |               78 |            4101 |             1.90 |
| Yemen                            | June-2020      |              232 |           23264 |             1.00 |
| Yemen                            | July-2020      |              181 |           46644 |             0.39 |
| Yemen                            | August-2020    |               73 |           57598 |             0.13 |
| Yemen                            | September-2020 |               21 |           60327 |             0.03 |
| Yemen                            | October-2020   |               12 |           63654 |             0.02 |
| Yemen                            | November-2020  |                6 |           62038 |             0.01 |
| Yemen                            | December-2020  |                5 |           64649 |             0.01 |
| Yemen                            | January-2021   |                5 |           65439 |             0.01 |
| Yemen                            | February-2021  |               19 |           60549 |             0.03 |
| Yemen                            | March-2021     |              254 |           96700 |             0.26 |
| Yemen                            | April-2021     |              338 |          167368 |             0.20 |
| Zambia                           | March-2020     |                0 |             194 |             0.00 |
| Zambia                           | April-2020     |                3 |            1754 |             0.17 |
| Zambia                           | May-2020       |                4 |           18622 |             0.02 |
| Zambia                           | June-2020      |               17 |           40038 |             0.04 |
| Zambia                           | July-2020      |              127 |           90582 |             0.14 |
| Zambia                           | August-2020    |              137 |          290970 |             0.05 |
| Zambia                           | September-2020 |               44 |          410862 |             0.01 |
| Zambia                           | October-2020   |               17 |          486509 |             0.00 |
| Zambia                           | November-2020  |                8 |          514878 |             0.00 |
| Zambia                           | December-2020  |               31 |          579474 |             0.01 |
| Zambia                           | January-2021   |              375 |         1112407 |             0.03 |
| Zambia                           | February-2021  |              328 |         1923634 |             0.02 |
| Zambia                           | March-2021     |              117 |         2627072 |             0.00 |
| Zambia                           | April-2021     |               43 |         2711129 |             0.00 |
| Zimbabwe                         | March-2020     |                1 |              53 |             1.89 |
| Zimbabwe                         | April-2020     |                3 |             618 |             0.49 |
| Zimbabwe                         | May-2020       |                0 |            1871 |             0.00 |
| Zimbabwe                         | June-2020      |                3 |           12096 |             0.02 |
| Zimbabwe                         | July-2020      |               60 |           48113 |             0.12 |
| Zimbabwe                         | August-2020    |              135 |          163293 |             0.08 |
| Zimbabwe                         | September-2020 |               26 |          223571 |             0.01 |
| Zimbabwe                         | October-2020   |               15 |          251343 |             0.01 |
| Zimbabwe                         | November-2020  |               33 |          268984 |             0.01 |
| Zimbabwe                         | December-2020  |               87 |          366341 |             0.02 |
| Zimbabwe                         | January-2021   |              854 |          787416 |             0.11 |
| Zimbabwe                         | February-2021  |              246 |          984049 |             0.02 |
| Zimbabwe                         | March-2021     |               60 |         1132264 |             0.01 |
| Zimbabwe                         | April-2021     |               44 |         1126565 |             0.00 |




**Query : Percentage of people diagnosed in a month, out of total population** 


````sql
select *,round((sum_total_cases/population)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year, 
sum(total_cases) as sum_total_cases , max(population) as population
from covid_death
group by Month_year, Location
) e ;
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
| Andorra                          | September-2020 |           45275 |      77265 |             58.6 |
| Andorra                          | October-2020   |          103067 |      77265 |           133.39 |
| Andorra                          | November-2020  |          174907 |      77265 |           226.37 |
| Andorra                          | December-2020  |          230115 |      77265 |           297.83 |
| Andorra                          | January-2021   |          279226 |      77265 |           361.39 |
| Andorra                          | February-2021  |          293412 |      77265 |           379.75 |
| Andorra                          | March-2021     |          352375 |      77265 |           456.06 |
| Andorra                          | April-2021     |          380633 |      77265 |           492.63 |
| Angola                           | March-2020     |              48 |   32866268 |                0 |
| Angola                           | April-2020     |             601 |   32866268 |                0 |
| Angola                           | May-2020       |            1639 |   32866268 |                0 |
| Angola                           | June-2020      |            4660 |   32866268 |             0.01 |
| Angola                           | July-2020      |           20049 |   32866268 |             0.06 |
| Angola                           | August-2020    |           59160 |   32866268 |             0.18 |
| Angola                           | September-2020 |          111469 |   32866268 |             0.34 |
| Angola                           | October-2020   |          233349 |   32866268 |             0.71 |
| Angola                           | November-2020  |          404417 |   32866268 |             1.23 |
| Angola                           | December-2020  |          508018 |   32866268 |             1.55 |
| Angola                           | January-2021   |          580289 |   32866268 |             1.77 |
| Angola                           | February-2021  |          569508 |   32866268 |             1.73 |
| Angola                           | March-2021     |          666295 |   32866268 |             2.03 |
| Angola                           | April-2021     |          726071 |   32866268 |             2.21 |
| Anguilla                         | February-2021  |               0 |      15002 |                0 |
| Anguilla                         | March-2021     |               0 |      15002 |                0 |
| Anguilla                         | April-2021     |               0 |      15002 |                0 |
| Antigua and Barbuda              | March-2020     |              61 |      97928 |             0.06 |
| Antigua and Barbuda              | April-2020     |             617 |      97928 |             0.63 |
| Antigua and Barbuda              | May-2020       |             776 |      97928 |             0.79 |
| Antigua and Barbuda              | June-2020      |            1026 |      97928 |             1.05 |
| Antigua and Barbuda              | July-2020      |            2366 |      97928 |             2.42 |
| Antigua and Barbuda              | August-2020    |            2881 |      97928 |             2.94 |
| Antigua and Barbuda              | September-2020 |            2886 |      97928 |             2.95 |
| Antigua and Barbuda              | October-2020   |            3586 |      97928 |             3.66 |
| Antigua and Barbuda              | November-2020  |            4047 |      97928 |             4.13 |
| Antigua and Barbuda              | December-2020  |            4656 |      97928 |             4.75 |
| Antigua and Barbuda              | January-2021   |            5759 |      97928 |             5.88 |
| Antigua and Barbuda              | February-2021  |           12957 |      97928 |            13.23 |
| Antigua and Barbuda              | March-2021     |           30085 |      97928 |            30.72 |
| Antigua and Barbuda              | April-2021     |           36073 |      97928 |            36.84 |
| Argentina                        | January-2020   |               0 |   45195777 |                0 |
| Argentina                        | February-2020  |               0 |   45195777 |                0 |
| Argentina                        | March-2020     |            6529 |   45195777 |             0.01 |
| Argentina                        | April-2020     |           77576 |   45195777 |             0.17 |
| Argentina                        | May-2020       |          275556 |   45195777 |             0.61 |
| Argentina                        | June-2020      |         1091252 |   45195777 |             2.41 |
| Argentina                        | July-2020      |         3728771 |   45195777 |             8.25 |
| Argentina                        | August-2020    |         9244163 |   45195777 |            20.45 |
| Argentina                        | September-2020 |        17545982 |   45195777 |            38.82 |
| Argentina                        | October-2020   |        29922509 |   45195777 |            66.21 |
| Argentina                        | November-2020  |        39307295 |   45195777 |            86.97 |
| Argentina                        | December-2020  |        47136788 |   45195777 |           104.29 |
| Argentina                        | January-2021   |        55312462 |   45195777 |           122.38 |
| Argentina                        | February-2021  |        56733848 |   45195777 |           125.53 |
| Argentina                        | March-2021     |        68713761 |   45195777 |           152.04 |
| Argentina                        | April-2021     |        79416752 |   45195777 |           175.72 |
| Armenia                          | March-2020     |            4099 |    2963234 |             0.14 |
| Armenia                          | April-2020     |           36511 |    2963234 |             1.23 |
| Armenia                          | May-2020       |          151445 |    2963234 |             5.11 |
| Armenia                          | June-2020      |          520967 |    2963234 |            17.58 |
| Armenia                          | July-2020      |         1026463 |    2963234 |            34.64 |
| Armenia                          | August-2020    |         1286089 |    2963234 |             43.4 |
| Armenia                          | September-2020 |         1398359 |    2963234 |            47.19 |
| Armenia                          | October-2020   |         2012415 |    2963234 |            67.91 |
| Armenia                          | November-2020  |         3480514 |    2963234 |           117.46 |
| Armenia                          | December-2020  |         4636215 |    2963234 |           156.46 |
| Armenia                          | January-2021   |         5076072 |    2963234 |            171.3 |
| Armenia                          | February-2021  |         4741148 |    2963234 |              160 |
| Armenia                          | March-2021     |         5603135 |    2963234 |           189.09 |
| Armenia                          | April-2021     |         6176164 |    2963234 |           208.43 |
| Aruba                            | March-2021     |               0 |     106766 |                0 |
| Aruba                            | April-2021     |               0 |     106766 |                0 |
| Australia                        | January-2020   |              38 |   25499881 |                0 |
| Australia                        | February-2020  |             431 |   25499881 |                0 |
| Australia                        | March-2020     |           35679 |   25499881 |             0.14 |
| Australia                        | April-2020     |          188206 |   25499881 |             0.74 |
| Australia                        | May-2020       |          217625 |   25499881 |             0.85 |
| Australia                        | June-2020      |          222611 |   25499881 |             0.87 |
| Australia                        | July-2020      |          361720 |   25499881 |             1.42 |
| Australia                        | August-2020    |          711091 |   25499881 |             2.79 |
| Australia                        | September-2020 |          800899 |   25499881 |             3.14 |
| Australia                        | October-2020   |          848364 |   25499881 |             3.33 |
| Australia                        | November-2020  |          832514 |   25499881 |             3.26 |
| Australia                        | December-2020  |          872046 |   25499881 |             3.42 |
| Australia                        | January-2021   |          889012 |   25499881 |             3.49 |
| Australia                        | February-2021  |          809190 |   25499881 |             3.17 |
| Australia                        | March-2021     |          903649 |   25499881 |             3.54 |
| Australia                        | April-2021     |          885710 |   25499881 |             3.47 |
| Austria                          | February-2020  |              19 |    9006400 |                0 |
| Austria                          | March-2020     |           84802 |    9006400 |             0.94 |
| Austria                          | April-2020     |          417242 |    9006400 |             4.63 |
| Austria                          | May-2020       |          500479 |    9006400 |             5.56 |
| Austria                          | June-2020      |          515592 |    9006400 |             5.72 |
| Austria                          | July-2020      |          600464 |    9006400 |             6.67 |
| Austria                          | August-2020    |          735971 |    9006400 |             8.17 |
| Austria                          | September-2020 |         1058863 |    9006400 |            11.76 |
| Austria                          | October-2020   |         2039236 |    9006400 |            22.64 |
| Austria                          | November-2020  |         6048662 |    9006400 |            67.16 |
| Austria                          | December-2020  |        10147084 |    9006400 |           112.67 |
| Austria                          | January-2021   |        12102376 |    9006400 |           134.38 |
| Austria                          | February-2021  |        12191179 |    9006400 |           135.36 |
| Austria                          | March-2021     |        15518627 |    9006400 |           172.31 |
| Austria                          | April-2021     |        17593916 |    9006400 |           195.35 |
| Azerbaijan                       | March-2020     |            1928 |   10139175 |             0.02 |
| Azerbaijan                       | April-2020     |           35353 |   10139175 |             0.35 |
| Azerbaijan                       | May-2020       |          101560 |   10139175 |                1 |
| Azerbaijan                       | June-2020      |          326549 |   10139175 |             3.22 |
| Azerbaijan                       | July-2020      |          794844 |   10139175 |             7.84 |
| Azerbaijan                       | August-2020    |         1065366 |   10139175 |            10.51 |
| Azerbaijan                       | September-2020 |         1156339 |   10139175 |             11.4 |
| Azerbaijan                       | October-2020   |         1403733 |   10139175 |            13.84 |
| Azerbaijan                       | November-2020  |         2434291 |   10139175 |            24.01 |
| Azerbaijan                       | December-2020  |         5629069 |   10139175 |            55.52 |
| Azerbaijan                       | January-2021   |         7006474 |   10139175 |             69.1 |
| Azerbaijan                       | February-2021  |         6502320 |   10139175 |            64.13 |
| Azerbaijan                       | March-2021     |         7560926 |   10139175 |            74.57 |
| Azerbaijan                       | April-2021     |         8816077 |   10139175 |            86.95 |
| Bahamas                          | March-2020     |              99 |     393248 |             0.03 |
| Bahamas                          | April-2020     |            1578 |     393248 |              0.4 |
| Bahamas                          | May-2020       |            2933 |     393248 |             0.75 |
| Bahamas                          | June-2020      |            3100 |     393248 |             0.79 |
| Bahamas                          | July-2020      |            6403 |     393248 |             1.63 |
| Bahamas                          | August-2020    |           41780 |     393248 |            10.62 |
| Bahamas                          | September-2020 |           93104 |     393248 |            23.68 |
| Bahamas                          | October-2020   |          170339 |     393248 |            43.32 |
| Bahamas                          | November-2020  |          215718 |     393248 |            54.86 |
| Bahamas                          | December-2020  |          238552 |     393248 |            60.66 |
| Bahamas                          | January-2021   |          249177 |     393248 |            63.36 |
| Bahamas                          | February-2021  |          233940 |     393248 |            59.49 |
| Bahamas                          | March-2021     |          271796 |     393248 |            69.12 |
| Bahamas                          | April-2021     |          289640 |     393248 |            73.65 |
| Bahrain                          | February-2020  |             167 |    1701583 |             0.01 |
| Bahrain                          | March-2020     |            7765 |    1701583 |             0.46 |
| Bahrain                          | April-2020     |           48676 |    1701583 |             2.86 |
| Bahrain                          | May-2020       |          210502 |    1701583 |            12.37 |
| Bahrain                          | June-2020      |          575360 |    1701583 |            33.81 |
| Bahrain                          | July-2020      |         1074705 |    1701583 |            63.16 |
| Bahrain                          | August-2020    |         1447593 |    1701583 |            85.07 |
| Bahrain                          | September-2020 |         1856231 |    1701583 |           109.09 |
| Bahrain                          | October-2020   |         2388821 |    1701583 |           140.39 |
| Bahrain                          | November-2020  |         2539313 |    1701583 |           149.23 |
| Bahrain                          | December-2020  |         2780573 |    1701583 |           163.41 |
| Bahrain                          | January-2021   |         3022735 |    1701583 |           177.64 |
| Bahrain                          | February-2021  |         3165005 |    1701583 |              186 |
| Bahrain                          | March-2021     |         4119520 |    1701583 |            242.1 |
| Bahrain                          | April-2021     |         4837969 |    1701583 |           284.32 |
| Bangladesh                       | March-2020     |             546 |  164689383 |                0 |
| Bangladesh                       | April-2020     |           70283 |  164689383 |             0.04 |
| Bangladesh                       | May-2020       |          731311 |  164689383 |             0.44 |
| Bangladesh                       | June-2020      |         2836656 |  164689383 |             1.72 |
| Bangladesh                       | July-2020      |         6049862 |  164689383 |             3.67 |
| Bangladesh                       | August-2020    |         8565945 |  164689383 |              5.2 |
| Bangladesh                       | September-2020 |        10232791 |  164689383 |             6.21 |
| Bangladesh                       | October-2020   |        11965030 |  164689383 |             7.27 |
| Bangladesh                       | November-2020  |        13055589 |  164689383 |             7.93 |
| Bangladesh                       | December-2020  |        15301465 |  164689383 |             9.29 |
| Bangladesh                       | January-2021   |        16311378 |  164689383 |              9.9 |
| Bangladesh                       | February-2021  |        15145689 |  164689383 |              9.2 |
| Bangladesh                       | March-2021     |        17583288 |  164689383 |            10.68 |
| Bangladesh                       | April-2021     |        21032790 |  164689383 |            12.77 |
| Barbados                         | March-2020     |             255 |     287371 |             0.09 |
| Barbados                         | April-2020     |            2071 |     287371 |             0.72 |
| Barbados                         | May-2020       |            2697 |     287371 |             0.94 |
| Barbados                         | June-2020      |            2860 |     287371 |                1 |
| Barbados                         | July-2020      |            3209 |     287371 |             1.12 |
| Barbados                         | August-2020    |            4654 |     287371 |             1.62 |
| Barbados                         | September-2020 |            5515 |     287371 |             1.92 |
| Barbados                         | October-2020   |            6692 |     287371 |             2.33 |
| Barbados                         | November-2020  |            7563 |     287371 |             2.63 |
| Barbados                         | December-2020  |            9713 |     287371 |             3.38 |
| Barbados                         | January-2021   |           32342 |     287371 |            11.25 |
| Barbados                         | February-2021  |           63279 |     287371 |            22.02 |
| Barbados                         | March-2021     |          106483 |     287371 |            37.05 |
| Barbados                         | April-2021     |          112693 |     287371 |            39.22 |
| Belarus                          | February-2020  |               2 |    9449321 |                0 |
| Belarus                          | March-2020     |            1465 |    9449321 |             0.02 |
| Belarus                          | April-2020     |          150554 |    9449321 |             1.59 |
| Belarus                          | May-2020       |          888892 |    9449321 |             9.41 |
| Belarus                          | June-2020      |         1626878 |    9449321 |            17.22 |
| Belarus                          | July-2020      |         2029325 |    9449321 |            21.48 |
| Belarus                          | August-2020    |         2159686 |    9449321 |            22.86 |
| Belarus                          | September-2020 |         2246305 |    9449321 |            23.77 |
| Belarus                          | October-2020   |         2701983 |    9449321 |            28.59 |
| Belarus                          | November-2020  |         3481029 |    9449321 |            36.84 |
| Belarus                          | December-2020  |         5144839 |    9449321 |            54.45 |
| Belarus                          | January-2021   |         6908021 |    9449321 |            73.11 |
| Belarus                          | February-2021  |         7520716 |    9449321 |            79.59 |
| Belarus                          | March-2021     |         9451715 |    9449321 |           100.03 |
| Belarus                          | April-2021     |        10229519 |    9449321 |           108.26 |
| Belgium                          | February-2020  |              26 |   11589616 |                0 |
| Belgium                          | March-2020     |           89009 |   11589616 |             0.77 |
| Belgium                          | April-2020     |          993613 |   11589616 |             8.57 |
| Belgium                          | May-2020       |         1688377 |   11589616 |            14.57 |
| Belgium                          | June-2020      |         1801706 |   11589616 |            15.55 |
| Belgium                          | July-2020      |         1979139 |   11589616 |            17.08 |
| Belgium                          | August-2020    |         2409779 |   11589616 |            20.79 |
| Belgium                          | September-2020 |         2955815 |   11589616 |             25.5 |
| Belgium                          | October-2020   |         7060830 |   11589616 |            60.92 |
| Belgium                          | November-2020  |        15807456 |   11589616 |           136.39 |
| Belgium                          | December-2020  |        19046283 |   11589616 |           164.34 |
| Belgium                          | January-2021   |        20983559 |   11589616 |           181.05 |
| Belgium                          | February-2021  |        20733707 |   11589616 |            178.9 |
| Belgium                          | March-2021     |        25421637 |   11589616 |           219.35 |
| Belgium                          | April-2021     |        28207302 |   11589616 |           243.38 |
| Belize                           | March-2020     |              18 |     397621 |                0 |
| Belize                           | April-2020     |             411 |     397621 |              0.1 |
| Belize                           | May-2020       |             558 |     397621 |             0.14 |
| Belize                           | June-2020      |             633 |     397621 |             0.16 |
| Belize                           | July-2020      |            1208 |     397621 |              0.3 |
| Belize                           | August-2020    |           13861 |     397621 |             3.49 |
| Belize                           | September-2020 |           45432 |     397621 |            11.43 |
| Belize                           | October-2020   |           84329 |     397621 |            21.21 |
| Belize                           | November-2020  |          142741 |     397621 |             35.9 |
| Belize                           | December-2020  |          285706 |     397621 |            71.85 |
| Belize                           | January-2021   |          355291 |     397621 |            89.35 |
| Belize                           | February-2021  |          340198 |     397621 |            85.56 |
| Belize                           | March-2021     |          383735 |     397621 |            96.51 |
| Belize                           | April-2021     |          376175 |     397621 |            94.61 |
| Benin                            | March-2020     |              68 |   12123198 |                0 |
| Benin                            | April-2020     |            1178 |   12123198 |             0.01 |
| Benin                            | May-2020       |            6566 |   12123198 |             0.05 |
| Benin                            | June-2020      |           17757 |   12123198 |             0.15 |
| Benin                            | July-2020      |           46022 |   12123198 |             0.38 |
| Benin                            | August-2020    |           62855 |   12123198 |             0.52 |
| Benin                            | September-2020 |           68013 |   12123198 |             0.56 |
| Benin                            | October-2020   |           76944 |   12123198 |             0.63 |
| Benin                            | November-2020  |           85621 |   12123198 |             0.71 |
| Benin                            | December-2020  |           97112 |   12123198 |              0.8 |
| Benin                            | January-2021   |          107836 |   12123198 |             0.89 |
| Benin                            | February-2021  |          133911 |   12123198 |              1.1 |
| Benin                            | March-2021     |          203298 |   12123198 |             1.68 |
| Benin                            | April-2021     |          227170 |   12123198 |             1.87 |
| Bermuda                          | January-2021   |               0 |      62273 |                0 |
| Bermuda                          | February-2021  |               0 |      62273 |                0 |
| Bermuda                          | March-2021     |               0 |      62273 |                0 |
| Bermuda                          | April-2021     |               0 |      62273 |                0 |
| Bhutan                           | March-2020     |              46 |     771612 |             0.01 |
| Bhutan                           | April-2020     |             167 |     771612 |             0.02 |
| Bhutan                           | May-2020       |             561 |     771612 |             0.07 |
| Bhutan                           | June-2020      |            1897 |     771612 |             0.25 |
| Bhutan                           | July-2020      |            2700 |     771612 |             0.35 |
| Bhutan                           | August-2020    |            4396 |     771612 |             0.57 |
| Bhutan                           | September-2020 |            7485 |     771612 |             0.97 |
| Bhutan                           | October-2020   |            9919 |     771612 |             1.29 |
| Bhutan                           | November-2020  |           11234 |     771612 |             1.46 |
| Bhutan                           | December-2020  |           15035 |     771612 |             1.95 |
| Bhutan                           | January-2021   |           25294 |     771612 |             3.28 |
| Bhutan                           | February-2021  |           24183 |     771612 |             3.13 |
| Bhutan                           | March-2021     |           26933 |     771612 |             3.49 |
| Bhutan                           | April-2021     |           28670 |     771612 |             3.72 |
| Bolivia                          | March-2020     |             682 |   11673029 |             0.01 |
| Bolivia                          | April-2020     |           14801 |   11673029 |             0.13 |
| Bolivia                          | May-2020       |          137671 |   11673029 |             1.18 |
| Bolivia                          | June-2020      |          614758 |   11673029 |             5.27 |
| Bolivia                          | July-2020      |         1700323 |   11673029 |            14.57 |
| Bolivia                          | August-2020    |         3085662 |   11673029 |            26.43 |
| Bolivia                          | September-2020 |         3821303 |   11673029 |            32.74 |
| Bolivia                          | October-2020   |         4317118 |   11673029 |            36.98 |
| Bolivia                          | November-2020  |         4298716 |   11673029 |            36.83 |
| Bolivia                          | December-2020  |         4637462 |   11673029 |            39.73 |
| Bolivia                          | January-2021   |         5778389 |   11673029 |             49.5 |
| Bolivia                          | February-2021  |         6603704 |   11673029 |            56.57 |
| Bolivia                          | March-2021     |         8093271 |   11673029 |            69.33 |
| Bolivia                          | April-2021     |         8619557 |   11673029 |            73.84 |
| Bosnia and Herzegovina           | March-2020     |            2826 |    3280815 |             0.09 |
| Bosnia and Herzegovina           | April-2020     |           33408 |    3280815 |             1.02 |
| Bosnia and Herzegovina           | May-2020       |           68816 |    3280815 |              2.1 |
| Bosnia and Herzegovina           | June-2020      |           95167 |    3280815 |              2.9 |
| Bosnia and Herzegovina           | July-2020      |          241630 |    3280815 |             7.36 |
| Bosnia and Herzegovina           | August-2020    |          494986 |    3280815 |            15.09 |
| Bosnia and Herzegovina           | September-2020 |          721110 |    3280815 |            21.98 |
| Bosnia and Herzegovina           | October-2020   |         1082304 |    3280815 |            32.99 |
| Bosnia and Herzegovina           | November-2020  |         2143108 |    3280815 |            65.32 |
| Bosnia and Herzegovina           | December-2020  |         3166283 |    3280815 |            96.51 |
| Bosnia and Herzegovina           | January-2021   |         3632102 |    3280815 |           110.71 |
| Bosnia and Herzegovina           | February-2021  |         3535303 |    3280815 |           107.76 |
| Bosnia and Herzegovina           | March-2021     |         4584265 |    3280815 |           139.73 |
| Bosnia and Herzegovina           | April-2021     |         5603125 |    3280815 |           170.78 |
| Botswana                         | March-2020     |               7 |    2351625 |                0 |
| Botswana                         | April-2020     |             437 |    2351625 |             0.02 |
| Botswana                         | May-2020       |             843 |    2351625 |             0.04 |
| Botswana                         | June-2020      |            2211 |    2351625 |             0.09 |
| Botswana                         | July-2020      |           14959 |    2351625 |             0.64 |
| Botswana                         | August-2020    |           37084 |    2351625 |             1.58 |
| Botswana                         | September-2020 |           73122 |    2351625 |             3.11 |
| Botswana                         | October-2020   |          144559 |    2351625 |             6.15 |
| Botswana                         | November-2020  |          261748 |    2351625 |            11.13 |
| Botswana                         | December-2020  |          398982 |    2351625 |            16.97 |
| Botswana                         | January-2021   |          556279 |    2351625 |            23.66 |
| Botswana                         | February-2021  |          715384 |    2351625 |            30.42 |
| Botswana                         | March-2021     |         1087347 |    2351625 |            46.24 |
| Botswana                         | April-2021     |         1315455 |    2351625 |            55.94 |
| Brazil                           | February-2020  |               5 |  212559409 |                0 |
| Brazil                           | March-2020     |           37127 |  212559409 |             0.02 |
| Brazil                           | April-2020     |         1048506 |  212559409 |             0.49 |
| Brazil                           | May-2020       |         7944285 |  212559409 |             3.74 |
| Brazil                           | June-2020      |        28161222 |  212559409 |            13.25 |
| Brazil                           | July-2020      |        62641865 |  212559409 |            29.47 |
| Brazil                           | August-2020    |       102903896 |  212559409 |            48.41 |
| Brazil                           | September-2020 |       132059962 |  212559409 |            62.13 |
| Brazil                           | October-2020   |       160991539 |  212559409 |            75.74 |
| Brazil                           | November-2020  |       176837421 |  212559409 |            83.19 |
| Brazil                           | December-2020  |       218249737 |  212559409 |           102.68 |
| Brazil                           | January-2021   |       261187142 |  212559409 |           122.88 |
| Brazil                           | February-2021  |       276456100 |  212559409 |           130.06 |
| Brazil                           | March-2021     |       361059664 |  212559409 |           169.86 |
| Brazil                           | April-2021     |       412565115 |  212559409 |           194.09 |
| Brunei                           | March-2020     |            1688 |     437483 |             0.39 |
| Brunei                           | April-2020     |            4089 |     437483 |             0.93 |
| Brunei                           | May-2020       |            4354 |     437483 |                1 |
| Brunei                           | June-2020      |            4230 |     437483 |             0.97 |
| Brunei                           | July-2020      |            4371 |     437483 |                1 |
| Brunei                           | August-2020    |            4416 |     437483 |             1.01 |
| Brunei                           | September-2020 |            4355 |     437483 |                1 |
| Brunei                           | October-2020   |            4554 |     437483 |             1.04 |
| Brunei                           | November-2020  |            4455 |     437483 |             1.02 |
| Brunei                           | December-2020  |            4715 |     437483 |             1.08 |
| Brunei                           | January-2021   |            5379 |     437483 |             1.23 |
| Brunei                           | February-2021  |            5133 |     437483 |             1.17 |
| Brunei                           | March-2021     |            6155 |     437483 |             1.41 |
| Brunei                           | April-2021     |            6588 |     437483 |             1.51 |
| Bulgaria                         | March-2020     |            3576 |    6948445 |             0.05 |
| Bulgaria                         | April-2020     |           25790 |    6948445 |             0.37 |
| Bulgaria                         | May-2020       |           65828 |    6948445 |             0.95 |
| Bulgaria                         | June-2020      |          105731 |    6948445 |             1.52 |
| Bulgaria                         | July-2020      |          254933 |    6948445 |             3.67 |
| Bulgaria                         | August-2020    |          443823 |    6948445 |             6.39 |
| Bulgaria                         | September-2020 |          552189 |    6948445 |             7.95 |
| Bulgaria                         | October-2020   |          962977 |    6948445 |            13.86 |
| Bulgaria                         | November-2020  |         3044632 |    6948445 |            43.82 |
| Bulgaria                         | December-2020  |         5636378 |    6948445 |            81.12 |
| Bulgaria                         | January-2021   |         6550706 |    6948445 |            94.28 |
| Bulgaria                         | February-2021  |         6492052 |    6948445 |            93.43 |
| Bulgaria                         | March-2021     |         9012470 |    6948445 |            129.7 |
| Bulgaria                         | April-2021     |        11402304 |    6948445 |            164.1 |
| Burkina Faso                     | March-2020     |            1901 |   20903278 |             0.01 |
| Burkina Faso                     | April-2020     |           15230 |   20903278 |             0.07 |
| Burkina Faso                     | May-2020       |           24013 |   20903278 |             0.11 |
| Burkina Faso                     | June-2020      |           27120 |   20903278 |             0.13 |
| Burkina Faso                     | July-2020      |           32311 |   20903278 |             0.15 |
| Burkina Faso                     | August-2020    |           38874 |   20903278 |             0.19 |
| Burkina Faso                     | September-2020 |           51159 |   20903278 |             0.24 |
| Burkina Faso                     | October-2020   |           72258 |   20903278 |             0.35 |
| Burkina Faso                     | November-2020  |           79775 |   20903278 |             0.38 |
| Burkina Faso                     | December-2020  |          143616 |   20903278 |             0.69 |
| Burkina Faso                     | January-2021   |          275921 |   20903278 |             1.32 |
| Burkina Faso                     | February-2021  |          322977 |   20903278 |             1.55 |
| Burkina Faso                     | March-2021     |          384211 |   20903278 |             1.84 |
| Burkina Faso                     | April-2021     |          391736 |   20903278 |             1.87 |
| Burundi                          | March-2020     |               2 |   11890781 |                0 |
| Burundi                          | April-2020     |             183 |   11890781 |                0 |
| Burundi                          | May-2020       |             889 |   11890781 |             0.01 |
| Burundi                          | June-2020      |            3219 |   11890781 |             0.03 |
| Burundi                          | July-2020      |            8597 |   11890781 |             0.07 |
| Burundi                          | August-2020    |           12907 |   11890781 |             0.11 |
| Burundi                          | September-2020 |           14171 |   11890781 |             0.12 |
| Burundi                          | October-2020   |           16650 |   11890781 |             0.14 |
| Burundi                          | November-2020  |           19096 |   11890781 |             0.16 |
| Burundi                          | December-2020  |           23099 |   11890781 |             0.19 |
| Burundi                          | January-2021   |           36863 |   11890781 |             0.31 |
| Burundi                          | February-2021  |           52468 |   11890781 |             0.44 |
| Burundi                          | March-2021     |           77229 |   11890781 |             0.65 |
| Burundi                          | April-2021     |          102093 |   11890781 |             0.86 |
| Cambodia                         | January-2020   |               5 |   16718971 |                0 |
| Cambodia                         | February-2020  |              29 |   16718971 |                0 |
| Cambodia                         | March-2020     |            1225 |   16718971 |             0.01 |
| Cambodia                         | April-2020     |            3583 |   16718971 |             0.02 |
| Cambodia                         | May-2020       |            3804 |   16718971 |             0.02 |
| Cambodia                         | June-2020      |            3885 |   16718971 |             0.02 |
| Cambodia                         | July-2020      |            5473 |   16718971 |             0.03 |
| Cambodia                         | August-2020    |            8173 |   16718971 |             0.05 |
| Cambodia                         | September-2020 |            8247 |   16718971 |             0.05 |
| Cambodia                         | October-2020   |            8809 |   16718971 |             0.05 |
| Cambodia                         | November-2020  |            9085 |   16718971 |             0.05 |
| Cambodia                         | December-2020  |           11076 |   16718971 |             0.07 |
| Cambodia                         | January-2021   |           13195 |   16718971 |             0.08 |
| Cambodia                         | February-2021  |           15201 |   16718971 |             0.09 |
| Cambodia                         | March-2021     |           46744 |   16718971 |             0.28 |
| Cambodia                         | April-2021     |          189155 |   16718971 |             1.13 |
| Cameroon                         | March-2020     |            1067 |   26545864 |                0 |
| Cameroon                         | April-2020     |           30497 |   26545864 |             0.11 |
| Cameroon                         | May-2020       |          109504 |   26545864 |             0.41 |
| Cameroon                         | June-2020      |          295083 |   26545864 |             1.11 |
| Cameroon                         | July-2020      |          477610 |   26545864 |              1.8 |
| Cameroon                         | August-2020    |          570225 |   26545864 |             2.15 |
| Cameroon                         | September-2020 |          606411 |   26545864 |             2.28 |
| Cameroon                         | October-2020   |          662489 |   26545864 |              2.5 |
| Cameroon                         | November-2020  |          690210 |   26545864 |              2.6 |
| Cameroon                         | December-2020  |          788845 |   26545864 |             2.97 |
| Cameroon                         | January-2021   |          867295 |   26545864 |             3.27 |
| Cameroon                         | February-2021  |          910920 |   26545864 |             3.43 |
| Cameroon                         | March-2021     |         1255724 |   26545864 |             4.73 |
| Cameroon                         | April-2021     |         1886280 |   26545864 |             7.11 |
| Canada                           | January-2020   |              12 |   37742157 |                0 |
| Canada                           | February-2020  |             234 |   37742157 |                0 |
| Canada                           | March-2020     |           52015 |   37742157 |             0.14 |
| Canada                           | April-2020     |          929888 |   37742157 |             2.46 |
| Canada                           | May-2020       |         2369720 |   37742157 |             6.28 |
| Canada                           | June-2020      |         3016433 |   37742157 |             7.99 |
| Canada                           | July-2020      |         3460185 |   37742157 |             9.17 |
| Canada                           | August-2020    |         3854051 |   37742157 |            10.21 |
| Canada                           | September-2020 |         4290890 |   37742157 |            11.37 |
| Canada                           | October-2020   |         6126216 |   37742157 |            16.23 |
| Canada                           | November-2020  |         9141329 |   37742157 |            24.22 |
| Canada                           | December-2020  |        15031370 |   37742157 |            39.83 |
| Canada                           | January-2021   |        21663417 |   37742157 |             57.4 |
| Canada                           | February-2021  |        23280680 |   37742157 |            61.68 |
| Canada                           | March-2021     |        28667193 |   37742157 |            75.96 |
| Canada                           | April-2021     |        33242319 |   37742157 |            88.08 |
| Cape Verde                       | March-2020     |              49 |     555988 |             0.01 |
| Cape Verde                       | April-2020     |            1423 |     555988 |             0.26 |
| Cape Verde                       | May-2020       |            9336 |     555988 |             1.68 |
| Cape Verde                       | June-2020      |           23482 |     555988 |             4.22 |
| Cape Verde                       | July-2020      |           58038 |     555988 |            10.44 |
| Cape Verde                       | August-2020    |           98700 |     555988 |            17.75 |
| Cape Verde                       | September-2020 |          148629 |     555988 |            26.73 |
| Cape Verde                       | October-2020   |          232518 |     555988 |            41.82 |
| Cape Verde                       | November-2020  |          295451 |     555988 |            53.14 |
| Cape Verde                       | December-2020  |          353444 |     555988 |            63.57 |
| Cape Verde                       | January-2021   |          399245 |     555988 |            71.81 |
| Cape Verde                       | February-2021  |          412799 |     555988 |            74.25 |
| Cape Verde                       | March-2021     |          504501 |     555988 |            90.74 |
| Cape Verde                       | April-2021     |          604208 |     555988 |           108.67 |
| Cayman Islands                   | December-2020  |               0 |      65720 |                0 |
| Cayman Islands                   | January-2021   |               0 |      65720 |                0 |
| Cayman Islands                   | February-2021  |               0 |      65720 |                0 |
| Cayman Islands                   | March-2021     |               0 |      65720 |                0 |
| Cayman Islands                   | April-2021     |               0 |      65720 |                0 |
| Central African Republic         | March-2020     |              41 |    4829764 |                0 |
| Central African Republic         | April-2020     |             444 |    4829764 |             0.01 |
| Central African Republic         | May-2020       |           11339 |    4829764 |             0.23 |
| Central African Republic         | June-2020      |           70765 |    4829764 |             1.47 |
| Central African Republic         | July-2020      |          134487 |    4829764 |             2.78 |
| Central African Republic         | August-2020    |          144485 |    4829764 |             2.99 |
| Central African Republic         | September-2020 |          143052 |    4829764 |             2.96 |
| Central African Republic         | October-2020   |          150498 |    4829764 |             3.12 |
| Central African Republic         | November-2020  |          146812 |    4829764 |             3.04 |
| Central African Republic         | December-2020  |          153026 |    4829764 |             3.17 |
| Central African Republic         | January-2021   |          154155 |    4829764 |             3.19 |
| Central African Republic         | February-2021  |          139885 |    4829764 |              2.9 |
| Central African Republic         | March-2021     |          156694 |    4829764 |             3.24 |
| Central African Republic         | April-2021     |          173004 |    4829764 |             3.58 |
| Chad                             | March-2020     |              35 |   16425859 |                0 |
| Chad                             | April-2020     |             797 |   16425859 |                0 |
| Chad                             | May-2020       |           14051 |   16425859 |             0.09 |
| Chad                             | June-2020      |           25427 |   16425859 |             0.15 |
| Chad                             | July-2020      |           27639 |   16425859 |             0.17 |
| Chad                             | August-2020    |           29949 |   16425859 |             0.18 |
| Chad                             | September-2020 |           33155 |   16425859 |              0.2 |
| Chad                             | October-2020   |           41806 |   16425859 |             0.25 |
| Chad                             | November-2020  |           47873 |   16425859 |             0.29 |
| Chad                             | December-2020  |           57171 |   16425859 |             0.35 |
| Chad                             | January-2021   |           86880 |   16425859 |             0.53 |
| Chad                             | February-2021  |          102859 |   16425859 |             0.63 |
| Chad                             | March-2021     |          133784 |   16425859 |             0.81 |
| Chad                             | April-2021     |          140453 |   16425859 |             0.86 |
| Chile                            | February-2020  |              14 |   19116209 |                0 |
| Chile                            | March-2020     |           18796 |   19116209 |              0.1 |
| Chile                            | April-2020     |          285413 |   19116209 |             1.49 |
| Chile                            | May-2020       |         1763115 |   19116209 |             9.22 |
| Chile                            | June-2020      |         6291295 |   19116209 |            32.91 |
| Chile                            | July-2020      |         9987599 |   19116209 |            52.25 |
| Chile                            | August-2020    |        11936049 |   19116209 |            62.44 |
| Chile                            | September-2020 |        13147124 |   19116209 |            68.77 |
| Chile                            | October-2020   |        15134758 |   19116209 |            79.17 |
| Chile                            | November-2020  |        15945192 |   19116209 |            83.41 |
| Chile                            | December-2020  |        17938094 |   19116209 |            93.84 |
| Chile                            | January-2021   |        20661911 |   19116209 |           108.09 |
| Chile                            | February-2021  |        21754084 |   19116209 |            113.8 |
| Chile                            | March-2021     |        28062147 |   19116209 |            146.8 |
| Chile                            | April-2021     |        33124646 |   19116209 |           173.28 |
| China                            | January-2020   |           38008 | 1439323774 |                0 |
| China                            | February-2020  |         1633361 | 1439323774 |             0.11 |
| China                            | March-2020     |         2515426 | 1439323774 |             0.17 |
| China                            | April-2020     |         2500143 | 1439323774 |             0.17 |
| China                            | May-2020       |         2605281 | 1439323774 |             0.18 |
| China                            | June-2020      |         2532679 | 1439323774 |             0.18 |
| China                            | July-2020      |         2654943 | 1439323774 |             0.18 |
| China                            | August-2020    |         2764441 | 1439323774 |             0.19 |
| China                            | September-2020 |         2707451 | 1439323774 |             0.19 |
| China                            | October-2020   |         2818977 | 1439323774 |              0.2 |
| China                            | November-2020  |         2758806 | 1439323774 |             0.19 |
| China                            | December-2020  |         2931959 | 1439323774 |              0.2 |
| China                            | January-2021   |         3035071 | 1439323774 |             0.21 |
| China                            | February-2021  |         2816372 | 1439323774 |              0.2 |
| China                            | March-2021     |         3143003 | 1439323774 |             0.22 |
| China                            | April-2021     |         3064656 | 1439323774 |             0.21 |
| Colombia                         | March-2020     |            6190 |   50882884 |             0.01 |
| Colombia                         | April-2020     |          101704 |   50882884 |              0.2 |
| Colombia                         | May-2020       |          492214 |   50882884 |             0.97 |
| Colombia                         | June-2020      |         1745908 |   50882884 |             3.43 |
| Colombia                         | July-2020      |         5680255 |   50882884 |            11.16 |
| Colombia                         | August-2020    |        14415644 |   50882884 |            28.33 |
| Colombia                         | September-2020 |        21951355 |   50882884 |            43.14 |
| Colombia                         | October-2020   |        29377177 |   50882884 |            57.73 |
| Colombia                         | November-2020  |        35993382 |   50882884 |            70.74 |
| Colombia                         | December-2020  |        45578807 |   50882884 |            89.58 |
| Colombia                         | January-2021   |        58374546 |   50882884 |           114.72 |
| Colombia                         | February-2021  |        61356188 |   50882884 |           120.58 |
| Colombia                         | March-2021     |        71861747 |   50882884 |           141.23 |
| Colombia                         | April-2021     |        78567887 |   50882884 |           154.41 |
| Comoros                          | April-2020     |               1 |     869595 |                0 |
| Comoros                          | May-2020       |            1116 |     869595 |             0.13 |
| Comoros                          | June-2020      |            5961 |     869595 |             0.69 |
| Comoros                          | July-2020      |           10233 |     869595 |             1.18 |
| Comoros                          | August-2020    |           12580 |     869595 |             1.45 |
| Comoros                          | September-2020 |           13863 |     869595 |             1.59 |
| Comoros                          | October-2020   |           15608 |     869595 |             1.79 |
| Comoros                          | November-2020  |           17436 |     869595 |             2.01 |
| Comoros                          | December-2020  |           20497 |     869595 |             2.36 |
| Comoros                          | January-2021   |           51485 |     869595 |             5.92 |
| Comoros                          | February-2021  |           92325 |     869595 |            10.62 |
| Comoros                          | March-2021     |          112884 |     869595 |            12.98 |
| Comoros                          | April-2021     |          113736 |     869595 |            13.08 |
| Congo                            | March-2020     |              97 |    5518092 |                0 |
| Congo                            | April-2020     |            3419 |    5518092 |             0.06 |
| Congo                            | May-2020       |           12105 |    5518092 |             0.22 |
| Congo                            | June-2020      |           25460 |    5518092 |             0.46 |
| Congo                            | July-2020      |           73328 |    5518092 |             1.33 |
| Congo                            | August-2020    |          116513 |    5518092 |             2.11 |
| Congo                            | September-2020 |          146292 |    5518092 |             2.65 |
| Congo                            | October-2020   |          159997 |    5518092 |              2.9 |
| Congo                            | November-2020  |          165519 |    5518092 |                3 |
| Congo                            | December-2020  |          193968 |    5518092 |             3.52 |
| Congo                            | January-2021   |          232416 |    5518092 |             4.21 |
| Congo                            | February-2021  |          234475 |    5518092 |             4.25 |
| Congo                            | March-2021     |          290998 |    5518092 |             5.27 |
| Congo                            | April-2021     |          304069 |    5518092 |             5.51 |
| Costa Rica                       | March-2020     |            2987 |    5094114 |             0.06 |
| Costa Rica                       | April-2020     |           17866 |    5094114 |             0.35 |
| Costa Rica                       | May-2020       |           26697 |    5094114 |             0.52 |
| Costa Rica                       | June-2020      |           58319 |    5094114 |             1.14 |
| Costa Rica                       | July-2020      |          309536 |    5094114 |             6.08 |
| Costa Rica                       | August-2020    |          890542 |    5094114 |            17.48 |
| Costa Rica                       | September-2020 |         1771225 |    5094114 |            34.77 |
| Costa Rica                       | October-2020   |         2901099 |    5094114 |            56.95 |
| Costa Rica                       | November-2020  |         3734891 |    5094114 |            73.32 |
| Costa Rica                       | December-2020  |         4796194 |    5094114 |            94.15 |
| Costa Rica                       | January-2021   |         5681017 |    5094114 |           111.52 |
| Costa Rica                       | February-2021  |         5594208 |    5094114 |           109.82 |
| Costa Rica                       | March-2021     |         6522718 |    5094114 |           128.04 |
| Costa Rica                       | April-2021     |         6872891 |    5094114 |           134.92 |
| Croatia                          | February-2020  |              18 |    4105268 |                0 |
| Croatia                          | March-2020     |            6404 |    4105268 |             0.16 |
| Croatia                          | April-2020     |           49646 |    4105268 |             1.21 |
| Croatia                          | May-2020       |           68134 |    4105268 |             1.66 |
| Croatia                          | June-2020      |           70331 |    4105268 |             1.71 |
| Croatia                          | July-2020      |          124811 |    4105268 |             3.04 |
| Croatia                          | August-2020    |          217353 |    4105268 |             5.29 |
| Croatia                          | September-2020 |          415353 |    4105268 |            10.12 |
| Croatia                          | October-2020   |          831572 |    4105268 |            20.26 |
| Croatia                          | November-2020  |         2599232 |    4105268 |            63.31 |
| Croatia                          | December-2020  |         5539120 |    4105268 |           134.93 |
| Croatia                          | January-2021   |         6921173 |    4105268 |           168.59 |
| Croatia                          | February-2021  |         6657593 |    4105268 |           162.17 |
| Croatia                          | March-2021     |         7881286 |    4105268 |           191.98 |
| Croatia                          | April-2021     |         9063636 |    4105268 |           220.78 |
| Cuba                             | March-2020     |            1020 |   11326616 |             0.01 |
| Cuba                             | April-2020     |           25438 |   11326616 |             0.22 |
| Cuba                             | May-2020       |           56950 |   11326616 |              0.5 |
| Cuba                             | June-2020      |           67429 |   11326616 |              0.6 |
| Cuba                             | July-2020      |           75857 |   11326616 |             0.67 |
| Cuba                             | August-2020    |          102621 |   11326616 |             0.91 |
| Cuba                             | September-2020 |          145208 |   11326616 |             1.28 |
| Cuba                             | October-2020   |          192396 |   11326616 |              1.7 |
| Cuba                             | November-2020  |          228288 |   11326616 |             2.02 |
| Cuba                             | December-2020  |          305830 |   11326616 |              2.7 |
| Cuba                             | January-2021   |          554408 |   11326616 |             4.89 |
| Cuba                             | February-2021  |         1088096 |   11326616 |             9.61 |
| Cuba                             | March-2021     |         1949383 |   11326616 |            17.21 |
| Cuba                             | April-2021     |         2738557 |   11326616 |            24.18 |
| Curacao                          | March-2021     |               0 |     164100 |                0 |
| Curacao                          | April-2021     |               0 |     164100 |                0 |
| Cyprus                           | February-2020  |               0 |     875899 |                0 |
| Cyprus                           | March-2020     |            2089 |     875899 |             0.24 |
| Cyprus                           | April-2020     |           19846 |     875899 |             2.27 |
| Cyprus                           | May-2020       |           28209 |     875899 |             3.22 |
| Cyprus                           | June-2020      |           29366 |     875899 |             3.35 |
| Cyprus                           | July-2020      |           32017 |     875899 |             3.66 |
| Cyprus                           | August-2020    |           41372 |     875899 |             4.72 |
| Cyprus                           | September-2020 |           47357 |     875899 |             5.41 |
| Cyprus                           | October-2020   |           82890 |     875899 |             9.46 |
| Cyprus                           | November-2020  |          222920 |     875899 |            25.45 |
| Cyprus                           | December-2020  |          500151 |     875899 |             57.1 |
| Cyprus                           | January-2021   |          872089 |     875899 |            99.57 |
| Cyprus                           | February-2021  |          913382 |     875899 |           104.28 |
| Cyprus                           | March-2021     |         1250242 |     875899 |           142.74 |
| Cyprus                           | April-2021     |         1655891 |     875899 |           189.05 |
| Czechia                          | March-2020     |           25984 |   10708982 |             0.24 |
| Czechia                          | April-2020     |          184001 |   10708982 |             1.72 |
| Czechia                          | May-2020       |          262979 |   10708982 |             2.46 |
| Czechia                          | June-2020      |          307889 |   10708982 |             2.88 |
| Czechia                          | July-2020      |          430742 |   10708982 |             4.02 |
| Czechia                          | August-2020    |          628547 |   10708982 |             5.87 |
| Czechia                          | September-2020 |         1304611 |   10708982 |            12.18 |
| Czechia                          | October-2020   |         5443207 |   10708982 |            50.83 |
| Czechia                          | November-2020  |        13617115 |   10708982 |           127.16 |
| Czechia                          | December-2020  |        18743896 |   10708982 |           175.03 |
| Czechia                          | January-2021   |        26959120 |   10708982 |           251.74 |
| Czechia                          | February-2021  |        30777715 |   10708982 |            287.4 |
| Czechia                          | March-2021     |        43611257 |   10708982 |           407.24 |
| Czechia                          | April-2021     |        47718289 |   10708982 |           445.59 |
| Democratic Republic of Congo     | March-2020     |             642 |   89561404 |                0 |
| Democratic Republic of Congo     | April-2020     |            8639 |   89561404 |             0.01 |
| Democratic Republic of Congo     | May-2020       |           48228 |   89561404 |             0.05 |
| Democratic Republic of Congo     | June-2020      |          152518 |   89561404 |             0.17 |
| Democratic Republic of Congo     | July-2020      |          253461 |   89561404 |             0.28 |
| Democratic Republic of Congo     | August-2020    |          298422 |   89561404 |             0.33 |
| Democratic Republic of Congo     | September-2020 |          312145 |   89561404 |             0.35 |
| Democratic Republic of Congo     | October-2020   |          340349 |   89561404 |             0.38 |
| Democratic Republic of Congo     | November-2020  |          357658 |   89561404 |              0.4 |
| Democratic Republic of Congo     | December-2020  |          465473 |   89561404 |             0.52 |
| Democratic Republic of Congo     | January-2021   |          633392 |   89561404 |             0.71 |
| Democratic Republic of Congo     | February-2021  |          682090 |   89561404 |             0.76 |
| Democratic Republic of Congo     | March-2021     |          841033 |   89561404 |             0.94 |
| Democratic Republic of Congo     | April-2021     |          867489 |   89561404 |             0.97 |
| Denmark                          | February-2020  |               5 |    5792203 |                0 |
| Denmark                          | March-2020     |           32722 |    5792203 |             0.56 |
| Denmark                          | April-2020     |          203547 |    5792203 |             3.51 |
| Denmark                          | May-2020       |          338822 |    5792203 |             5.85 |
| Denmark                          | June-2020      |          373368 |    5792203 |             6.45 |
| Denmark                          | July-2020      |          414692 |    5792203 |             7.16 |
| Denmark                          | August-2020    |          490789 |    5792203 |             8.47 |
| Denmark                          | September-2020 |          658184 |    5792203 |            11.36 |
| Denmark                          | October-2020   |         1116242 |    5792203 |            19.27 |
| Denmark                          | November-2020  |         1916850 |    5792203 |            33.09 |
| Denmark                          | December-2020  |         3767540 |    5792203 |            65.05 |
| Denmark                          | January-2021   |         5785270 |    5792203 |            99.88 |
| Denmark                          | February-2021  |         5754590 |    5792203 |            99.35 |
| Denmark                          | March-2021     |         6880888 |    5792203 |            118.8 |
| Denmark                          | April-2021     |         7249735 |    5792203 |           125.16 |
| Djibouti                         | March-2020     |             125 |     988002 |             0.01 |
| Djibouti                         | April-2020     |           16283 |     988002 |             1.65 |
| Djibouti                         | May-2020       |           54254 |     988002 |             5.49 |
| Djibouti                         | June-2020      |          132173 |     988002 |            13.38 |
| Djibouti                         | July-2020      |          153695 |     988002 |            15.56 |
| Djibouti                         | August-2020    |          165639 |     988002 |            16.77 |
| Djibouti                         | September-2020 |          161960 |     988002 |            16.39 |
| Djibouti                         | October-2020   |          169641 |     988002 |            17.17 |
| Djibouti                         | November-2020  |          169185 |     988002 |            17.12 |
| Djibouti                         | December-2020  |          178378 |     988002 |            18.05 |
| Djibouti                         | January-2021   |          182684 |     988002 |            18.49 |
| Djibouti                         | February-2021  |          167737 |     988002 |            16.98 |
| Djibouti                         | March-2021     |          203948 |     988002 |            20.64 |
| Djibouti                         | April-2021     |          300878 |     988002 |            30.45 |
| Dominica                         | March-2020     |              79 |      71991 |             0.11 |
| Dominica                         | April-2020     |             460 |      71991 |             0.64 |
| Dominica                         | May-2020       |             496 |      71991 |             0.69 |
| Dominica                         | June-2020      |             538 |      71991 |             0.75 |
| Dominica                         | July-2020      |             558 |      71991 |             0.78 |
| Dominica                         | August-2020    |             576 |      71991 |              0.8 |
| Dominica                         | September-2020 |             718 |      71991 |                1 |
| Dominica                         | October-2020   |            1061 |      71991 |             1.47 |
| Dominica                         | November-2020  |            2033 |      71991 |             2.82 |
| Dominica                         | December-2020  |            2696 |      71991 |             3.74 |
| Dominica                         | January-2021   |            3325 |      71991 |             4.62 |
| Dominica                         | February-2021  |            3612 |      71991 |             5.02 |
| Dominica                         | March-2021     |            4761 |      71991 |             6.61 |
| Dominica                         | April-2021     |            5029 |      71991 |             6.99 |
| Dominican Republic               | March-2020     |            6140 |   10847904 |             0.06 |
| Dominican Republic               | April-2020     |          115932 |   10847904 |             1.07 |
| Dominican Republic               | May-2020       |          376401 |   10847904 |             3.47 |
| Dominican Republic               | June-2020      |          721962 |   10847904 |             6.66 |
| Dominican Republic               | July-2020      |         1543434 |   10847904 |            14.23 |
| Dominican Republic               | August-2020    |         2630788 |   10847904 |            24.25 |
| Dominican Republic               | September-2020 |         3143556 |   10847904 |            28.98 |
| Dominican Republic               | October-2020   |         3727191 |   10847904 |            34.36 |
| Dominican Republic               | November-2020  |         4036491 |   10847904 |            37.21 |
| Dominican Republic               | December-2020  |         4864830 |   10847904 |            44.85 |
| Dominican Republic               | January-2021   |         5941766 |   10847904 |            54.77 |
| Dominican Republic               | February-2021  |         6413645 |   10847904 |            59.12 |
| Dominican Republic               | March-2021     |         7652946 |   10847904 |            70.55 |
| Dominican Republic               | April-2021     |         7794798 |   10847904 |            71.86 |
| Ecuador                          | March-2020     |           16469 |   17643060 |             0.09 |
| Ecuador                          | April-2020     |          321161 |   17643060 |             1.82 |
| Ecuador                          | May-2020       |         1029314 |   17643060 |             5.83 |
| Ecuador                          | June-2020      |         1429745 |   17643060 |              8.1 |
| Ecuador                          | July-2020      |         2217004 |   17643060 |            12.57 |
| Ecuador                          | August-2020    |         3121790 |   17643060 |            17.69 |
| Ecuador                          | September-2020 |         3678159 |   17643060 |            20.85 |
| Ecuador                          | October-2020   |         4714534 |   17643060 |            26.72 |
| Ecuador                          | November-2020  |         5411330 |   17643060 |            30.67 |
| Ecuador                          | December-2020  |         6306084 |   17643060 |            35.74 |
| Ecuador                          | January-2021   |         7125483 |   17643060 |            40.39 |
| Ecuador                          | February-2021  |         7472445 |   17643060 |            42.35 |
| Ecuador                          | March-2021     |         9480656 |   17643060 |            53.74 |
| Ecuador                          | April-2021     |        10654344 |   17643060 |            60.39 |
| Egypt                            | February-2020  |              16 |  102334403 |                0 |
| Egypt                            | March-2020     |            7140 |  102334403 |             0.01 |
| Egypt                            | April-2020     |           83386 |  102334403 |             0.08 |
| Egypt                            | May-2020       |          403993 |  102334403 |             0.39 |
| Egypt                            | June-2020      |         1406847 |  102334403 |             1.37 |
| Egypt                            | July-2020      |         2615575 |  102334403 |             2.56 |
| Egypt                            | August-2020    |         2991066 |  102334403 |             2.92 |
| Egypt                            | September-2020 |         3038840 |  102334403 |             2.97 |
| Egypt                            | October-2020   |         3263459 |  102334403 |             3.19 |
| Egypt                            | November-2020  |         3339298 |  102334403 |             3.26 |
| Egypt                            | December-2020  |         3859859 |  102334403 |             3.77 |
| Egypt                            | January-2021   |         4792291 |  102334403 |             4.68 |
| Egypt                            | February-2021  |         4878915 |  102334403 |             4.77 |
| Egypt                            | March-2021     |         5961213 |  102334403 |             5.83 |
| Egypt                            | April-2021     |         6435218 |  102334403 |             6.29 |
| El Salvador                      | March-2020     |             156 |    6486201 |                0 |
| El Salvador                      | April-2020     |            5333 |    6486201 |             0.08 |
| El Salvador                      | May-2020       |           41262 |    6486201 |             0.64 |
| El Salvador                      | June-2020      |          122784 |    6486201 |             1.89 |
| El Salvador                      | July-2020      |          347650 |    6486201 |             5.36 |
| El Salvador                      | August-2020    |          692113 |    6486201 |            10.67 |
| El Salvador                      | September-2020 |          819156 |    6486201 |            12.63 |
| El Salvador                      | October-2020   |          969372 |    6486201 |            14.95 |
| El Salvador                      | November-2020  |         1095940 |    6486201 |             16.9 |
| El Salvador                      | December-2020  |         1318177 |    6486201 |            20.32 |
| El Salvador                      | January-2021   |         1573181 |    6486201 |            24.25 |
| El Salvador                      | February-2021  |         1619262 |    6486201 |            24.96 |
| El Salvador                      | March-2021     |         1939285 |    6486201 |             29.9 |
| El Salvador                      | April-2021     |         2010965 |    6486201 |               31 |
| Equatorial Guinea                | March-2020     |             130 |    1402985 |             0.01 |
| Equatorial Guinea                | April-2020     |            2867 |    1402985 |              0.2 |
| Equatorial Guinea                | May-2020       |           21842 |    1402985 |             1.56 |
| Equatorial Guinea                | June-2020      |           46572 |    1402985 |             3.32 |
| Equatorial Guinea                | July-2020      |           95881 |    1402985 |             6.83 |
| Equatorial Guinea                | August-2020    |          150812 |    1402985 |            10.75 |
| Equatorial Guinea                | September-2020 |          149975 |    1402985 |            10.69 |
| Equatorial Guinea                | October-2020   |          157079 |    1402985 |             11.2 |
| Equatorial Guinea                | November-2020  |          153445 |    1402985 |            10.94 |
| Equatorial Guinea                | December-2020  |          161321 |    1402985 |             11.5 |
| Equatorial Guinea                | January-2021   |          166183 |    1402985 |            11.84 |
| Equatorial Guinea                | February-2021  |          159963 |    1402985 |             11.4 |
| Equatorial Guinea                | March-2021     |          203858 |    1402985 |            14.53 |
| Equatorial Guinea                | April-2021     |          219014 |    1402985 |            15.61 |
| Eritrea                          | March-2020     |              65 |    3546427 |                0 |
| Eritrea                          | April-2020     |            1027 |    3546427 |             0.03 |
| Eritrea                          | May-2020       |            1209 |    3546427 |             0.03 |
| Eritrea                          | June-2020      |            3083 |    3546427 |             0.09 |
| Eritrea                          | July-2020      |            7490 |    3546427 |             0.21 |
| Eritrea                          | August-2020    |            9178 |    3546427 |             0.26 |
| Eritrea                          | September-2020 |           10664 |    3546427 |              0.3 |
| Eritrea                          | October-2020   |           13346 |    3546427 |             0.38 |
| Eritrea                          | November-2020  |           15545 |    3546427 |             0.44 |
| Eritrea                          | December-2020  |           24769 |    3546427 |              0.7 |
| Eritrea                          | January-2021   |           54320 |    3546427 |             1.53 |
| Eritrea                          | February-2021  |           70980 |    3546427 |                2 |
| Eritrea                          | March-2021     |           95058 |    3546427 |             2.68 |
| Eritrea                          | April-2021     |          104836 |    3546427 |             2.96 |
| Estonia                          | February-2020  |               3 |    1326539 |                0 |
| Estonia                          | March-2020     |            7350 |    1326539 |             0.55 |
| Estonia                          | April-2020     |           41075 |    1326539 |              3.1 |
| Estonia                          | May-2020       |           55005 |    1326539 |             4.15 |
| Estonia                          | June-2020      |           58725 |    1326539 |             4.43 |
| Estonia                          | July-2020      |           62542 |    1326539 |             4.71 |
| Estonia                          | August-2020    |           68481 |    1326539 |             5.16 |
| Estonia                          | September-2020 |           83987 |    1326539 |             6.33 |
| Estonia                          | October-2020   |          125799 |    1326539 |             9.48 |
| Estonia                          | November-2020  |          241995 |    1326539 |            18.24 |
| Estonia                          | December-2020  |          612913 |    1326539 |             46.2 |
| Estonia                          | January-2021   |         1127645 |    1326539 |            85.01 |
| Estonia                          | February-2021  |         1495578 |    1326539 |           112.74 |
| Estonia                          | March-2021     |         2713051 |    1326539 |           204.52 |
| Estonia                          | April-2021     |         3472209 |    1326539 |           261.75 |
| Eswatini                         | March-2020     |              75 |    1160164 |             0.01 |
| Eswatini                         | April-2020     |             843 |    1160164 |             0.07 |
| Eswatini                         | May-2020       |            6137 |    1160164 |             0.53 |
| Eswatini                         | June-2020      |           15782 |    1160164 |             1.36 |
| Eswatini                         | July-2020      |           50503 |    1160164 |             4.35 |
| Eswatini                         | August-2020    |          115702 |    1160164 |             9.97 |
| Eswatini                         | September-2020 |          153585 |    1160164 |            13.24 |
| Eswatini                         | October-2020   |          177725 |    1160164 |            15.32 |
| Eswatini                         | November-2020  |          183907 |    1160164 |            15.85 |
| Eswatini                         | December-2020  |          227464 |    1160164 |            19.61 |
| Eswatini                         | January-2021   |          394910 |    1160164 |            34.04 |
| Eswatini                         | February-2021  |          462296 |    1160164 |            39.85 |
| Eswatini                         | March-2021     |          534337 |    1160164 |            46.06 |
| Eswatini                         | April-2021     |          541073 |    1160164 |            46.64 |
| Ethiopia                         | March-2020     |             203 |  114963583 |                0 |
| Ethiopia                         | April-2020     |            2558 |  114963583 |                0 |
| Ethiopia                         | May-2020       |           12773 |  114963583 |             0.01 |
| Ethiopia                         | June-2020      |          106607 |  114963583 |             0.09 |
| Ethiopia                         | July-2020      |          300942 |  114963583 |             0.26 |
| Ethiopia                         | August-2020    |          998557 |  114963583 |             0.87 |
| Ethiopia                         | September-2020 |         1964723 |  114963583 |             1.71 |
| Ethiopia                         | October-2020   |         2703736 |  114963583 |             2.35 |
| Ethiopia                         | November-2020  |         3089373 |  114963583 |             2.69 |
| Ethiopia                         | December-2020  |         3653211 |  114963583 |             3.18 |
| Ethiopia                         | January-2021   |         4052409 |  114963583 |             3.52 |
| Ethiopia                         | February-2021  |         4140296 |  114963583 |              3.6 |
| Ethiopia                         | March-2021     |         5589105 |  114963583 |             4.86 |
| Ethiopia                         | April-2021     |         7079762 |  114963583 |             6.16 |
| Faeroe Islands                   | January-2021   |               0 |      48865 |                0 |
| Faeroe Islands                   | February-2021  |               0 |      48865 |                0 |
| Faeroe Islands                   | March-2021     |               0 |      48865 |                0 |
| Faeroe Islands                   | April-2021     |               0 |      48865 |                0 |
| Falkland Islands                 | February-2021  |               0 |       3483 |                0 |
| Falkland Islands                 | March-2021     |               0 |       3483 |                0 |
| Falkland Islands                 | April-2021     |               0 |       3483 |                0 |
| Fiji                             | January-2020   |               0 |     896444 |                0 |
| Fiji                             | February-2020  |               0 |     896444 |                0 |
| Fiji                             | March-2020     |              47 |     896444 |             0.01 |
| Fiji                             | April-2020     |             464 |     896444 |             0.05 |
| Fiji                             | May-2020       |             558 |     896444 |             0.06 |
| Fiji                             | June-2020      |             540 |     896444 |             0.06 |
| Fiji                             | July-2020      |             765 |     896444 |             0.09 |
| Fiji                             | August-2020    |             856 |     896444 |              0.1 |
| Fiji                             | September-2020 |             944 |     896444 |             0.11 |
| Fiji                             | October-2020   |            1006 |     896444 |             0.11 |
| Fiji                             | November-2020  |            1065 |     896444 |             0.12 |
| Fiji                             | December-2020  |            1405 |     896444 |             0.16 |
| Fiji                             | January-2021   |            1659 |     896444 |             0.19 |
| Fiji                             | February-2021  |            1577 |     896444 |             0.18 |
| Fiji                             | March-2021     |            2031 |     896444 |             0.23 |
| Fiji                             | April-2021     |            2357 |     896444 |             0.26 |
| Finland                          | January-2020   |               3 |    5540718 |                0 |
| Finland                          | February-2020  |              34 |    5540718 |                0 |
| Finland                          | March-2020     |           13382 |    5540718 |             0.24 |
| Finland                          | April-2020     |           99473 |    5540718 |              1.8 |
| Finland                          | May-2020       |          190615 |    5540718 |             3.44 |
| Finland                          | June-2020      |          212396 |    5540718 |             3.83 |
| Finland                          | July-2020      |          226937 |    5540718 |              4.1 |
| Finland                          | August-2020    |          240361 |    5540718 |             4.34 |
| Finland                          | September-2020 |          265431 |    5540718 |             4.79 |
| Finland                          | October-2020   |          403740 |    5540718 |             7.29 |
| Finland                          | November-2020  |          596628 |    5540718 |            10.77 |
| Finland                          | December-2020  |          973027 |    5540718 |            17.56 |
| Finland                          | January-2021   |         1250210 |    5540718 |            22.56 |
| Finland                          | February-2021  |         1425623 |    5540718 |            25.73 |
| Finland                          | March-2021     |         2109166 |    5540718 |            38.07 |
| Finland                          | April-2021     |         2491149 |    5540718 |            44.96 |
| France                           | January-2020   |              30 |   68147687 |                0 |
| France                           | February-2020  |             466 |   68147687 |                0 |
| France                           | March-2020     |          407938 |   68147687 |              0.6 |
| France                           | April-2020     |         3456319 |   68147687 |             5.07 |
| France                           | May-2020       |         5602193 |   68147687 |             8.22 |
| France                           | June-2020      |         5922508 |   68147687 |             8.69 |
| France                           | July-2020      |         6640187 |   68147687 |             9.74 |
| France                           | August-2020    |         8150489 |   68147687 |            11.96 |
| France                           | September-2020 |        13600511 |   68147687 |            19.96 |
| France                           | October-2020   |        28773948 |   68147687 |            42.22 |
| France                           | November-2020  |        59733195 |   68147687 |            87.65 |
| France                           | December-2020  |        76678082 |   68147687 |           112.52 |
| France                           | January-2021   |        91573599 |   68147687 |           134.38 |
| France                           | February-2021  |        98925593 |   68147687 |           145.16 |
| France                           | March-2021     |       130615782 |   68147687 |           191.67 |
| France                           | April-2021     |       157155770 |   68147687 |           230.61 |
| Gabon                            | March-2020     |              86 |    2225728 |                0 |
| Gabon                            | April-2020     |            3106 |    2225728 |             0.14 |
| Gabon                            | May-2020       |           40885 |    2225728 |             1.84 |
| Gabon                            | June-2020      |          120239 |    2225728 |              5.4 |
| Gabon                            | July-2020      |          195607 |    2225728 |             8.79 |
| Gabon                            | August-2020    |          252682 |    2225728 |            11.35 |
| Gabon                            | September-2020 |          259821 |    2225728 |            11.67 |
| Gabon                            | October-2020   |          275060 |    2225728 |            12.36 |
| Gabon                            | November-2020  |          272546 |    2225728 |            12.25 |
| Gabon                            | December-2020  |          290679 |    2225728 |            13.06 |
| Gabon                            | January-2021   |          310352 |    2225728 |            13.94 |
| Gabon                            | February-2021  |          356809 |    2225728 |            16.03 |
| Gabon                            | March-2021     |          529781 |    2225728 |             23.8 |
| Gabon                            | April-2021     |          641075 |    2225728 |             28.8 |
| Gambia                           | March-2020     |              35 |    2416664 |                0 |
| Gambia                           | April-2020     |             233 |    2416664 |             0.01 |
| Gambia                           | May-2020       |             680 |    2416664 |             0.03 |
| Gambia                           | June-2020      |            1016 |    2416664 |             0.04 |
| Gambia                           | July-2020      |            4434 |    2416664 |             0.18 |
| Gambia                           | August-2020    |           56688 |    2416664 |             2.35 |
| Gambia                           | September-2020 |          101729 |    2416664 |             4.21 |
| Gambia                           | October-2020   |          112779 |    2416664 |             4.67 |
| Gambia                           | November-2020  |          111147 |    2416664 |              4.6 |
| Gambia                           | December-2020  |          117237 |    2416664 |             4.85 |
| Gambia                           | January-2021   |          121312 |    2416664 |             5.02 |
| Gambia                           | February-2021  |          123614 |    2416664 |             5.12 |
| Gambia                           | March-2021     |          156651 |    2416664 |             6.48 |
| Gambia                           | April-2021     |          170688 |    2416664 |             7.06 |
| Georgia                          | February-2020  |               4 |    3989175 |                0 |
| Georgia                          | March-2020     |            1256 |    3989175 |             0.03 |
| Georgia                          | April-2020     |            9767 |    3989175 |             0.24 |
| Georgia                          | May-2020       |           20931 |    3989175 |             0.52 |
| Georgia                          | June-2020      |           25966 |    3989175 |             0.65 |
| Georgia                          | July-2020      |           31917 |    3989175 |              0.8 |
| Georgia                          | August-2020    |           41023 |    3989175 |             1.03 |
| Georgia                          | September-2020 |           91939 |    3989175 |              2.3 |
| Georgia                          | October-2020   |          573395 |    3989175 |            14.37 |
| Georgia                          | November-2020  |         2505524 |    3989175 |            62.81 |
| Georgia                          | December-2020  |         5970896 |    3989175 |           149.68 |
| Georgia                          | January-2021   |         7590826 |    3989175 |           190.29 |
| Georgia                          | February-2021  |         7429803 |    3989175 |           186.25 |
| Georgia                          | March-2021     |         8552929 |    3989175 |            214.4 |
| Georgia                          | April-2021     |         8819854 |    3989175 |           221.09 |
| Germany                          | January-2020   |              18 |   83783945 |                0 |
| Germany                          | February-2020  |             561 |   83783945 |                0 |
| Germany                          | March-2020     |          588179 |   83783945 |              0.7 |
| Germany                          | April-2020     |         3942925 |   83783945 |             4.71 |
| Germany                          | May-2020       |         5427815 |   83783945 |             6.48 |
| Germany                          | June-2020      |         5670762 |   83783945 |             6.77 |
| Germany                          | July-2020      |         6265079 |   83783945 |             7.48 |
| Germany                          | August-2020    |         7024733 |   83783945 |             8.38 |
| Germany                          | September-2020 |         8023521 |   83783945 |             9.58 |
| Germany                          | October-2020   |        11653042 |   83783945 |            13.91 |
| Germany                          | November-2020  |        24564361 |   83783945 |            29.32 |
| Germany                          | December-2020  |        44141683 |   83783945 |            52.69 |
| Germany                          | January-2021   |        62555458 |   83783945 |            74.66 |
| Germany                          | February-2021  |        65660655 |   83783945 |            78.37 |
| Germany                          | March-2021     |        81277883 |   83783945 |            97.01 |
| Germany                          | April-2021     |        93513080 |   83783945 |           111.61 |
| Ghana                            | March-2020     |            1146 |   31072945 |                0 |
| Ghana                            | April-2020     |           24029 |   31072945 |             0.08 |
| Ghana                            | May-2020       |          164583 |   31072945 |             0.53 |
| Ghana                            | June-2020      |          370733 |   31072945 |             1.19 |
| Ghana                            | July-2020      |          826344 |   31072945 |             2.66 |
| Ghana                            | August-2020    |         1296178 |   31072945 |             4.17 |
| Ghana                            | September-2020 |         1368073 |   31072945 |              4.4 |
| Ghana                            | October-2020   |         1465886 |   31072945 |             4.72 |
| Ghana                            | November-2020  |         1501148 |   31072945 |             4.83 |
| Ghana                            | December-2020  |         1651837 |   31072945 |             5.32 |
| Ghana                            | January-2021   |         1813441 |   31072945 |             5.84 |
| Ghana                            | February-2021  |         2124578 |   31072945 |             6.84 |
| Ghana                            | March-2021     |         2726591 |   31072945 |             8.77 |
| Ghana                            | April-2021     |         2746420 |   31072945 |             8.84 |
| Gibraltar                        | January-2021   |               0 |      33691 |                0 |
| Gibraltar                        | February-2021  |               0 |      33691 |                0 |
| Gibraltar                        | March-2021     |               0 |      33691 |                0 |
| Gibraltar                        | April-2021     |               0 |      33691 |                0 |
| Greece                           | February-2020  |              12 |   10423056 |                0 |
| Greece                           | March-2020     |           13397 |   10423056 |             0.13 |
| Greece                           | April-2020     |           64317 |   10423056 |             0.62 |
| Greece                           | May-2020       |           86384 |   10423056 |             0.83 |
| Greece                           | June-2020      |           94867 |   10423056 |             0.91 |
| Greece                           | July-2020      |          121131 |   10423056 |             1.16 |
| Greece                           | August-2020    |          222406 |   10423056 |             2.13 |
| Greece                           | September-2020 |          424201 |   10423056 |             4.07 |
| Greece                           | October-2020   |          802968 |   10423056 |              7.7 |
| Greece                           | November-2020  |         2243451 |   10423056 |            21.52 |
| Greece                           | December-2020  |         3904326 |   10423056 |            37.46 |
| Greece                           | January-2021   |         4585941 |   10423056 |               44 |
| Greece                           | February-2021  |         4844582 |   10423056 |            46.48 |
| Greece                           | March-2021     |         7014206 |   10423056 |             67.3 |
| Greece                           | April-2021     |         9230831 |   10423056 |            88.56 |
| Greenland                        | January-2021   |               0 |      56772 |                0 |
| Greenland                        | February-2021  |               0 |      56772 |                0 |
| Greenland                        | March-2021     |               0 |      56772 |                0 |
| Greenland                        | April-2021     |               0 |      56772 |                0 |
| Grenada                          | March-2020     |              52 |     112519 |             0.05 |
| Grenada                          | April-2020     |             429 |     112519 |             0.38 |
| Grenada                          | May-2020       |             674 |     112519 |              0.6 |
| Grenada                          | June-2020      |             690 |     112519 |             0.61 |
| Grenada                          | July-2020      |             715 |     112519 |             0.64 |
| Grenada                          | August-2020    |             744 |     112519 |             0.66 |
| Grenada                          | September-2020 |             720 |     112519 |             0.64 |
| Grenada                          | October-2020   |             802 |     112519 |             0.71 |
| Grenada                          | November-2020  |            1051 |     112519 |             0.93 |
| Grenada                          | December-2020  |            2429 |     112519 |             2.16 |
| Grenada                          | January-2021   |            4240 |     112519 |             3.77 |
| Grenada                          | February-2021  |            4144 |     112519 |             3.68 |
| Grenada                          | March-2021     |            4696 |     112519 |             4.17 |
| Grenada                          | April-2021     |            4694 |     112519 |             4.17 |
| Guatemala                        | February-2020  |               0 |   17915567 |                0 |
| Guatemala                        | March-2020     |             333 |   17915567 |                0 |
| Guatemala                        | April-2020     |            7312 |   17915567 |             0.04 |
| Guatemala                        | May-2020       |           67102 |   17915567 |             0.37 |
| Guatemala                        | June-2020      |          329549 |   17915567 |             1.84 |
| Guatemala                        | July-2020      |         1062083 |   17915567 |             5.93 |
| Guatemala                        | August-2020    |         1938713 |   17915567 |            10.82 |
| Guatemala                        | September-2020 |         2495864 |   17915567 |            13.93 |
| Guatemala                        | October-2020   |         3106103 |   17915567 |            17.34 |
| Guatemala                        | November-2020  |         3454791 |   17915567 |            19.28 |
| Guatemala                        | December-2020  |         4047232 |   17915567 |            22.59 |
| Guatemala                        | January-2021   |         4594145 |   17915567 |            25.64 |
| Guatemala                        | February-2021  |         4687392 |   17915567 |            26.16 |
| Guatemala                        | March-2021     |         5723666 |   17915567 |            31.95 |
| Guatemala                        | April-2021     |         6287226 |   17915567 |            35.09 |
| Guernsey                         | January-2021   |               0 |      67052 |                0 |
| Guernsey                         | February-2021  |               0 |      67052 |                0 |
| Guernsey                         | March-2021     |               0 |      67052 |                0 |
| Guernsey                         | April-2021     |               0 |      67052 |                0 |
| Guinea                           | March-2020     |             104 |   13132792 |                0 |
| Guinea                           | April-2020     |           15955 |   13132792 |             0.12 |
| Guinea                           | May-2020       |           80843 |   13132792 |             0.62 |
| Guinea                           | June-2020      |          139077 |   13132792 |             1.06 |
| Guinea                           | July-2020      |          196485 |   13132792 |              1.5 |
| Guinea                           | August-2020    |          261346 |   13132792 |             1.99 |
| Guinea                           | September-2020 |          303547 |   13132792 |             2.31 |
| Guinea                           | October-2020   |          350904 |   13132792 |             2.67 |
| Guinea                           | November-2020  |          379110 |   13132792 |             2.89 |
| Guinea                           | December-2020  |          417156 |   13132792 |             3.18 |
| Guinea                           | January-2021   |          437663 |   13132792 |             3.33 |
| Guinea                           | February-2021  |          422601 |   13132792 |             3.22 |
| Guinea                           | March-2021     |          558415 |   13132792 |             4.25 |
| Guinea                           | April-2021     |          637554 |   13132792 |             4.85 |
| Guinea-Bissau                    | March-2020     |              26 |    1967998 |                0 |
| Guinea-Bissau                    | April-2020     |            1515 |    1967998 |             0.08 |
| Guinea-Bissau                    | May-2020       |           26923 |    1967998 |             1.37 |
| Guinea-Bissau                    | June-2020      |           44361 |    1967998 |             2.25 |
| Guinea-Bissau                    | July-2020      |           58039 |    1967998 |             2.95 |
| Guinea-Bissau                    | August-2020    |           65237 |    1967998 |             3.31 |
| Guinea-Bissau                    | September-2020 |           68413 |    1967998 |             3.48 |
| Guinea-Bissau                    | October-2020   |           74077 |    1967998 |             3.76 |
| Guinea-Bissau                    | November-2020  |           72580 |    1967998 |             3.69 |
| Guinea-Bissau                    | December-2020  |           75812 |    1967998 |             3.85 |
| Guinea-Bissau                    | January-2021   |           77361 |    1967998 |             3.93 |
| Guinea-Bissau                    | February-2021  |           82413 |    1967998 |             4.19 |
| Guinea-Bissau                    | March-2021     |          107408 |    1967998 |             5.46 |
| Guinea-Bissau                    | April-2021     |          110920 |    1967998 |             5.64 |
| Guyana                           | March-2020     |             141 |     786559 |             0.02 |
| Guyana                           | April-2020     |            1562 |     786559 |              0.2 |
| Guyana                           | May-2020       |            3617 |     786559 |             0.46 |
| Guyana                           | June-2020      |            5398 |     786559 |             0.69 |
| Guyana                           | July-2020      |            9979 |     786559 |             1.27 |
| Guyana                           | August-2020    |           24093 |     786559 |             3.06 |
| Guyana                           | September-2020 |           61590 |     786559 |             7.83 |
| Guyana                           | October-2020   |          112427 |     786559 |            14.29 |
| Guyana                           | November-2020  |          144708 |     786559 |             18.4 |
| Guyana                           | December-2020  |          185193 |     786559 |            23.54 |
| Guyana                           | January-2021   |          213438 |     786559 |            27.14 |
| Guyana                           | February-2021  |          229334 |     786559 |            29.16 |
| Guyana                           | March-2021     |          289705 |     786559 |            36.83 |
| Guyana                           | April-2021     |          349462 |     786559 |            44.43 |
| Haiti                            | March-2020     |              84 |   11402533 |                0 |
| Haiti                            | April-2020     |            1261 |   11402533 |             0.01 |
| Haiti                            | May-2020       |           15126 |   11402533 |             0.13 |
| Haiti                            | June-2020      |          123311 |   11402533 |             1.08 |
| Haiti                            | July-2020      |          209881 |   11402533 |             1.84 |
| Haiti                            | August-2020    |          242437 |   11402533 |             2.13 |
| Haiti                            | September-2020 |          254840 |   11402533 |             2.23 |
| Haiti                            | October-2020   |          276326 |   11402533 |             2.42 |
| Haiti                            | November-2020  |          275045 |   11402533 |             2.41 |
| Haiti                            | December-2020  |          297680 |   11402533 |             2.61 |
| Haiti                            | January-2021   |          330582 |   11402533 |              2.9 |
| Haiti                            | February-2021  |          337607 |   11402533 |             2.96 |
| Haiti                            | March-2021     |          391885 |   11402533 |             3.44 |
| Haiti                            | April-2021     |          386496 |   11402533 |             3.39 |
| Honduras                         | March-2020     |             821 |    9904608 |             0.01 |
| Honduras                         | April-2020     |           13307 |    9904608 |             0.13 |
| Honduras                         | May-2020       |           86306 |    9904608 |             0.87 |
| Honduras                         | June-2020      |          317671 |    9904608 |             3.21 |
| Honduras                         | July-2020      |          975322 |    9904608 |             9.85 |
| Honduras                         | August-2020    |         1584516 |    9904608 |               16 |
| Honduras                         | September-2020 |         2074882 |    9904608 |            20.95 |
| Honduras                         | October-2020   |         2704316 |    9904608 |             27.3 |
| Honduras                         | November-2020  |         3085315 |    9904608 |            31.15 |
| Honduras                         | December-2020  |         3569628 |    9904608 |            36.04 |
| Honduras                         | January-2021   |         4149890 |    9904608 |             41.9 |
| Honduras                         | February-2021  |         4488251 |    9904608 |            45.31 |
| Honduras                         | March-2021     |         5569807 |    9904608 |            56.23 |
| Honduras                         | April-2021     |         5982916 |    9904608 |            60.41 |
| Hong Kong                        | January-2020   |               0 |    7496988 |                0 |
| Hong Kong                        | February-2020  |               0 |    7496988 |                0 |
| Hong Kong                        | March-2020     |               0 |    7496988 |                0 |
| Hong Kong                        | April-2020     |               0 |    7496988 |                0 |
| Hong Kong                        | May-2020       |               0 |    7496988 |                0 |
| Hong Kong                        | June-2020      |               0 |    7496988 |                0 |
| Hong Kong                        | July-2020      |               0 |    7496988 |                0 |
| Hong Kong                        | August-2020    |               0 |    7496988 |                0 |
| Hong Kong                        | September-2020 |               0 |    7496988 |                0 |
| Hong Kong                        | October-2020   |               0 |    7496988 |                0 |
| Hong Kong                        | November-2020  |               0 |    7496988 |                0 |
| Hong Kong                        | December-2020  |               0 |    7496988 |                0 |
| Hong Kong                        | January-2021   |               0 |    7496988 |                0 |
| Hong Kong                        | February-2021  |               0 |    7496988 |                0 |
| Hong Kong                        | March-2021     |               0 |    7496988 |                0 |
| Hong Kong                        | April-2021     |               0 |    7496988 |                0 |
| Hungary                          | March-2020     |            3512 |    9660350 |             0.04 |
| Hungary                          | April-2020     |           48858 |    9660350 |             0.51 |
| Hungary                          | May-2020       |          106717 |    9660350 |              1.1 |
| Hungary                          | June-2020      |          121673 |    9660350 |             1.26 |
| Hungary                          | July-2020      |          133397 |    9660350 |             1.38 |
| Hungary                          | August-2020    |          154696 |    9660350 |              1.6 |
| Hungary                          | September-2020 |          450339 |    9660350 |             4.66 |
| Hungary                          | October-2020   |         1426535 |    9660350 |            14.77 |
| Hungary                          | November-2020  |         4340462 |    9660350 |            44.93 |
| Hungary                          | December-2020  |         8774928 |    9660350 |            90.83 |
| Hungary                          | January-2021   |        10794651 |    9660350 |           111.74 |
| Hungary                          | February-2021  |        10954073 |    9660350 |           113.39 |
| Hungary                          | March-2021     |        16553070 |    9660350 |           171.35 |
| Hungary                          | April-2021     |        21975323 |    9660350 |           227.48 |
| Iceland                          | February-2020  |               2 |     341250 |                0 |
| Iceland                          | March-2020     |           11298 |     341250 |             3.31 |
| Iceland                          | April-2020     |           50142 |     341250 |            14.69 |
| Iceland                          | May-2020       |           55864 |     341250 |            16.37 |
| Iceland                          | June-2020      |           54362 |     341250 |            15.93 |
| Iceland                          | July-2020      |           57048 |     341250 |            16.72 |
| Iceland                          | August-2020    |           62238 |     341250 |            18.24 |
| Iceland                          | September-2020 |           69104 |     341250 |            20.25 |
| Iceland                          | October-2020   |          119128 |     341250 |            34.91 |
| Iceland                          | November-2020  |          155412 |     341250 |            45.54 |
| Iceland                          | December-2020  |          173260 |     341250 |            50.77 |
| Iceland                          | January-2021   |          183571 |     341250 |            53.79 |
| Iceland                          | February-2021  |          168952 |     341250 |            49.51 |
| Iceland                          | March-2021     |          189143 |     341250 |            55.43 |
| Iceland                          | April-2021     |          189420 |     341250 |            55.51 |
| India                            | January-2020   |               2 | 1380004385 |                0 |
| India                            | February-2020  |              84 | 1380004385 |                0 |
| India                            | March-2020     |           10252 | 1380004385 |                0 |
| India                            | April-2020     |          447607 | 1380004385 |             0.03 |
| India                            | May-2020       |         3088494 | 1380004385 |             0.22 |
| India                            | June-2020      |        10951713 | 1380004385 |             0.79 |
| India                            | July-2020      |        32829678 | 1380004385 |             2.38 |
| India                            | August-2020    |        82734792 | 1380004385 |                6 |
| India                            | September-2020 |       151735176 | 1380004385 |               11 |
| India                            | October-2020   |       228641810 | 1380004385 |            16.57 |
| India                            | November-2020  |       265835139 | 1380004385 |            19.26 |
| India                            | December-2020  |       307985456 | 1380004385 |            22.32 |
| India                            | January-2021   |       326908857 | 1380004385 |            23.69 |
| India                            | February-2021  |       305984490 | 1380004385 |            22.17 |
| India                            | March-2021     |       357487053 | 1380004385 |             25.9 |
| India                            | April-2021     |       447598593 | 1380004385 |            32.43 |
| Indonesia                        | March-2020     |           11971 |  273523621 |                0 |
| Indonesia                        | April-2020     |          164969 |  273523621 |             0.06 |
| Indonesia                        | May-2020       |          546175 |  273523621 |              0.2 |
| Indonesia                        | June-2020      |         1211857 |  273523621 |             0.44 |
| Indonesia                        | July-2020      |         2544132 |  273523621 |             0.93 |
| Indonesia                        | August-2020    |         4336124 |  273523621 |             1.59 |
| Indonesia                        | September-2020 |         6879525 |  273523621 |             2.52 |
| Indonesia                        | October-2020   |        10928941 |  273523621 |                4 |
| Indonesia                        | November-2020  |        14115752 |  273523621 |             5.16 |
| Indonesia                        | December-2020  |        19834279 |  273523621 |             7.25 |
| Indonesia                        | January-2021   |        27904068 |  273523621 |             10.2 |
| Indonesia                        | February-2021  |        34172220 |  273523621 |            12.49 |
| Indonesia                        | March-2021     |        44344084 |  273523621 |            16.21 |
| Indonesia                        | April-2021     |        47761250 |  273523621 |            17.46 |
| Iran                             | February-2020  |            1617 |   83992953 |                0 |
| Iran                             | March-2020     |          525947 |   83992953 |             0.63 |
| Iran                             | April-2020     |         2255837 |   83992953 |             2.69 |
| Iran                             | May-2020       |         3727988 |   83992953 |             4.44 |
| Iran                             | June-2020      |         5749446 |   83992953 |             6.85 |
| Iran                             | July-2020      |         8279348 |   83992953 |             9.86 |
| Iran                             | August-2020    |        10622742 |   83992953 |            12.65 |
| Iran                             | September-2020 |        12365981 |   83992953 |            14.72 |
| Iran                             | October-2020   |        16323626 |   83992953 |            19.43 |
| Iran                             | November-2020  |        23319184 |   83992953 |            27.76 |
| Iran                             | December-2020  |        34734095 |   83992953 |            41.35 |
| Iran                             | January-2021   |        41044213 |   83992953 |            48.87 |
| Iran                             | February-2021  |        42690161 |   83992953 |            50.83 |
| Iran                             | March-2021     |        54610163 |   83992953 |            65.02 |
| Iran                             | April-2021     |        65501367 |   83992953 |            77.98 |
| Iraq                             | February-2020  |              34 |   40222503 |                0 |
| Iraq                             | March-2020     |            6335 |   40222503 |             0.02 |
| Iraq                             | April-2020     |           42494 |   40222503 |             0.11 |
| Iraq                             | May-2020       |          112314 |   40222503 |             0.28 |
| Iraq                             | June-2020      |          731904 |   40222503 |             1.82 |
| Iraq                             | July-2020      |         2680051 |   40222503 |             6.66 |
| Iraq                             | August-2020    |         5516538 |   40222503 |            13.72 |
| Iraq                             | September-2020 |         9025163 |   40222503 |            22.44 |
| Iraq                             | October-2020   |        13048781 |   40222503 |            32.44 |
| Iraq                             | November-2020  |        15543204 |   40222503 |            38.64 |
| Iraq                             | December-2020  |        17911961 |   40222503 |            44.53 |
| Iraq                             | January-2021   |        18838341 |   40222503 |            46.84 |
| Iraq                             | February-2021  |        18220943 |   40222503 |             45.3 |
| Iraq                             | March-2021     |        23904513 |   40222503 |            59.43 |
| Iraq                             | April-2021     |        28798758 |   40222503 |             71.6 |
| Ireland                          | February-2020  |               1 |    4937796 |                0 |
| Ireland                          | March-2020     |           23308 |    4937796 |             0.47 |
| Ireland                          | April-2020     |          365860 |    4937796 |             7.41 |
| Ireland                          | May-2020       |          730677 |    4937796 |             14.8 |
| Ireland                          | June-2020      |          758939 |    4937796 |            15.37 |
| Ireland                          | July-2020      |          797096 |    4937796 |            16.14 |
| Ireland                          | August-2020    |          847681 |    4937796 |            17.17 |
| Ireland                          | September-2020 |          958194 |    4937796 |            19.41 |
| Ireland                          | October-2020   |         1495470 |    4937796 |            30.29 |
| Ireland                          | November-2020  |         2035798 |    4937796 |            41.23 |
| Ireland                          | December-2020  |         2451763 |    4937796 |            49.65 |
| Ireland                          | January-2021   |         4945372 |    4937796 |           100.15 |
| Ireland                          | February-2021  |         5864137 |    4937796 |           118.76 |
| Ireland                          | March-2021     |         7065554 |    4937796 |           143.09 |
| Ireland                          | April-2021     |         7281321 |    4937796 |           147.46 |
| Isle of Man                      | January-2021   |               0 |      85032 |                0 |
| Isle of Man                      | February-2021  |               0 |      85032 |                0 |
| Isle of Man                      | March-2021     |               0 |      85032 |                0 |
| Isle of Man                      | April-2021     |               0 |      85032 |                0 |
| Israel                           | February-2020  |              22 |    8655541 |                0 |
| Israel                           | March-2020     |           35287 |    8655541 |             0.41 |
| Israel                           | April-2020     |          367312 |    8655541 |             4.24 |
| Israel                           | May-2020       |          512036 |    8655541 |             5.92 |
| Israel                           | June-2020      |          602486 |    8655541 |             6.96 |
| Israel                           | July-2020      |         1460503 |    8655541 |            16.87 |
| Israel                           | August-2020    |         2916651 |    8655541 |             33.7 |
| Israel                           | September-2020 |         5221620 |    8655541 |            60.33 |
| Israel                           | October-2020   |         9176583 |    8655541 |           106.02 |
| Israel                           | November-2020  |         9755418 |    8655541 |           112.71 |
| Israel                           | December-2020  |        11475028 |    8655541 |           132.57 |
| Israel                           | January-2021   |        16729422 |    8655541 |           193.28 |
| Israel                           | February-2021  |        20255490 |    8655541 |           234.02 |
| Israel                           | March-2021     |        25324771 |    8655541 |           292.58 |
| Israel                           | April-2021     |        25095274 |    8655541 |           289.93 |
| Italy                            | January-2020   |               2 |   60461828 |                0 |
| Italy                            | February-2020  |            3966 |   60461828 |             0.01 |
| Italy                            | March-2020     |         1209772 |   60461828 |                2 |
| Italy                            | April-2020     |         4928524 |   60461828 |             8.15 |
| Italy                            | May-2020       |         6914863 |   60461828 |            11.44 |
| Italy                            | June-2020      |         7115232 |   60461828 |            11.77 |
| Italy                            | July-2020      |         7560745 |   60461828 |             12.5 |
| Italy                            | August-2020    |         7919622 |   60461828 |             13.1 |
| Italy                            | September-2020 |         8749361 |   60461828 |            14.47 |
| Italy                            | October-2020   |        13281216 |   60461828 |            21.97 |
| Italy                            | November-2020  |        35324374 |   60461828 |            58.42 |
| Italy                            | December-2020  |        58293082 |   60461828 |            96.41 |
| Italy                            | January-2021   |        72917277 |   60461828 |            120.6 |
| Italy                            | February-2021  |        76429829 |   60461828 |           126.41 |
| Italy                            | March-2021     |       101162913 |   60461828 |           167.32 |
| Italy                            | April-2021     |       114799462 |   60461828 |           189.87 |
| Jamaica                          | March-2020     |             382 |    2961161 |             0.01 |
| Jamaica                          | April-2020     |            5011 |    2961161 |             0.17 |
| Jamaica                          | May-2020       |           16083 |    2961161 |             0.54 |
| Jamaica                          | June-2020      |           19058 |    2961161 |             0.64 |
| Jamaica                          | July-2020      |           24311 |    2961161 |             0.82 |
| Jamaica                          | August-2020    |           40928 |    2961161 |             1.38 |
| Jamaica                          | September-2020 |          130368 |    2961161 |              4.4 |
| Jamaica                          | October-2020   |          247729 |    2961161 |             8.37 |
| Jamaica                          | November-2020  |          297709 |    2961161 |            10.05 |
| Jamaica                          | December-2020  |          368482 |    2961161 |            12.44 |
| Jamaica                          | January-2021   |          439391 |    2961161 |            14.84 |
| Jamaica                          | February-2021  |          540682 |    2961161 |            18.26 |
| Jamaica                          | March-2021     |          982732 |    2961161 |            33.19 |
| Jamaica                          | April-2021     |         1293840 |    2961161 |            43.69 |
| Japan                            | January-2020   |              56 |  126476458 |                0 |
| Japan                            | February-2020  |            2418 |  126476458 |                0 |
| Japan                            | March-2020     |           29049 |  126476458 |             0.02 |
| Japan                            | April-2020     |          264160 |  126476458 |             0.21 |
| Japan                            | May-2020       |          496484 |  126476458 |             0.39 |
| Japan                            | June-2020      |          525609 |  126476458 |             0.42 |
| Japan                            | July-2020      |          771595 |  126476458 |             0.61 |
| Japan                            | August-2020    |         1701916 |  126476458 |             1.35 |
| Japan                            | September-2020 |         2297182 |  126476458 |             1.82 |
| Japan                            | October-2020   |         2856221 |  126476458 |             2.26 |
| Japan                            | November-2020  |         3650314 |  126476458 |             2.89 |
| Japan                            | December-2020  |         5880523 |  126476458 |             4.65 |
| Japan                            | January-2021   |         9902662 |  126476458 |             7.83 |
| Japan                            | February-2021  |        11627561 |  126476458 |             9.19 |
| Japan                            | March-2021     |        13976951 |  126476458 |            11.05 |
| Japan                            | April-2021     |        15835437 |  126476458 |            12.52 |
| Jersey                           | January-2021   |               0 |     101073 |                0 |
| Jersey                           | February-2021  |               0 |     101073 |                0 |
| Jersey                           | March-2021     |               0 |     101073 |                0 |
| Jersey                           | April-2021     |               0 |     101073 |                0 |
| Jordan                           | March-2020     |            2421 |   10203140 |             0.02 |
| Jordan                           | April-2020     |           11816 |   10203140 |             0.12 |
| Jordan                           | May-2020       |           18801 |   10203140 |             0.18 |
| Jordan                           | June-2020      |           28514 |   10203140 |             0.28 |
| Jordan                           | July-2020      |           36345 |   10203140 |             0.36 |
| Jordan                           | August-2020    |           45488 |   10203140 |             0.45 |
| Jordan                           | September-2020 |          140406 |   10203140 |             1.38 |
| Jordan                           | October-2020   |         1138829 |   10203140 |            11.16 |
| Jordan                           | November-2020  |         4471920 |   10203140 |            43.83 |
| Jordan                           | December-2020  |         8196380 |   10203140 |            80.33 |
| Jordan                           | January-2021   |         9694303 |   10203140 |            95.01 |
| Jordan                           | February-2021  |         9868118 |   10203140 |            96.72 |
| Jordan                           | March-2021     |        15461791 |   10203140 |           151.54 |
| Jordan                           | April-2021     |        20243727 |   10203140 |           198.41 |
| Kazakhstan                       | March-2020     |            1937 |   18776707 |             0.01 |
| Kazakhstan                       | April-2020     |           46219 |   18776707 |             0.25 |
| Kazakhstan                       | May-2020       |          202761 |   18776707 |             1.08 |
| Kazakhstan                       | June-2020      |          476607 |   18776707 |             2.54 |
| Kazakhstan                       | July-2020      |         2056485 |   18776707 |            10.95 |
| Kazakhstan                       | August-2020    |         3642536 |   18776707 |             19.4 |
| Kazakhstan                       | September-2020 |         4099504 |   18776707 |            21.83 |
| Kazakhstan                       | October-2020   |         4489708 |   18776707 |            23.91 |
| Kazakhstan                       | November-2020  |         4848928 |   18776707 |            25.82 |
| Kazakhstan                       | December-2020  |         5844830 |   18776707 |            31.13 |
| Kazakhstan                       | January-2021   |         6716862 |   18776707 |            35.77 |
| Kazakhstan                       | February-2021  |         7028707 |   18776707 |            37.43 |
| Kazakhstan                       | March-2021     |         8618791 |   18776707 |             45.9 |
| Kazakhstan                       | April-2021     |        10069664 |   18776707 |            53.63 |
| Kenya                            | March-2020     |             370 |   53771300 |                0 |
| Kenya                            | April-2020     |            7263 |   53771300 |             0.01 |
| Kenya                            | May-2020       |           29773 |   53771300 |             0.06 |
| Kenya                            | June-2020      |          118824 |   53771300 |             0.22 |
| Kenya                            | July-2020      |          386628 |   53771300 |             0.72 |
| Kenya                            | August-2020    |          902573 |   53771300 |             1.68 |
| Kenya                            | September-2020 |         1091882 |   53771300 |             2.03 |
| Kenya                            | October-2020   |         1385303 |   53771300 |             2.58 |
| Kenya                            | November-2020  |         2106033 |   53771300 |             3.92 |
| Kenya                            | December-2020  |         2856847 |   53771300 |             5.31 |
| Kenya                            | January-2021   |         3065046 |   53771300 |              5.7 |
| Kenya                            | February-2021  |         2887159 |   53771300 |             5.37 |
| Kenya                            | March-2021     |         3634398 |   53771300 |             6.76 |
| Kenya                            | April-2021     |         4463081 |   53771300 |              8.3 |
| Kosovo                           | March-2020     |             844 |    1932774 |             0.04 |
| Kosovo                           | April-2020     |           12732 |    1932774 |             0.66 |
| Kosovo                           | May-2020       |           29343 |    1932774 |             1.52 |
| Kosovo                           | June-2020      |           51853 |    1932774 |             2.68 |
| Kosovo                           | July-2020      |          166431 |    1932774 |             8.61 |
| Kosovo                           | August-2020    |          349836 |    1932774 |             18.1 |
| Kosovo                           | September-2020 |          442311 |    1932774 |            22.88 |
| Kosovo                           | October-2020   |          524640 |    1932774 |            27.14 |
| Kosovo                           | November-2020  |          883320 |    1932774 |             45.7 |
| Kosovo                           | December-2020  |         1447730 |    1932774 |             74.9 |
| Kosovo                           | January-2021   |         1720254 |    1932774 |               89 |
| Kosovo                           | February-2021  |         1801727 |    1932774 |            93.22 |
| Kosovo                           | March-2021     |         2424115 |    1932774 |           125.42 |
| Kosovo                           | April-2021     |         2957297 |    1932774 |           153.01 |
| Kuwait                           | February-2020  |             171 |    4270563 |                0 |
| Kuwait                           | March-2020     |            4154 |    4270563 |              0.1 |
| Kuwait                           | April-2020     |           51368 |    4270563 |              1.2 |
| Kuwait                           | May-2020       |          445816 |    4270563 |            10.44 |
| Kuwait                           | June-2020      |         1106772 |    4270563 |            25.92 |
| Kuwait                           | July-2020      |         1776417 |    4270563 |             41.6 |
| Kuwait                           | August-2020    |         2362626 |    4270563 |            55.32 |
| Kuwait                           | September-2020 |         2885759 |    4270563 |            67.57 |
| Kuwait                           | October-2020   |         3569876 |    4270563 |            83.59 |
| Kuwait                           | November-2020  |         4082135 |    4270563 |            95.59 |
| Kuwait                           | December-2020  |         4554849 |    4270563 |           106.66 |
| Kuwait                           | January-2021   |         4881830 |    4270563 |           114.31 |
| Kuwait                           | February-2021  |         4988724 |    4270563 |           116.82 |
| Kuwait                           | March-2021     |         6584268 |    4270563 |           154.18 |
| Kuwait                           | April-2021     |         7607062 |    4270563 |           178.13 |
| Kyrgyzstan                       | March-2020     |             587 |    6524191 |             0.01 |
| Kyrgyzstan                       | April-2020     |           13260 |    6524191 |              0.2 |
| Kyrgyzstan                       | May-2020       |           36450 |    6524191 |             0.56 |
| Kyrgyzstan                       | June-2020      |           87845 |    6524191 |             1.35 |
| Kyrgyzstan                       | July-2020      |          597522 |    6524191 |             9.16 |
| Kyrgyzstan                       | August-2020    |         1276140 |    6524191 |            19.56 |
| Kyrgyzstan                       | September-2020 |         1354021 |    6524191 |            20.75 |
| Kyrgyzstan                       | October-2020   |         1605533 |    6524191 |            24.61 |
| Kyrgyzstan                       | November-2020  |         1994975 |    6524191 |            30.58 |
| Kyrgyzstan                       | December-2020  |         2411196 |    6524191 |            36.96 |
| Kyrgyzstan                       | January-2021   |         2571550 |    6524191 |            39.42 |
| Kyrgyzstan                       | February-2021  |         2393821 |    6524191 |            36.69 |
| Kyrgyzstan                       | March-2021     |         2701863 |    6524191 |            41.41 |
| Kyrgyzstan                       | April-2021     |         2744413 |    6524191 |            42.07 |
| Laos                             | March-2020     |              50 |    7275556 |                0 |
| Laos                             | April-2020     |             503 |    7275556 |             0.01 |
| Laos                             | May-2020       |             589 |    7275556 |             0.01 |
| Laos                             | June-2020      |             570 |    7275556 |             0.01 |
| Laos                             | July-2020      |             597 |    7275556 |             0.01 |
| Laos                             | August-2020    |             656 |    7275556 |             0.01 |
| Laos                             | September-2020 |             680 |    7275556 |             0.01 |
| Laos                             | October-2020   |             724 |    7275556 |             0.01 |
| Laos                             | November-2020  |             846 |    7275556 |             0.01 |
| Laos                             | December-2020  |            1259 |    7275556 |             0.02 |
| Laos                             | January-2021   |            1292 |    7275556 |             0.02 |
| Laos                             | February-2021  |            1258 |    7275556 |             0.02 |
| Laos                             | March-2021     |            1485 |    7275556 |             0.02 |
| Laos                             | April-2021     |            4930 |    7275556 |             0.07 |
| Latvia                           | February-2020  |               0 |    1886202 |                0 |
| Latvia                           | March-2020     |            3277 |    1886202 |             0.17 |
| Latvia                           | April-2020     |           20149 |    1886202 |             1.07 |
| Latvia                           | May-2020       |           30402 |    1886202 |             1.61 |
| Latvia                           | June-2020      |           32971 |    1886202 |             1.75 |
| Latvia                           | July-2020      |           36487 |    1886202 |             1.93 |
| Latvia                           | August-2020    |           40754 |    1886202 |             2.16 |
| Latvia                           | September-2020 |           45572 |    1886202 |             2.42 |
| Latvia                           | October-2020   |          106264 |    1886202 |             5.63 |
| Latvia                           | November-2020  |          326976 |    1886202 |            17.34 |
| Latvia                           | December-2020  |          875710 |    1886202 |            46.43 |
| Latvia                           | January-2021   |         1678918 |    1886202 |            89.01 |
| Latvia                           | February-2021  |         2151827 |    1886202 |           114.08 |
| Latvia                           | March-2021     |         2937772 |    1886202 |           155.75 |
| Latvia                           | April-2021     |         3303437 |    1886202 |           175.14 |
| Lebanon                          | February-2020  |              15 |    6825442 |                0 |
| Lebanon                          | March-2020     |            5177 |    6825442 |             0.08 |
| Lebanon                          | April-2020     |           18944 |    6825442 |             0.28 |
| Lebanon                          | May-2020       |           29199 |    6825442 |             0.43 |
| Lebanon                          | June-2020      |           44582 |    6825442 |             0.65 |
| Lebanon                          | July-2020      |           85807 |    6825442 |             1.26 |
| Lebanon                          | August-2020    |          302900 |    6825442 |             4.44 |
| Lebanon                          | September-2020 |          807478 |    6825442 |            11.83 |
| Lebanon                          | October-2020   |         1859410 |    6825442 |            27.24 |
| Lebanon                          | November-2020  |         3175672 |    6825442 |            46.53 |
| Lebanon                          | December-2020  |         4730285 |    6825442 |             69.3 |
| Lebanon                          | January-2021   |         7586618 |    6825442 |           111.15 |
| Lebanon                          | February-2021  |         9501209 |    6825442 |            139.2 |
| Lebanon                          | March-2021     |        13134891 |    6825442 |           192.44 |
| Lebanon                          | April-2021     |        15091550 |    6825442 |           221.11 |
| Lesotho                          | May-2020       |              29 |    2142252 |                0 |
| Lesotho                          | June-2020      |             272 |    2142252 |             0.01 |
| Lesotho                          | July-2020      |            8782 |    2142252 |             0.41 |
| Lesotho                          | August-2020    |           27809 |    2142252 |              1.3 |
| Lesotho                          | September-2020 |           39807 |    2142252 |             1.86 |
| Lesotho                          | October-2020   |           56894 |    2142252 |             2.66 |
| Lesotho                          | November-2020  |           61138 |    2142252 |             2.85 |
| Lesotho                          | December-2020  |           76083 |    2142252 |             3.55 |
| Lesotho                          | January-2021   |          194193 |    2142252 |             9.06 |
| Lesotho                          | February-2021  |          278256 |    2142252 |            12.99 |
| Lesotho                          | March-2021     |          327749 |    2142252 |             15.3 |
| Lesotho                          | April-2021     |          321443 |    2142252 |               15 |
| Liberia                          | March-2020     |              41 |    5057677 |                0 |
| Liberia                          | April-2020     |            2056 |    5057677 |             0.04 |
| Liberia                          | May-2020       |            6898 |    5057677 |             0.14 |
| Liberia                          | June-2020      |           15416 |    5057677 |              0.3 |
| Liberia                          | July-2020      |           32087 |    5057677 |             0.63 |
| Liberia                          | August-2020    |           39105 |    5057677 |             0.77 |
| Liberia                          | September-2020 |           39742 |    5057677 |             0.79 |
| Liberia                          | October-2020   |           42758 |    5057677 |             0.85 |
| Liberia                          | November-2020  |           45235 |    5057677 |             0.89 |
| Liberia                          | December-2020  |           53423 |    5057677 |             1.06 |
| Liberia                          | January-2021   |           57740 |    5057677 |             1.14 |
| Liberia                          | February-2021  |           55281 |    5057677 |             1.09 |
| Liberia                          | March-2021     |           63015 |    5057677 |             1.25 |
| Liberia                          | April-2021     |           61806 |    5057677 |             1.22 |
| Libya                            | March-2020     |              33 |    6871287 |                0 |
| Libya                            | April-2020     |            1180 |    6871287 |             0.02 |
| Libya                            | May-2020       |            2340 |    6871287 |             0.03 |
| Libya                            | June-2020      |           14275 |    6871287 |             0.21 |
| Libya                            | July-2020      |           57791 |    6871287 |             0.84 |
| Libya                            | August-2020    |          257246 |    6871287 |             3.74 |
| Libya                            | September-2020 |          739939 |    6871287 |            10.77 |
| Libya                            | October-2020   |         1475402 |    6871287 |            21.47 |
| Libya                            | November-2020  |         2198676 |    6871287 |               32 |
| Libya                            | December-2020  |         2861262 |    6871287 |            41.64 |
| Libya                            | January-2021   |         3375585 |    6871287 |            49.13 |
| Libya                            | February-2021  |         3560392 |    6871287 |            51.82 |
| Libya                            | March-2021     |         4553941 |    6871287 |            66.27 |
| Libya                            | April-2021     |         5099709 |    6871287 |            74.22 |
| Liechtenstein                    | March-2020     |             694 |      38137 |             1.82 |
| Liechtenstein                    | April-2020     |            2372 |      38137 |             6.22 |
| Liechtenstein                    | May-2020       |            2542 |      38137 |             6.67 |
| Liechtenstein                    | June-2020      |            2460 |      38137 |             6.45 |
| Liechtenstein                    | July-2020      |            2634 |      38137 |             6.91 |
| Liechtenstein                    | August-2020    |            2952 |      38137 |             7.74 |
| Liechtenstein                    | September-2020 |            3352 |      38137 |             8.79 |
| Liechtenstein                    | October-2020   |            7561 |      38137 |            19.83 |
| Liechtenstein                    | November-2020  |           28878 |      38137 |            75.72 |
| Liechtenstein                    | December-2020  |           51462 |      38137 |           134.94 |
| Liechtenstein                    | January-2021   |           73484 |      38137 |           192.68 |
| Liechtenstein                    | February-2021  |           71015 |      38137 |           186.21 |
| Liechtenstein                    | March-2021     |           81102 |      38137 |           212.66 |
| Liechtenstein                    | April-2021     |           83726 |      38137 |           219.54 |
| Lithuania                        | February-2020  |               1 |    2722291 |                0 |
| Lithuania                        | March-2020     |            3022 |    2722291 |             0.11 |
| Lithuania                        | April-2020     |           30598 |    2722291 |             1.12 |
| Lithuania                        | May-2020       |           47420 |    2722291 |             1.74 |
| Lithuania                        | June-2020      |           52692 |    2722291 |             1.94 |
| Lithuania                        | July-2020      |           59304 |    2722291 |             2.18 |
| Lithuania                        | August-2020    |           75618 |    2722291 |             2.78 |
| Lithuania                        | September-2020 |          107305 |    2722291 |             3.94 |
| Lithuania                        | October-2020   |          244755 |    2722291 |             8.99 |
| Lithuania                        | November-2020  |         1090304 |    2722291 |            40.05 |
| Lithuania                        | December-2020  |         3142080 |    2722291 |           115.42 |
| Lithuania                        | January-2021   |         5173306 |    2722291 |           190.04 |
| Lithuania                        | February-2021  |         5336974 |    2722291 |           196.05 |
| Lithuania                        | March-2021     |         6413345 |    2722291 |           235.59 |
| Lithuania                        | April-2021     |         6935557 |    2722291 |           254.77 |
| Luxembourg                       | February-2020  |               1 |     625976 |                0 |
| Luxembourg                       | March-2020     |           17209 |     625976 |             2.75 |
| Luxembourg                       | April-2020     |           99317 |     625976 |            15.87 |
| Luxembourg                       | May-2020       |          121711 |     625976 |            19.44 |
| Luxembourg                       | June-2020      |          122950 |     625976 |            19.64 |
| Luxembourg                       | July-2020      |          166386 |     625976 |            26.58 |
| Luxembourg                       | August-2020    |          225779 |     625976 |            36.07 |
| Luxembourg                       | September-2020 |          225144 |     625976 |            35.97 |
| Luxembourg                       | October-2020   |          351609 |     625976 |            56.17 |
| Luxembourg                       | November-2020  |          800948 |     625976 |           127.95 |
| Luxembourg                       | December-2020  |         1297802 |     625976 |           207.32 |
| Luxembourg                       | January-2021   |         1506358 |     625976 |           240.64 |
| Luxembourg                       | February-2021  |         1482434 |     625976 |           236.82 |
| Luxembourg                       | March-2021     |         1807017 |     625976 |           288.67 |
| Luxembourg                       | April-2021     |         1934308 |     625976 |           309.01 |
| Macao                            | February-2021  |               0 |     649342 |                0 |
| Macao                            | March-2021     |               0 |     649342 |                0 |
| Macao                            | April-2021     |               0 |     649342 |                0 |
| Madagascar                       | March-2020     |             271 |   27691019 |                0 |
| Madagascar                       | April-2020     |            3143 |   27691019 |             0.01 |
| Madagascar                       | May-2020       |           10795 |   27691019 |             0.04 |
| Madagascar                       | June-2020      |           42217 |   27691019 |             0.15 |
| Madagascar                       | July-2020      |          192907 |   27691019 |              0.7 |
| Madagascar                       | August-2020    |          420613 |   27691019 |             1.52 |
| Madagascar                       | September-2020 |          473830 |   27691019 |             1.71 |
| Madagascar                       | October-2020   |          519886 |   27691019 |             1.88 |
| Madagascar                       | November-2020  |          517577 |   27691019 |             1.87 |
| Madagascar                       | December-2020  |          544372 |   27691019 |             1.97 |
| Madagascar                       | January-2021   |          564230 |   27691019 |             2.04 |
| Madagascar                       | February-2021  |          545744 |   27691019 |             1.97 |
| Madagascar                       | March-2021     |          671004 |   27691019 |             2.42 |
| Madagascar                       | April-2021     |          920949 |   27691019 |             3.33 |
| Malawi                           | March-2020     |               0 |   19129955 |                0 |
| Malawi                           | April-2020     |             528 |   19129955 |                0 |
| Malawi                           | May-2020       |            2747 |   19129955 |             0.01 |
| Malawi                           | June-2020      |           19374 |   19129955 |              0.1 |
| Malawi                           | July-2020      |           82400 |   19129955 |             0.43 |
| Malawi                           | August-2020    |          154885 |   19129955 |             0.81 |
| Malawi                           | September-2020 |          170733 |   19129955 |             0.89 |
| Malawi                           | October-2020   |          181240 |   19129955 |             0.95 |
| Malawi                           | November-2020  |          179342 |   19129955 |             0.94 |
| Malawi                           | December-2020  |          191330 |   19129955 |                1 |
| Malawi                           | January-2021   |          415229 |   19129955 |             2.17 |
| Malawi                           | February-2021  |          808919 |   19129955 |             4.23 |
| Malawi                           | March-2021     |         1020068 |   19129955 |             5.33 |
| Malawi                           | April-2021     |         1016210 |   19129955 |             5.31 |
| Malaysia                         | January-2020   |              38 |   32365998 |                0 |
| Malaysia                         | February-2020  |             529 |   32365998 |                0 |
| Malaysia                         | March-2020     |           27636 |   32365998 |             0.09 |
| Malaysia                         | April-2020     |          145040 |   32365998 |             0.45 |
| Malaysia                         | May-2020       |          214779 |   32365998 |             0.66 |
| Malaysia                         | June-2020      |          252725 |   32365998 |             0.78 |
| Malaysia                         | July-2020      |          271966 |   32365998 |             0.84 |
| Malaysia                         | August-2020    |          284350 |   32365998 |             0.88 |
| Malaysia                         | September-2020 |          302097 |   32365998 |             0.93 |
| Malaysia                         | October-2020   |          621112 |   32365998 |             1.92 |
| Malaysia                         | November-2020  |         1451172 |   32365998 |             4.48 |
| Malaysia                         | December-2020  |         2734703 |   32365998 |             8.45 |
| Malaysia                         | January-2021   |         4894111 |   32365998 |            15.12 |
| Malaysia                         | February-2021  |         7379863 |   32365998 |             22.8 |
| Malaysia                         | March-2021     |        10091945 |   32365998 |            31.18 |
| Malaysia                         | April-2021     |        11169973 |   32365998 |            34.51 |
| Maldives                         | March-2020     |             289 |     540542 |             0.05 |
| Maldives                         | April-2020     |            2519 |     540542 |             0.47 |
| Maldives                         | May-2020       |           32674 |     540542 |             6.04 |
| Maldives                         | June-2020      |           62485 |     540542 |            11.56 |
| Maldives                         | July-2020      |           90220 |     540542 |            16.69 |
| Maldives                         | August-2020    |          182727 |     540542 |             33.8 |
| Maldives                         | September-2020 |          278856 |     540542 |            51.59 |
| Maldives                         | October-2020   |          343649 |     540542 |            63.57 |
| Maldives                         | November-2020  |          369915 |     540542 |            68.43 |
| Maldives                         | December-2020  |          415623 |     540542 |            76.89 |
| Maldives                         | January-2021   |          451616 |     540542 |            83.55 |
| Maldives                         | February-2021  |          500324 |     540542 |            92.56 |
| Maldives                         | March-2021     |          679662 |     540542 |           125.74 |
| Maldives                         | April-2021     |          792272 |     540542 |           146.57 |
| Mali                             | March-2020     |             106 |   20250834 |                0 |
| Mali                             | April-2020     |            5898 |   20250834 |             0.03 |
| Mali                             | May-2020       |           26486 |   20250834 |             0.13 |
| Mali                             | June-2020      |           53905 |   20250834 |             0.27 |
| Mali                             | July-2020      |           75197 |   20250834 |             0.37 |
| Mali                             | August-2020    |           81775 |   20250834 |              0.4 |
| Mali                             | September-2020 |           88671 |   20250834 |             0.44 |
| Mali                             | October-2020   |          104007 |   20250834 |             0.51 |
| Mali                             | November-2020  |          120596 |   20250834 |              0.6 |
| Mali                             | December-2020  |          183402 |   20250834 |             0.91 |
| Mali                             | January-2021   |          239845 |   20250834 |             1.18 |
| Mali                             | February-2021  |          230661 |   20250834 |             1.14 |
| Mali                             | March-2021     |          282009 |   20250834 |             1.39 |
| Mali                             | April-2021     |          370821 |   20250834 |             1.83 |
| Malta                            | February-2020  |               0 |     441539 |                0 |
| Malta                            | March-2020     |            1707 |     441539 |             0.39 |
| Malta                            | April-2020     |           11099 |     441539 |             2.51 |
| Malta                            | May-2020       |           16920 |     441539 |             3.83 |
| Malta                            | June-2020      |           19477 |     441539 |             4.41 |
| Malta                            | July-2020      |           21346 |     441539 |             4.83 |
| Malta                            | August-2020    |           41914 |     441539 |             9.49 |
| Malta                            | September-2020 |           74643 |     441539 |            16.91 |
| Malta                            | October-2020   |          137553 |     441539 |            31.15 |
| Malta                            | November-2020  |          242409 |     441539 |             54.9 |
| Malta                            | December-2020  |          352991 |     441539 |            79.95 |
| Malta                            | January-2021   |          476588 |     441539 |           107.94 |
| Malta                            | February-2021  |          559054 |     441539 |           126.61 |
| Malta                            | March-2021     |          823697 |     441539 |           186.55 |
| Malta                            | April-2021     |          893451 |     441539 |           202.35 |
| Marshall Islands                 | October-2020   |               8 |      59194 |             0.01 |
| Marshall Islands                 | November-2020  |              76 |      59194 |             0.13 |
| Marshall Islands                 | December-2020  |             124 |      59194 |             0.21 |
| Marshall Islands                 | January-2021   |             124 |      59194 |             0.21 |
| Marshall Islands                 | February-2021  |             112 |      59194 |             0.19 |
| Marshall Islands                 | March-2021     |             124 |      59194 |             0.21 |
| Marshall Islands                 | April-2021     |             120 |      59194 |              0.2 |
| Mauritania                       | March-2020     |              46 |    4649660 |                0 |
| Mauritania                       | April-2020     |             204 |    4649660 |                0 |
| Mauritania                       | May-2020       |            4057 |    4649660 |             0.09 |
| Mauritania                       | June-2020      |           67050 |    4649660 |             1.44 |
| Mauritania                       | July-2020      |          172865 |    4649660 |             3.72 |
| Mauritania                       | August-2020    |          208217 |    4649660 |             4.48 |
| Mauritania                       | September-2020 |          219109 |    4649660 |             4.71 |
| Mauritania                       | October-2020   |          235602 |    4649660 |             5.07 |
| Mauritania                       | November-2020  |          240629 |    4649660 |             5.18 |
| Mauritania                       | December-2020  |          357674 |    4649660 |             7.69 |
| Mauritania                       | January-2021   |          491063 |    4649660 |            10.56 |
| Mauritania                       | February-2021  |          475129 |    4649660 |            10.22 |
| Mauritania                       | March-2021     |          542837 |    4649660 |            11.67 |
| Mauritania                       | April-2021     |          543196 |    4649660 |            11.68 |
| Mauritius                        | March-2020     |             841 |    1271767 |             0.07 |
| Mauritius                        | April-2020     |            8914 |    1271767 |              0.7 |
| Mauritius                        | May-2020       |           10311 |    1271767 |             0.81 |
| Mauritius                        | June-2020      |           10136 |    1271767 |              0.8 |
| Mauritius                        | July-2020      |           10622 |    1271767 |             0.84 |
| Mauritius                        | August-2020    |           10750 |    1271767 |             0.85 |
| Mauritius                        | September-2020 |           10896 |    1271767 |             0.86 |
| Mauritius                        | October-2020   |           12802 |    1271767 |             1.01 |
| Mauritius                        | November-2020  |           14299 |    1271767 |             1.12 |
| Mauritius                        | December-2020  |           16106 |    1271767 |             1.27 |
| Mauritius                        | January-2021   |           17037 |    1271767 |             1.34 |
| Mauritius                        | February-2021  |           16729 |    1271767 |             1.32 |
| Mauritius                        | March-2021     |           23585 |    1271767 |             1.85 |
| Mauritius                        | April-2021     |           35374 |    1271767 |             2.78 |
| Mexico                           | January-2020   |               0 |  128932753 |                0 |
| Mexico                           | February-2020  |               5 |  128932753 |                0 |
| Mexico                           | March-2020     |            8124 |  128932753 |             0.01 |
| Mexico                           | April-2020     |          229514 |  128932753 |             0.18 |
| Mexico                           | May-2020       |         1560343 |  128932753 |             1.21 |
| Mexico                           | June-2020      |         4692440 |  128932753 |             3.64 |
| Mexico                           | July-2020      |        10107738 |  128932753 |             7.84 |
| Mexico                           | August-2020    |        16108026 |  128932753 |            12.49 |
| Mexico                           | September-2020 |        20309152 |  128932753 |            15.75 |
| Mexico                           | October-2020   |        26077771 |  128932753 |            20.23 |
| Mexico                           | November-2020  |        30342144 |  128932753 |            23.53 |
| Mexico                           | December-2020  |        39586956 |  128932753 |             30.7 |
| Mexico                           | January-2021   |        50652332 |  128932753 |            39.29 |
| Mexico                           | February-2021  |        55678011 |  128932753 |            43.18 |
| Mexico                           | March-2021     |        67295623 |  128932753 |            52.19 |
| Mexico                           | April-2021     |        68840861 |  128932753 |            53.39 |
| Micronesia (country)             | January-2021   |              11 |     115021 |             0.01 |
| Micronesia (country)             | February-2021  |              28 |     115021 |             0.02 |
| Micronesia (country)             | March-2021     |              31 |     115021 |             0.03 |
| Micronesia (country)             | April-2021     |              30 |     115021 |             0.03 |
| Moldova                          | March-2020     |            2328 |    4033963 |             0.06 |
| Moldova                          | April-2020     |           62717 |    4033963 |             1.55 |
| Moldova                          | May-2020       |          183842 |    4033963 |             4.56 |
| Moldova                          | June-2020      |          370715 |    4033963 |             9.19 |
| Moldova                          | July-2020      |          633899 |    4033963 |            15.71 |
| Moldova                          | August-2020    |          948327 |    4033963 |            23.51 |
| Moldova                          | September-2020 |         1336462 |    4033963 |            33.13 |
| Moldova                          | October-2020   |         2024123 |    4033963 |            50.18 |
| Moldova                          | November-2020  |         2719636 |    4033963 |            67.42 |
| Moldova                          | December-2020  |         4002186 |    4033963 |            99.21 |
| Moldova                          | January-2021   |         4724038 |    4033963 |           117.11 |
| Moldova                          | February-2021  |         4799569 |    4033963 |           118.98 |
| Moldova                          | March-2021     |         6450183 |    4033963 |            159.9 |
| Moldova                          | April-2021     |         7299198 |    4033963 |           180.94 |
| Monaco                           | February-2020  |               1 |      39244 |                0 |
| Monaco                           | March-2020     |             433 |      39244 |              1.1 |
| Monaco                           | April-2020     |            2606 |      39244 |             6.64 |
| Monaco                           | May-2020       |            2993 |      39244 |             7.63 |
| Monaco                           | June-2020      |            3000 |      39244 |             7.64 |
| Monaco                           | July-2020      |            3437 |      39244 |             8.76 |
| Monaco                           | August-2020    |            4408 |      39244 |            11.23 |
| Monaco                           | September-2020 |            5389 |      39244 |            13.73 |
| Monaco                           | October-2020   |            8263 |      39244 |            21.06 |
| Monaco                           | November-2020  |           15872 |      39244 |            40.44 |
| Monaco                           | December-2020  |           22056 |      39244 |             56.2 |
| Monaco                           | January-2021   |           36725 |      39244 |            93.58 |
| Monaco                           | February-2021  |           49492 |      39244 |           126.11 |
| Monaco                           | March-2021     |           65951 |      39244 |           168.05 |
| Monaco                           | April-2021     |           71688 |      39244 |           182.67 |
| Mongolia                         | March-2020     |             150 |    3278292 |                0 |
| Mongolia                         | April-2020     |             784 |    3278292 |             0.02 |
| Mongolia                         | May-2020       |            3109 |    3278292 |             0.09 |
| Mongolia                         | June-2020      |            6073 |    3278292 |             0.19 |
| Mongolia                         | July-2020      |            8047 |    3278292 |             0.25 |
| Mongolia                         | August-2020    |            9204 |    3278292 |             0.28 |
| Mongolia                         | September-2020 |            9335 |    3278292 |             0.28 |
| Mongolia                         | October-2020   |           10071 |    3278292 |             0.31 |
| Mongolia                         | November-2020  |           15411 |    3278292 |             0.47 |
| Mongolia                         | December-2020  |           30313 |    3278292 |             0.92 |
| Mongolia                         | January-2021   |           47060 |    3278292 |             1.44 |
| Mongolia                         | February-2021  |           67025 |    3278292 |             2.04 |
| Mongolia                         | March-2021     |          149927 |    3278292 |             4.57 |
| Mongolia                         | April-2021     |          630670 |    3278292 |            19.24 |
| Montenegro                       | March-2020     |             702 |     628062 |             0.11 |
| Montenegro                       | April-2020     |            8188 |     628062 |              1.3 |
| Montenegro                       | May-2020       |           10037 |     628062 |              1.6 |
| Montenegro                       | June-2020      |           10921 |     628062 |             1.74 |
| Montenegro                       | July-2020      |           54628 |     628062 |              8.7 |
| Montenegro                       | August-2020    |          124250 |     628062 |            19.78 |
| Montenegro                       | September-2020 |          227189 |     628062 |            36.17 |
| Montenegro                       | October-2020   |          461498 |     628062 |            73.48 |
| Montenegro                       | November-2020  |          820589 |     628062 |           130.65 |
| Montenegro                       | December-2020  |         1312373 |     628062 |           208.96 |
| Montenegro                       | January-2021   |         1704974 |     628062 |           271.47 |
| Montenegro                       | February-2021  |         1930633 |     628062 |            307.4 |
| Montenegro                       | March-2021     |         2615404 |     628062 |           416.42 |
| Montenegro                       | April-2021     |         2846834 |     628062 |           453.27 |
| Montserrat                       | February-2021  |               0 |       4999 |                0 |
| Montserrat                       | March-2021     |               0 |       4999 |                0 |
| Montserrat                       | April-2021     |               0 |       4999 |                0 |
| Morocco                          | February-2020  |               0 |   36910558 |                0 |
| Morocco                          | March-2020     |            3758 |   36910558 |             0.01 |
| Morocco                          | April-2020     |           71867 |   36910558 |             0.19 |
| Morocco                          | May-2020       |          203338 |   36910558 |             0.55 |
| Morocco                          | June-2020      |          284411 |   36910558 |             0.77 |
| Morocco                          | July-2020      |          530553 |   36910558 |             1.44 |
| Morocco                          | August-2020    |         1322632 |   36910558 |             3.58 |
| Morocco                          | September-2020 |         2767280 |   36910558 |              7.5 |
| Morocco                          | October-2020   |         5233086 |   36910558 |            14.18 |
| Morocco                          | November-2020  |         8764895 |   36910558 |            23.75 |
| Morocco                          | December-2020  |        12547642 |   36910558 |            33.99 |
| Morocco                          | January-2021   |        14188137 |   36910558 |            38.44 |
| Morocco                          | February-2021  |        13392533 |   36910558 |            36.28 |
| Morocco                          | March-2021     |        15182695 |   36910558 |            41.13 |
| Morocco                          | April-2021     |        15128193 |   36910558 |            40.99 |
| Mozambique                       | March-2020     |              56 |   31255435 |                0 |
| Mozambique                       | April-2020     |            1062 |   31255435 |                0 |
| Mozambique                       | May-2020       |            4381 |   31255435 |             0.01 |
| Mozambique                       | June-2020      |           17887 |   31255435 |             0.06 |
| Mozambique                       | July-2020      |           41760 |   31255435 |             0.13 |
| Mozambique                       | August-2020    |           88562 |   31255435 |             0.28 |
| Mozambique                       | September-2020 |          179950 |   31255435 |             0.58 |
| Mozambique                       | October-2020   |          332795 |   31255435 |             1.06 |
| Mozambique                       | November-2020  |          432481 |   31255435 |             1.38 |
| Mozambique                       | December-2020  |          532505 |   31255435 |              1.7 |
| Mozambique                       | January-2021   |          831521 |   31255435 |             2.66 |
| Mozambique                       | February-2021  |         1405822 |   31255435 |              4.5 |
| Mozambique                       | March-2021     |         2000023 |   31255435 |              6.4 |
| Mozambique                       | April-2021     |         2069494 |   31255435 |             6.62 |
| Myanmar                          | March-2020     |              55 |   54409794 |                0 |
| Myanmar                          | April-2020     |            2408 |   54409794 |                0 |
| Myanmar                          | May-2020       |            5780 |   54409794 |             0.01 |
| Myanmar                          | June-2020      |            8018 |   54409794 |             0.01 |
| Myanmar                          | July-2020      |           10335 |   54409794 |             0.02 |
| Myanmar                          | August-2020    |           13862 |   54409794 |             0.03 |
| Myanmar                          | September-2020 |          150402 |   54409794 |             0.28 |
| Myanmar                          | October-2020   |         1037537 |   54409794 |             1.91 |
| Myanmar                          | November-2020  |         2128623 |   54409794 |             3.91 |
| Myanmar                          | December-2020  |         3427806 |   54409794 |              6.3 |
| Myanmar                          | January-2021   |         4135212 |   54409794 |              7.6 |
| Myanmar                          | February-2021  |         3962034 |   54409794 |             7.28 |
| Myanmar                          | March-2021     |         4407423 |   54409794 |              8.1 |
| Myanmar                          | April-2021     |         4278611 |   54409794 |             7.86 |
| Namibia                          | March-2020     |              97 |    2540916 |                0 |
| Namibia                          | April-2020     |             472 |    2540916 |             0.02 |
| Namibia                          | May-2020       |             554 |    2540916 |             0.02 |
| Namibia                          | June-2020      |            1843 |    2540916 |             0.07 |
| Namibia                          | July-2020      |           33954 |    2540916 |             1.34 |
| Namibia                          | August-2020    |          137480 |    2540916 |             5.41 |
| Namibia                          | September-2020 |          293487 |    2540916 |            11.55 |
| Namibia                          | October-2020   |          377670 |    2540916 |            14.86 |
| Namibia                          | November-2020  |          407143 |    2540916 |            16.02 |
| Namibia                          | December-2020  |          559188 |    2540916 |            22.01 |
| Namibia                          | January-2021   |          923307 |    2540916 |            36.34 |
| Namibia                          | February-2021  |         1015143 |    2540916 |            39.95 |
| Namibia                          | March-2021     |         1287688 |    2540916 |            50.68 |
| Namibia                          | April-2021     |         1389191 |    2540916 |            54.67 |
| Nauru                            | April-2021     |               0 |      10834 |                0 |
| Nepal                            | January-2020   |               7 |   29136808 |                0 |
| Nepal                            | February-2020  |              29 |   29136808 |                0 |
| Nepal                            | March-2020     |              56 |   29136808 |                0 |
| Nepal                            | April-2020     |             792 |   29136808 |                0 |
| Nepal                            | May-2020       |           13506 |   29136808 |             0.05 |
| Nepal                            | June-2020      |          210352 |   29136808 |             0.72 |
| Nepal                            | July-2020      |          535535 |   29136808 |             1.84 |
| Nepal                            | August-2020    |          863563 |   29136808 |             2.96 |
| Nepal                            | September-2020 |         1747272 |   29136808 |                6 |
| Nepal                            | October-2020   |         3896377 |   29136808 |            13.37 |
| Nepal                            | November-2020  |         6233158 |   29136808 |            21.39 |
| Nepal                            | December-2020  |         7741083 |   29136808 |            26.57 |
| Nepal                            | January-2021   |         8268041 |   29136808 |            28.38 |
| Nepal                            | February-2021  |         7636928 |   29136808 |            26.21 |
| Nepal                            | March-2021     |         8542862 |   29136808 |            29.32 |
| Nepal                            | April-2021     |         8652964 |   29136808 |             29.7 |
| Netherlands                      | February-2020  |               8 |   17134873 |                0 |
| Netherlands                      | March-2020     |          102010 |   17134873 |              0.6 |
| Netherlands                      | April-2020     |          847556 |   17134873 |             4.95 |
| Netherlands                      | May-2020       |         1357150 |   17134873 |             7.92 |
| Netherlands                      | June-2020      |         1467908 |   17134873 |             8.57 |
| Netherlands                      | July-2020      |         1610265 |   17134873 |              9.4 |
| Netherlands                      | August-2020    |         1986507 |   17134873 |            11.59 |
| Netherlands                      | September-2020 |         2803172 |   17134873 |            16.36 |
| Netherlands                      | October-2020   |         7024864 |   17134873 |               41 |
| Netherlands                      | November-2020  |        13649806 |   17134873 |            79.66 |
| Netherlands                      | December-2020  |        20507503 |   17134873 |           119.68 |
| Netherlands                      | January-2021   |        28343170 |   17134873 |           165.41 |
| Netherlands                      | February-2021  |        29303549 |   17134873 |           171.02 |
| Netherlands                      | March-2021     |        36901518 |   17134873 |           215.36 |
| Netherlands                      | April-2021     |        42290027 |   17134873 |           246.81 |
| New Zealand                      | February-2020  |               2 |    4822233 |                0 |
| New Zealand                      | March-2020     |            3637 |    4822233 |             0.08 |
| New Zealand                      | April-2020     |           38859 |    4822233 |             0.81 |
| New Zealand                      | May-2020       |           46429 |    4822233 |             0.96 |
| New Zealand                      | June-2020      |           45317 |    4822233 |             0.94 |
| New Zealand                      | July-2020      |           47976 |    4822233 |             0.99 |
| New Zealand                      | August-2020    |           50692 |    4822233 |             1.05 |
| New Zealand                      | September-2020 |           54113 |    4822233 |             1.12 |
| New Zealand                      | October-2020   |           58768 |    4822233 |             1.22 |
| New Zealand                      | November-2020  |           60239 |    4822233 |             1.25 |
| New Zealand                      | December-2020  |           65370 |    4822233 |             1.36 |
| New Zealand                      | January-2021   |           69608 |    4822233 |             1.44 |
| New Zealand                      | February-2021  |           65507 |    4822233 |             1.36 |
| New Zealand                      | March-2021     |           75612 |    4822233 |             1.57 |
| New Zealand                      | April-2021     |           77304 |    4822233 |              1.6 |
| Nicaragua                        | March-2020     |              33 |    6624554 |                0 |
| Nicaragua                        | April-2020     |             269 |    6624554 |                0 |
| Nicaragua                        | May-2020       |            6802 |    6624554 |              0.1 |
| Nicaragua                        | June-2020      |           49303 |    6624554 |             0.74 |
| Nicaragua                        | July-2020      |           95826 |    6624554 |             1.45 |
| Nicaragua                        | August-2020    |          128770 |    6624554 |             1.94 |
| Nicaragua                        | September-2020 |          146980 |    6624554 |             2.22 |
| Nicaragua                        | October-2020   |          165777 |    6624554 |              2.5 |
| Nicaragua                        | November-2020  |          170201 |    6624554 |             2.57 |
| Nicaragua                        | December-2020  |          183612 |    6624554 |             2.77 |
| Nicaragua                        | January-2021   |          190873 |    6624554 |             2.88 |
| Nicaragua                        | February-2021  |          178231 |    6624554 |             2.69 |
| Nicaragua                        | March-2021     |          203458 |    6624554 |             3.07 |
| Nicaragua                        | April-2021     |          203357 |    6624554 |             3.07 |
| Niger                            | March-2020     |             119 |   24206636 |                0 |
| Niger                            | April-2020     |           15083 |   24206636 |             0.06 |
| Niger                            | May-2020       |           26985 |   24206636 |             0.11 |
| Niger                            | June-2020      |           30260 |   24206636 |             0.13 |
| Niger                            | July-2020      |           34308 |   24206636 |             0.14 |
| Niger                            | August-2020    |           36069 |   24206636 |             0.15 |
| Niger                            | September-2020 |           35530 |   24206636 |             0.15 |
| Niger                            | October-2020   |           37451 |   24206636 |             0.15 |
| Niger                            | November-2020  |           39812 |   24206636 |             0.16 |
| Niger                            | December-2020  |           75726 |   24206636 |             0.31 |
| Niger                            | January-2021   |          125511 |   24206636 |             0.52 |
| Niger                            | February-2021  |          130884 |   24206636 |             0.54 |
| Niger                            | March-2021     |          151178 |   24206636 |             0.62 |
| Niger                            | April-2021     |          153386 |   24206636 |             0.63 |
| Nigeria                          | February-2020  |               2 |  206139587 |                0 |
| Nigeria                          | March-2020     |             843 |  206139587 |                0 |
| Nigeria                          | April-2020     |           19506 |  206139587 |             0.01 |
| Nigeria                          | May-2020       |          180866 |  206139587 |             0.09 |
| Nigeria                          | June-2020      |          521195 |  206139587 |             0.25 |
| Nigeria                          | July-2020      |         1081480 |  206139587 |             0.52 |
| Nigeria                          | August-2020    |         1523808 |  206139587 |             0.74 |
| Nigeria                          | September-2020 |         1697188 |  206139587 |             0.82 |
| Nigeria                          | October-2020   |         1889825 |  206139587 |             0.92 |
| Nigeria                          | November-2020  |         1957643 |  206139587 |             0.95 |
| Nigeria                          | December-2020  |         2359755 |  206139587 |             1.14 |
| Nigeria                          | January-2021   |         3386814 |  206139587 |             1.64 |
| Nigeria                          | February-2021  |         4086780 |  206139587 |             1.98 |
| Nigeria                          | March-2021     |         4974919 |  206139587 |             2.41 |
| Nigeria                          | April-2021     |         4922431 |  206139587 |             2.39 |
| North Macedonia                  | February-2020  |               4 |    2083380 |                0 |
| North Macedonia                  | March-2020     |            2469 |    2083380 |             0.12 |
| North Macedonia                  | April-2020     |           29086 |    2083380 |              1.4 |
| North Macedonia                  | May-2020       |           55465 |    2083380 |             2.66 |
| North Macedonia                  | June-2020      |          127852 |    2083380 |             6.14 |
| North Macedonia                  | July-2020      |          267796 |    2083380 |            12.85 |
| North Macedonia                  | August-2020    |          393574 |    2083380 |            18.89 |
| North Macedonia                  | September-2020 |          484487 |    2083380 |            23.25 |
| North Macedonia                  | October-2020   |          721228 |    2083380 |            34.62 |
| North Macedonia                  | November-2020  |         1422228 |    2083380 |            68.27 |
| North Macedonia                  | December-2020  |         2316938 |    2083380 |           111.21 |
| North Macedonia                  | January-2021   |         2736461 |    2083380 |           131.35 |
| North Macedonia                  | February-2021  |         2725082 |    2083380 |            130.8 |
| North Macedonia                  | March-2021     |         3572167 |    2083380 |           171.46 |
| North Macedonia                  | April-2021     |         4319854 |    2083380 |           207.35 |
| Northern Cyprus                  | January-2021   |               0 |          0 |             NULL |
| Northern Cyprus                  | February-2021  |               0 |          0 |             NULL |
| Northern Cyprus                  | March-2021     |               0 |          0 |             NULL |
| Northern Cyprus                  | April-2021     |               0 |          0 |             NULL |
| Norway                           | February-2020  |              23 |    5421242 |                0 |
| Norway                           | March-2020     |           51448 |    5421242 |             0.95 |
| Norway                           | April-2020     |          200308 |    5421242 |             3.69 |
| Norway                           | May-2020       |          253969 |    5421242 |             4.68 |
| Norway                           | June-2020      |          259993 |    5421242 |              4.8 |
| Norway                           | July-2020      |          279850 |    5421242 |             5.16 |
| Norway                           | August-2020    |          309769 |    5421242 |             5.71 |
| Norway                           | September-2020 |          373709 |    5421242 |             6.89 |
| Norway                           | October-2020   |          512670 |    5421242 |             9.46 |
| Norway                           | November-2020  |          868805 |    5421242 |            16.03 |
| Norway                           | December-2020  |         1318834 |    5421242 |            24.33 |
| Norway                           | January-2021   |         1785238 |    5421242 |            32.93 |
| Norway                           | February-2021  |         1873818 |    5421242 |            34.56 |
| Norway                           | March-2021     |         2572627 |    5421242 |            47.45 |
| Norway                           | April-2021     |         3171867 |    5421242 |            58.51 |
| Oman                             | February-2020  |              22 |    5106622 |                0 |
| Oman                             | March-2020     |            1700 |    5106622 |             0.03 |
| Oman                             | April-2020     |           32202 |    5106622 |             0.63 |
| Oman                             | May-2020       |          169194 |    5106622 |             3.31 |
| Oman                             | June-2020      |          752585 |    5106622 |            14.74 |
| Oman                             | July-2020      |         1918861 |    5106622 |            37.58 |
| Oman                             | August-2020    |         2564645 |    5106622 |            50.22 |
| Oman                             | September-2020 |         2740993 |    5106622 |            53.68 |
| Oman                             | October-2020   |         3346098 |    5106622 |            65.52 |
| Oman                             | November-2020  |         3601350 |    5106622 |            70.52 |
| Oman                             | December-2020  |         3926319 |    5106622 |            76.89 |
| Oman                             | January-2021   |         4078314 |    5106622 |            79.86 |
| Oman                             | February-2021  |         3852400 |    5106622 |            75.44 |
| Oman                             | March-2021     |         4607228 |    5106622 |            90.22 |
| Oman                             | April-2021     |         5301318 |    5106622 |           103.81 |
| Pakistan                         | February-2020  |              14 |  220892331 |                0 |
| Pakistan                         | March-2020     |           17691 |  220892331 |             0.01 |
| Pakistan                         | April-2020     |          246405 |  220892331 |             0.11 |
| Pakistan                         | May-2020       |         1316336 |  220892331 |              0.6 |
| Pakistan                         | June-2020      |         4450339 |  220892331 |             2.01 |
| Pakistan                         | July-2020      |         7910429 |  220892331 |             3.58 |
| Pakistan                         | August-2020    |         8934372 |  220892331 |             4.04 |
| Pakistan                         | September-2020 |         9118734 |  220892331 |             4.13 |
| Pakistan                         | October-2020   |        10005964 |  220892331 |             4.53 |
| Pakistan                         | November-2020  |        10891173 |  220892331 |             4.93 |
| Pakistan                         | December-2020  |        13839663 |  220892331 |             6.27 |
| Pakistan                         | January-2021   |        16029828 |  220892331 |             7.26 |
| Pakistan                         | February-2021  |        15805181 |  220892331 |             7.16 |
| Pakistan                         | March-2021     |        19174307 |  220892331 |             8.68 |
| Pakistan                         | April-2021     |        22487129 |  220892331 |            10.18 |
| Palestine                        | March-2020     |            1355 |    5101416 |             0.03 |
| Palestine                        | April-2020     |            8597 |    5101416 |             0.17 |
| Palestine                        | May-2020       |           12240 |    5101416 |             0.24 |
| Palestine                        | June-2020      |           25938 |    5101416 |             0.51 |
| Palestine                        | July-2020      |          230938 |    5101416 |             4.53 |
| Palestine                        | August-2020    |          519581 |    5101416 |            10.19 |
| Palestine                        | September-2020 |          965368 |    5101416 |            18.92 |
| Palestine                        | October-2020   |         1445125 |    5101416 |            28.33 |
| Palestine                        | November-2020  |         1983791 |    5101416 |            38.89 |
| Palestine                        | December-2020  |         3560267 |    5101416 |            69.79 |
| Palestine                        | January-2021   |         4668798 |    5101416 |            91.52 |
| Palestine                        | February-2021  |         4737219 |    5101416 |            92.86 |
| Palestine                        | March-2021     |         6630876 |    5101416 |           129.98 |
| Palestine                        | April-2021     |         8237354 |    5101416 |           161.47 |
| Panama                           | March-2020     |            7317 |    4314768 |             0.17 |
| Panama                           | April-2020     |          112687 |    4314768 |             2.61 |
| Panama                           | May-2020       |          296760 |    4314768 |             6.88 |
| Panama                           | June-2020      |          671302 |    4314768 |            15.56 |
| Panama                           | July-2020      |         1544999 |    4314768 |            35.81 |
| Panama                           | August-2020    |         2495408 |    4314768 |            57.83 |
| Panama                           | September-2020 |         3095304 |    4314768 |            71.74 |
| Panama                           | October-2020   |         3823490 |    4314768 |            88.61 |
| Panama                           | November-2020  |         4442214 |    4314768 |           102.95 |
| Panama                           | December-2020  |         6281785 |    4314768 |           145.59 |
| Panama                           | January-2021   |         9023901 |    4314768 |           209.14 |
| Panama                           | February-2021  |         9296807 |    4314768 |           215.46 |
| Panama                           | March-2021     |        10808142 |    4314768 |           250.49 |
| Panama                           | April-2021     |        10799722 |    4314768 |            250.3 |
| Papua New Guinea                 | March-2020     |              12 |    8947027 |                0 |
| Papua New Guinea                 | April-2020     |             139 |    8947027 |                0 |
| Papua New Guinea                 | May-2020       |             248 |    8947027 |                0 |
| Papua New Guinea                 | June-2020      |             261 |    8947027 |                0 |
| Papua New Guinea                 | July-2020      |             786 |    8947027 |             0.01 |
| Papua New Guinea                 | August-2020    |            9181 |    8947027 |              0.1 |
| Papua New Guinea                 | September-2020 |           15304 |    8947027 |             0.17 |
| Papua New Guinea                 | October-2020   |           17613 |    8947027 |              0.2 |
| Papua New Guinea                 | November-2020  |           18326 |    8947027 |              0.2 |
| Papua New Guinea                 | December-2020  |           22656 |    8947027 |             0.25 |
| Papua New Guinea                 | January-2021   |           25582 |    8947027 |             0.29 |
| Papua New Guinea                 | February-2021  |           27487 |    8947027 |             0.31 |
| Papua New Guinea                 | March-2021     |           87886 |    8947027 |             0.98 |
| Papua New Guinea                 | April-2021     |          271554 |    8947027 |             3.04 |
| Paraguay                         | March-2020     |             546 |    7132530 |             0.01 |
| Paraguay                         | April-2020     |            5046 |    7132530 |             0.07 |
| Paraguay                         | May-2020       |           22319 |    7132530 |             0.31 |
| Paraguay                         | June-2020      |           41461 |    7132530 |             0.58 |
| Paraguay                         | July-2020      |          107086 |    7132530 |              1.5 |
| Paraguay                         | August-2020    |          322154 |    7132530 |             4.52 |
| Paraguay                         | September-2020 |          895368 |    7132530 |            12.55 |
| Paraguay                         | October-2020   |         1643914 |    7132530 |            23.05 |
| Paraguay                         | November-2020  |         2172533 |    7132530 |            30.46 |
| Paraguay                         | December-2020  |         2979709 |    7132530 |            41.78 |
| Paraguay                         | January-2021   |         3746546 |    7132530 |            52.53 |
| Paraguay                         | February-2021  |         4076019 |    7132530 |            57.15 |
| Paraguay                         | March-2021     |         5750218 |    7132530 |            80.62 |
| Paraguay                         | April-2021     |         7379850 |    7132530 |           103.47 |
| Peru                             | January-2020   |               0 |   32971846 |                0 |
| Peru                             | February-2020  |               0 |   32971846 |                0 |
| Peru                             | March-2020     |            7702 |   32971846 |             0.02 |
| Peru                             | April-2020     |          410944 |   32971846 |             1.25 |
| Peru                             | May-2020       |         2852556 |   32971846 |             8.65 |
| Peru                             | June-2020      |         6934846 |   32971846 |            21.03 |
| Peru                             | July-2020      |        10661731 |   32971846 |            32.34 |
| Peru                             | August-2020    |        16405207 |   32971846 |            49.76 |
| Peru                             | September-2020 |        22054476 |   32971846 |            66.89 |
| Peru                             | October-2020   |        26653391 |   32971846 |            80.84 |
| Peru                             | November-2020  |        28025436 |   32971846 |               85 |
| Peru                             | December-2020  |        30624534 |   32971846 |            92.88 |
| Peru                             | January-2021   |        32876154 |   32971846 |            99.71 |
| Peru                             | February-2021  |        34491490 |   32971846 |           104.61 |
| Peru                             | March-2021     |        44328085 |   32971846 |           134.44 |
| Peru                             | April-2021     |        50368511 |   32971846 |           152.76 |
| Philippines                      | January-2020   |               2 |  109581085 |                0 |
| Philippines                      | February-2020  |              80 |  109581085 |                0 |
| Philippines                      | March-2020     |           11453 |  109581085 |             0.01 |
| Philippines                      | April-2020     |          163684 |  109581085 |             0.15 |
| Philippines                      | May-2020       |          386438 |  109581085 |             0.35 |
| Philippines                      | June-2020      |          813411 |  109581085 |             0.74 |
| Philippines                      | July-2020      |         1949430 |  109581085 |             1.78 |
| Philippines                      | August-2020    |         4980560 |  109581085 |             4.55 |
| Philippines                      | September-2020 |         8070661 |  109581085 |             7.37 |
| Philippines                      | October-2020   |        10848463 |  109581085 |              9.9 |
| Philippines                      | November-2020  |        12238336 |  109581085 |            11.17 |
| Philippines                      | December-2020  |        14069315 |  109581085 |            12.84 |
| Philippines                      | January-2021   |        15468721 |  109581085 |            14.12 |
| Philippines                      | February-2021  |        15404710 |  109581085 |            14.06 |
| Philippines                      | March-2021     |        19944409 |  109581085 |             18.2 |
| Philippines                      | April-2021     |        27170027 |  109581085 |            24.79 |
| Poland                           | March-2020     |           16224 |   37846605 |             0.04 |
| Poland                           | April-2020     |          235230 |   37846605 |             0.62 |
| Poland                           | May-2020       |          568704 |   37846605 |              1.5 |
| Poland                           | June-2020      |          890824 |   37846605 |             2.35 |
| Poland                           | July-2020      |         1223582 |   37846605 |             3.23 |
| Poland                           | August-2020    |         1758274 |   37846605 |             4.65 |
| Poland                           | September-2020 |         2314353 |   37846605 |             6.12 |
| Poland                           | October-2020   |         5617354 |   37846605 |            14.84 |
| Poland                           | November-2020  |        21289192 |   37846605 |            56.25 |
| Poland                           | December-2020  |        35868875 |   37846605 |            94.77 |
| Poland                           | January-2021   |        43986631 |   37846605 |           116.22 |
| Poland                           | February-2021  |        44741606 |   37846605 |           118.22 |
| Poland                           | March-2021     |        61090282 |   37846605 |           161.42 |
| Poland                           | April-2021     |        78591316 |   37846605 |           207.66 |
| Portugal                         | February-2020  |               0 |   10196707 |                0 |
| Portugal                         | March-2020     |           46919 |   10196707 |             0.46 |
| Portugal                         | April-2020     |          533042 |   10196707 |             5.23 |
| Portugal                         | May-2020       |          891512 |   10196707 |             8.74 |
| Portugal                         | June-2020      |         1120468 |   10196707 |            10.99 |
| Portugal                         | July-2020      |         1466385 |   10196707 |            14.38 |
| Portugal                         | August-2020    |         1681411 |   10196707 |            16.49 |
| Portugal                         | September-2020 |         1979547 |   10196707 |            19.41 |
| Portugal                         | October-2020   |         3100387 |   10196707 |            30.41 |
| Portugal                         | November-2020  |         6631134 |   10196707 |            65.03 |
| Portugal                         | December-2020  |        11078455 |   10196707 |           108.65 |
| Portugal                         | January-2021   |        17049576 |   10196707 |           167.21 |
| Portugal                         | February-2021  |        21832473 |   10196707 |           214.11 |
| Portugal                         | March-2021     |        25249953 |   10196707 |           247.63 |
| Portugal                         | April-2021     |        24884086 |   10196707 |           244.04 |
| Qatar                            | February-2020  |               1 |    2881060 |                0 |
| Qatar                            | March-2020     |           10292 |    2881060 |             0.36 |
| Qatar                            | April-2020     |          156835 |    2881060 |             5.44 |
| Qatar                            | May-2020       |         1004693 |    2881060 |            34.87 |
| Qatar                            | June-2020      |         2393921 |    2881060 |            83.09 |
| Qatar                            | July-2020      |         3253053 |    2881060 |           112.91 |
| Qatar                            | August-2020    |         3564216 |    2881060 |           123.71 |
| Qatar                            | September-2020 |         3670670 |    2881060 |           127.41 |
| Qatar                            | October-2020   |         4003427 |    2881060 |           138.96 |
| Qatar                            | November-2020  |         4075334 |    2881060 |           141.45 |
| Qatar                            | December-2020  |         4383960 |    2881060 |           152.16 |
| Qatar                            | January-2021   |         4566164 |    2881060 |           158.49 |
| Qatar                            | February-2021  |         4411295 |    2881060 |           153.11 |
| Qatar                            | March-2021     |         5315332 |    2881060 |           184.49 |
| Qatar                            | April-2021     |         5816640 |    2881060 |           201.89 |
| Romania                          | February-2020  |               8 |   19237682 |                0 |
| Romania                          | March-2020     |           14734 |   19237682 |             0.08 |
| Romania                          | April-2020     |          222963 |   19237682 |             1.16 |
| Romania                          | May-2020       |          507655 |   19237682 |             2.64 |
| Romania                          | June-2020      |          680012 |   19237682 |             3.53 |
| Romania                          | July-2020      |         1133525 |   19237682 |             5.89 |
| Romania                          | August-2020    |         2170182 |   19237682 |            11.28 |
| Romania                          | September-2020 |         3212048 |   19237682 |             16.7 |
| Romania                          | October-2020   |         5464640 |   19237682 |            28.41 |
| Romania                          | November-2020  |        10889047 |   19237682 |             56.6 |
| Romania                          | December-2020  |        17531041 |   19237682 |            91.13 |
| Romania                          | January-2021   |        21284511 |   19237682 |           110.64 |
| Romania                          | February-2021  |        21393593 |   19237682 |           111.21 |
| Romania                          | March-2021     |        27072367 |   19237682 |           140.73 |
| Romania                          | April-2021     |        30490112 |   19237682 |           158.49 |
| Russia                           | January-2020   |               2 |  145934460 |                0 |
| Russia                           | February-2020  |              58 |  145934460 |                0 |
| Russia                           | March-2020     |           12224 |  145934460 |             0.01 |
| Russia                           | April-2020     |         1129437 |  145934460 |             0.77 |
| Russia                           | May-2020       |         8257093 |  145934460 |             5.66 |
| Russia                           | June-2020      |        16097579 |  145934460 |            11.03 |
| Russia                           | July-2020      |        23233041 |  145934460 |            15.92 |
| Russia                           | August-2020    |        28508044 |  145934460 |            19.53 |
| Russia                           | September-2020 |        32289140 |  145934460 |            22.13 |
| Russia                           | October-2020   |        42549555 |  145934460 |            29.16 |
| Russia                           | November-2020  |        57925419 |  145934460 |            39.69 |
| Russia                           | December-2020  |        84102182 |  145934460 |            57.63 |
| Russia                           | January-2021   |       108422409 |  145934460 |             74.3 |
| Russia                           | February-2021  |       112712911 |  145934460 |            77.24 |
| Russia                           | March-2021     |       135088504 |  145934460 |            92.57 |
| Russia                           | April-2021     |       138817103 |  145934460 |            95.12 |
| Rwanda                           | March-2020     |             579 |   12952209 |                0 |
| Rwanda                           | April-2020     |            4265 |   12952209 |             0.03 |
| Rwanda                           | May-2020       |            9340 |   12952209 |             0.07 |
| Rwanda                           | June-2020      |           18926 |   12952209 |             0.15 |
| Rwanda                           | July-2020      |           46037 |   12952209 |             0.36 |
| Rwanda                           | August-2020    |           83766 |   12952209 |             0.65 |
| Rwanda                           | September-2020 |          137668 |   12952209 |             1.06 |
| Rwanda                           | October-2020   |          154093 |   12952209 |             1.19 |
| Rwanda                           | November-2020  |          164524 |   12952209 |             1.27 |
| Rwanda                           | December-2020  |          216567 |   12952209 |             1.67 |
| Rwanda                           | January-2021   |          348874 |   12952209 |             2.69 |
| Rwanda                           | February-2021  |          485642 |   12952209 |             3.75 |
| Rwanda                           | March-2021     |          631948 |   12952209 |             4.88 |
| Rwanda                           | April-2021     |          711088 |   12952209 |             5.49 |
| Saint Helena                     | February-2021  |               0 |       6071 |                0 |
| Saint Helena                     | March-2021     |               0 |       6071 |                0 |
| Saint Helena                     | April-2021     |               0 |       6071 |                0 |
| Saint Kitts and Nevis            | March-2020     |              25 |      53192 |             0.05 |
| Saint Kitts and Nevis            | April-2020     |             385 |      53192 |             0.72 |
| Saint Kitts and Nevis            | May-2020       |             465 |      53192 |             0.87 |
| Saint Kitts and Nevis            | June-2020      |             450 |      53192 |             0.85 |
| Saint Kitts and Nevis            | July-2020      |             515 |      53192 |             0.97 |
| Saint Kitts and Nevis            | August-2020    |             527 |      53192 |             0.99 |
| Saint Kitts and Nevis            | September-2020 |             530 |      53192 |                1 |
| Saint Kitts and Nevis            | October-2020   |             589 |      53192 |             1.11 |
| Saint Kitts and Nevis            | November-2020  |             593 |      53192 |             1.11 |
| Saint Kitts and Nevis            | December-2020  |             862 |      53192 |             1.62 |
| Saint Kitts and Nevis            | January-2021   |            1072 |      53192 |             2.02 |
| Saint Kitts and Nevis            | February-2021  |            1130 |      53192 |             2.12 |
| Saint Kitts and Nevis            | March-2021     |            1325 |      53192 |             2.49 |
| Saint Kitts and Nevis            | April-2021     |            1320 |      53192 |             2.48 |
| Saint Lucia                      | March-2020     |              66 |     183629 |             0.04 |
| Saint Lucia                      | April-2020     |             442 |     183629 |             0.24 |
| Saint Lucia                      | May-2020       |             556 |     183629 |              0.3 |
| Saint Lucia                      | June-2020      |             567 |     183629 |             0.31 |
| Saint Lucia                      | July-2020      |             703 |     183629 |             0.38 |
| Saint Lucia                      | August-2020    |             789 |     183629 |             0.43 |
| Saint Lucia                      | September-2020 |             802 |     183629 |             0.44 |
| Saint Lucia                      | October-2020   |            1254 |     183629 |             0.68 |
| Saint Lucia                      | November-2020  |            5201 |     183629 |             2.83 |
| Saint Lucia                      | December-2020  |            8909 |     183629 |             4.85 |
| Saint Lucia                      | January-2021   |           20063 |     183629 |            10.93 |
| Saint Lucia                      | February-2021  |           68586 |     183629 |            37.35 |
| Saint Lucia                      | March-2021     |          124502 |     183629 |             67.8 |
| Saint Lucia                      | April-2021     |          131631 |     183629 |            71.68 |
| Saint Vincent and the Grenadines | March-2020     |              18 |     110947 |             0.02 |
| Saint Vincent and the Grenadines | April-2020     |             329 |     110947 |              0.3 |
| Saint Vincent and the Grenadines | May-2020       |             567 |     110947 |             0.51 |
| Saint Vincent and the Grenadines | June-2020      |             834 |     110947 |             0.75 |
| Saint Vincent and the Grenadines | July-2020      |            1233 |     110947 |             1.11 |
| Saint Vincent and the Grenadines | August-2020    |            1779 |     110947 |              1.6 |
| Saint Vincent and the Grenadines | September-2020 |            1894 |     110947 |             1.71 |
| Saint Vincent and the Grenadines | October-2020   |            2092 |     110947 |             1.89 |
| Saint Vincent and the Grenadines | November-2020  |            2400 |     110947 |             2.16 |
| Saint Vincent and the Grenadines | December-2020  |            3070 |     110947 |             2.77 |
| Saint Vincent and the Grenadines | January-2021   |           14455 |     110947 |            13.03 |
| Saint Vincent and the Grenadines | February-2021  |           38221 |     110947 |            34.45 |
| Saint Vincent and the Grenadines | March-2021     |           52231 |     110947 |            47.08 |
| Saint Vincent and the Grenadines | April-2021     |           54187 |     110947 |            48.84 |
| Samoa                            | November-2020  |              17 |     198410 |             0.01 |
| Samoa                            | December-2020  |              62 |     198410 |             0.03 |
| Samoa                            | January-2021   |              62 |     198410 |             0.03 |
| Samoa                            | February-2021  |              70 |     198410 |             0.04 |
| Samoa                            | March-2021     |              93 |     198410 |             0.05 |
| Samoa                            | April-2021     |              90 |     198410 |             0.05 |
| San Marino                       | February-2020  |               3 |      33938 |             0.01 |
| San Marino                       | March-2020     |            3461 |      33938 |             10.2 |
| San Marino                       | April-2020     |           12054 |      33938 |            35.52 |
| San Marino                       | May-2020       |           19843 |      33938 |            58.47 |
| San Marino                       | June-2020      |           20723 |      33938 |            61.06 |
| San Marino                       | July-2020      |           21661 |      33938 |            63.83 |
| San Marino                       | August-2020    |           21784 |      33938 |            64.19 |
| San Marino                       | September-2020 |           21717 |      33938 |            63.99 |
| San Marino                       | October-2020   |           24252 |      33938 |            71.46 |
| San Marino                       | November-2020  |           38064 |      33938 |           112.16 |
| San Marino                       | December-2020  |           62595 |      33938 |           184.44 |
| San Marino                       | January-2021   |           85076 |      33938 |           250.68 |
| San Marino                       | February-2021  |           93487 |      33938 |           275.46 |
| San Marino                       | March-2021     |          130848 |      33938 |           385.55 |
| San Marino                       | April-2021     |          149013 |      33938 |           439.07 |
| Sao Tome and Principe            | April-2020     |             118 |     219161 |             0.05 |
| Sao Tome and Principe            | May-2020       |            7624 |     219161 |             3.48 |
| Sao Tome and Principe            | June-2020      |           18865 |     219161 |             8.61 |
| Sao Tome and Principe            | July-2020      |           23753 |     219161 |            10.84 |
| Sao Tome and Principe            | August-2020    |           27436 |     219161 |            12.52 |
| Sao Tome and Principe            | September-2020 |           27146 |     219161 |            12.39 |
| Sao Tome and Principe            | October-2020   |           28809 |     219161 |            13.15 |
| Sao Tome and Principe            | November-2020  |           29081 |     219161 |            13.27 |
| Sao Tome and Principe            | December-2020  |           31257 |     219161 |            14.26 |
| Sao Tome and Principe            | January-2021   |           34943 |     219161 |            15.94 |
| Sao Tome and Principe            | February-2021  |           42060 |     219161 |            19.19 |
| Sao Tome and Principe            | March-2021     |           64204 |     219161 |             29.3 |
| Sao Tome and Principe            | April-2021     |           68164 |     219161 |             31.1 |
| Saudi Arabia                     | March-2020     |           12266 |   34813867 |             0.04 |
| Saudi Arabia                     | April-2020     |          262096 |   34813867 |             0.75 |
| Saudi Arabia                     | May-2020       |         1660260 |   34813867 |             4.77 |
| Saudi Arabia                     | June-2020      |         4063590 |   34813867 |            11.67 |
| Saudi Arabia                     | July-2020      |         7458294 |   34813867 |            21.42 |
| Saudi Arabia                     | August-2020    |         9232859 |   34813867 |            26.52 |
| Saudi Arabia                     | September-2020 |         9799409 |   34813867 |            28.15 |
| Saudi Arabia                     | October-2020   |        10580404 |   34813867 |            30.39 |
| Saudi Arabia                     | November-2020  |        10591512 |   34813867 |            30.42 |
| Saudi Arabia                     | December-2020  |        11170841 |   34813867 |            32.09 |
| Saudi Arabia                     | January-2021   |        11315754 |   34813867 |             32.5 |
| Saudi Arabia                     | February-2021  |        10439661 |   34813867 |            29.99 |
| Saudi Arabia                     | March-2021     |        11883601 |   34813867 |            34.13 |
| Saudi Arabia                     | April-2021     |        12092823 |   34813867 |            34.74 |
| Senegal                          | February-2020  |               0 |   16743930 |                0 |
| Senegal                          | March-2020     |            1444 |   16743930 |             0.01 |
| Senegal                          | April-2020     |           12025 |   16743930 |             0.07 |
| Senegal                          | May-2020       |           72254 |   16743930 |             0.43 |
| Senegal                          | June-2020      |          157369 |   16743930 |             0.94 |
| Senegal                          | July-2020      |          264469 |   16743930 |             1.58 |
| Senegal                          | August-2020    |          372440 |   16743930 |             2.22 |
| Senegal                          | September-2020 |          432699 |   16743930 |             2.58 |
| Senegal                          | October-2020   |          476074 |   16743930 |             2.84 |
| Senegal                          | November-2020  |          474263 |   16743930 |             2.83 |
| Senegal                          | December-2020  |          540600 |   16743930 |             3.23 |
| Senegal                          | January-2021   |          704660 |   16743930 |             4.21 |
| Senegal                          | February-2021  |          865118 |   16743930 |             5.17 |
| Senegal                          | March-2021     |         1146849 |   16743930 |             6.85 |
| Senegal                          | April-2021     |         1188702 |   16743930 |              7.1 |
| Serbia                           | February-2020  |               0 |    6804596 |                0 |
| Serbia                           | March-2020     |            5865 |    6804596 |             0.09 |
| Serbia                           | April-2020     |          149995 |    6804596 |              2.2 |
| Serbia                           | May-2020       |          324948 |    6804596 |             4.78 |
| Serbia                           | June-2020      |          377220 |    6804596 |             5.54 |
| Serbia                           | July-2020      |          618471 |    6804596 |             9.09 |
| Serbia                           | August-2020    |          906472 |    6804596 |            13.32 |
| Serbia                           | September-2020 |          976669 |    6804596 |            14.35 |
| Serbia                           | October-2020   |         1146697 |    6804596 |            16.85 |
| Serbia                           | November-2020  |         2898418 |    6804596 |             42.6 |
| Serbia                           | December-2020  |         8500530 |    6804596 |           124.92 |
| Serbia                           | January-2021   |        11459767 |    6804596 |           168.41 |
| Serbia                           | February-2021  |        11879989 |    6804596 |           174.59 |
| Serbia                           | March-2021     |        16376145 |    6804596 |           240.66 |
| Serbia                           | April-2021     |        19596057 |    6804596 |           287.98 |
| Seychelles                       | March-2020     |             111 |      98340 |             0.11 |
| Seychelles                       | April-2020     |             325 |      98340 |             0.33 |
| Seychelles                       | May-2020       |             341 |      98340 |             0.35 |
| Seychelles                       | June-2020      |             534 |      98340 |             0.54 |
| Seychelles                       | July-2020      |            3122 |      98340 |             3.17 |
| Seychelles                       | August-2020    |            3972 |      98340 |             4.04 |
| Seychelles                       | September-2020 |            4195 |      98340 |             4.27 |
| Seychelles                       | October-2020   |            4631 |      98340 |             4.71 |
| Seychelles                       | November-2020  |            4863 |      98340 |             4.95 |
| Seychelles                       | December-2020  |            6178 |      98340 |             6.28 |
| Seychelles                       | January-2021   |           22300 |      98340 |            22.68 |
| Seychelles                       | February-2021  |           55056 |      98340 |            55.99 |
| Seychelles                       | March-2021     |          106823 |      98340 |           108.63 |
| Seychelles                       | April-2021     |          144133 |      98340 |           146.57 |
| Sierra Leone                     | March-2020     |               1 |    7976985 |                0 |
| Sierra Leone                     | April-2020     |            1108 |    7976985 |             0.01 |
| Sierra Leone                     | May-2020       |           14797 |    7976985 |             0.19 |
| Sierra Leone                     | June-2020      |           35399 |    7976985 |             0.44 |
| Sierra Leone                     | July-2020      |           51771 |    7976985 |             0.65 |
| Sierra Leone                     | August-2020    |           60266 |    7976985 |             0.76 |
| Sierra Leone                     | September-2020 |           63761 |    7976985 |              0.8 |
| Sierra Leone                     | October-2020   |           71801 |    7976985 |              0.9 |
| Sierra Leone                     | November-2020  |           71748 |    7976985 |              0.9 |
| Sierra Leone                     | December-2020  |           76929 |    7976985 |             0.96 |
| Sierra Leone                     | January-2021   |           92626 |    7976985 |             1.16 |
| Sierra Leone                     | February-2021  |          106690 |    7976985 |             1.34 |
| Sierra Leone                     | March-2021     |          122060 |    7976985 |             1.53 |
| Sierra Leone                     | April-2021     |          120558 |    7976985 |             1.51 |
| Singapore                        | January-2020   |              53 |    5850343 |                0 |
| Singapore                        | February-2020  |            1795 |    5850343 |             0.03 |
| Singapore                        | March-2020     |           11276 |    5850343 |             0.19 |
| Singapore                        | April-2020     |          188949 |    5850343 |             3.23 |
| Singapore                        | May-2020       |          824865 |    5850343 |             14.1 |
| Singapore                        | June-2020      |         1210239 |    5850343 |            20.69 |
| Singapore                        | July-2020      |         1472037 |    5850343 |            25.16 |
| Singapore                        | August-2020    |         1719511 |    5850343 |            29.39 |
| Singapore                        | September-2020 |         1721643 |    5850343 |            29.43 |
| Singapore                        | October-2020   |         1794938 |    5850343 |            30.68 |
| Singapore                        | November-2020  |         1743530 |    5850343 |             29.8 |
| Singapore                        | December-2020  |         1809806 |    5850343 |            30.94 |
| Singapore                        | January-2021   |         1831362 |    5850343 |             31.3 |
| Singapore                        | February-2021  |         1673891 |    5850343 |            28.61 |
| Singapore                        | March-2021     |         1864345 |    5850343 |            31.87 |
| Singapore                        | April-2021     |         1822946 |    5850343 |            31.16 |
| Slovakia                         | March-2020     |            3440 |    5459643 |             0.06 |
| Slovakia                         | April-2020     |           28263 |    5459643 |             0.52 |
| Slovakia                         | May-2020       |           45753 |    5459643 |             0.84 |
| Slovakia                         | June-2020      |           47133 |    5459643 |             0.86 |
| Slovakia                         | July-2020      |           60846 |    5459643 |             1.11 |
| Slovakia                         | August-2020    |           92437 |    5459643 |             1.69 |
| Slovakia                         | September-2020 |          187265 |    5459643 |             3.43 |
| Slovakia                         | October-2020   |          891676 |    5459643 |            16.33 |
| Slovakia                         | November-2020  |         2567554 |    5459643 |            47.03 |
| Slovakia                         | December-2020  |         4363337 |    5459643 |            79.92 |
| Slovakia                         | January-2021   |         6785954 |    5459643 |           124.29 |
| Slovakia                         | February-2021  |         7798032 |    5459643 |           142.83 |
| Slovakia                         | March-2021     |        10497944 |    5459643 |           192.28 |
| Slovakia                         | April-2021     |        11201875 |    5459643 |           205.18 |
| Slovenia                         | February-2020  |               0 |    2078932 |                0 |
| Slovenia                         | March-2020     |            8609 |    2078932 |             0.41 |
| Slovenia                         | April-2020     |           36605 |    2078932 |             1.76 |
| Slovenia                         | May-2020       |           45272 |    2078932 |             2.18 |
| Slovenia                         | June-2020      |           45374 |    2078932 |             2.18 |
| Slovenia                         | July-2020      |           58783 |    2078932 |             2.83 |
| Slovenia                         | August-2020    |           76193 |    2078932 |             3.67 |
| Slovenia                         | September-2020 |          121393 |    2078932 |             5.84 |
| Slovenia                         | October-2020   |          454130 |    2078932 |            21.84 |
| Slovenia                         | November-2020  |         1671542 |    2078932 |             80.4 |
| Slovenia                         | December-2020  |         3098836 |    2078932 |           149.06 |
| Slovenia                         | January-2021   |         4541774 |    2078932 |           218.47 |
| Slovenia                         | February-2021  |         5025008 |    2078932 |           241.71 |
| Slovenia                         | March-2021     |         6272871 |    2078932 |           301.74 |
| Slovenia                         | April-2021     |         6883212 |    2078932 |           331.09 |
| Solomon Islands                  | October-2020   |              87 |     686878 |             0.01 |
| Solomon Islands                  | November-2020  |             458 |     686878 |             0.07 |
| Solomon Islands                  | December-2020  |             527 |     686878 |             0.08 |
| Solomon Islands                  | January-2021   |             527 |     686878 |             0.08 |
| Solomon Islands                  | February-2021  |             495 |     686878 |             0.07 |
| Solomon Islands                  | March-2021     |             559 |     686878 |             0.08 |
| Solomon Islands                  | April-2021     |             585 |     686878 |             0.09 |
| Somalia                          | March-2020     |              29 |   15893219 |                0 |
| Somalia                          | April-2020     |            5314 |   15893219 |             0.03 |
| Somalia                          | May-2020       |           40774 |   15893219 |             0.26 |
| Somalia                          | June-2020      |           77531 |   15893219 |             0.49 |
| Somalia                          | July-2020      |           95846 |   15893219 |              0.6 |
| Somalia                          | August-2020    |          100817 |   15893219 |             0.63 |
| Somalia                          | September-2020 |          102629 |   15893219 |             0.65 |
| Somalia                          | October-2020   |          118956 |   15893219 |             0.75 |
| Somalia                          | November-2020  |          129609 |   15893219 |             0.82 |
| Somalia                          | December-2020  |          143124 |   15893219 |              0.9 |
| Somalia                          | January-2021   |          146980 |   15893219 |             0.92 |
| Somalia                          | February-2021  |          154727 |   15893219 |             0.97 |
| Somalia                          | March-2021     |          292095 |   15893219 |             1.84 |
| Somalia                          | April-2021     |          384553 |   15893219 |             2.42 |
| South Africa                     | February-2020  |               0 |   59308690 |                0 |
| South Africa                     | March-2020     |           10173 |   59308690 |             0.02 |
| South Africa                     | April-2020     |           88044 |   59308690 |             0.15 |
| South Africa                     | May-2020       |          497374 |   59308690 |             0.84 |
| South Africa                     | June-2020      |         2421471 |   59308690 |             4.08 |
| South Africa                     | July-2020      |        10057917 |   59308690 |            16.96 |
| South Africa                     | August-2020    |        17952588 |   59308690 |            30.27 |
| South Africa                     | September-2020 |        19588033 |   59308690 |            33.03 |
| South Africa                     | October-2020   |        21710951 |   59308690 |            36.61 |
| South Africa                     | November-2020  |        22626679 |   59308690 |            38.15 |
| South Africa                     | December-2020  |        27842916 |   59308690 |            46.95 |
| South Africa                     | January-2021   |        40240702 |   59308690 |            67.85 |
| South Africa                     | February-2021  |        41711243 |   59308690 |            70.33 |
| South Africa                     | March-2021     |        47472251 |   59308690 |            80.04 |
| South Africa                     | April-2021     |        46922791 |   59308690 |            79.12 |
| South Korea                      | January-2020   |              36 |   51269183 |                0 |
| South Korea                      | February-2020  |           12128 |   51269183 |             0.02 |
| South Korea                      | March-2020     |          244918 |   51269183 |             0.48 |
| South Korea                      | April-2020     |          315431 |   51269183 |             0.62 |
| South Korea                      | May-2020       |          342959 |   51269183 |             0.67 |
| South Korea                      | June-2020      |          365805 |   51269183 |             0.71 |
| South Korea                      | July-2020      |          423421 |   51269183 |             0.83 |
| South Korea                      | August-2020    |          505449 |   51269183 |             0.99 |
| South Korea                      | September-2020 |          673170 |   51269183 |             1.31 |
| South Korea                      | October-2020   |          780435 |   51269183 |             1.52 |
| South Korea                      | November-2020  |          888618 |   51269183 |             1.73 |
| South Korea                      | December-2020  |         1463251 |   51269183 |             2.85 |
| South Korea                      | January-2021   |         2220738 |   51269183 |             4.33 |
| South Korea                      | February-2021  |         2364057 |   51269183 |             4.61 |
| South Korea                      | March-2021     |         3003141 |   51269183 |             5.86 |
| South Korea                      | April-2021     |         3395144 |   51269183 |             6.62 |
| South Sudan                      | April-2020     |             191 |   11193729 |                0 |
| South Sudan                      | May-2020       |           12050 |   11193729 |             0.11 |
| South Sudan                      | June-2020      |           49168 |   11193729 |             0.44 |
| South Sudan                      | July-2020      |           66680 |   11193729 |              0.6 |
| South Sudan                      | August-2020    |           76852 |   11193729 |             0.69 |
| South Sudan                      | September-2020 |           78188 |   11193729 |              0.7 |
| South Sudan                      | October-2020   |           87229 |   11193729 |             0.78 |
| South Sudan                      | November-2020  |           90188 |   11193729 |             0.81 |
| South Sudan                      | December-2020  |          101635 |   11193729 |             0.91 |
| South Sudan                      | January-2021   |          115032 |   11193729 |             1.03 |
| South Sudan                      | February-2021  |          158760 |   11193729 |             1.42 |
| South Sudan                      | March-2021     |          291531 |   11193729 |              2.6 |
| South Sudan                      | April-2021     |          312418 |   11193729 |             2.79 |
| Spain                            | February-2020  |             151 |   46754783 |                0 |
| Spain                            | March-2020     |          742546 |   46754783 |             1.59 |
| Spain                            | April-2020     |         5236777 |   46754783 |             11.2 |
| Spain                            | May-2020       |         7102653 |   46754783 |            15.19 |
| Spain                            | June-2020      |         7331192 |   46754783 |            15.68 |
| Spain                            | July-2020      |         8134290 |   46754783 |             17.4 |
| Spain                            | August-2020    |        11159043 |   46754783 |            23.87 |
| Spain                            | September-2020 |        18316260 |   46754783 |            39.18 |
| Spain                            | October-2020   |        29494693 |   46754783 |            63.08 |
| Spain                            | November-2020  |        43932783 |   46754783 |            93.96 |
| Spain                            | December-2020  |        55067758 |   46754783 |           117.78 |
| Spain                            | January-2021   |        71180786 |   46754783 |           152.24 |
| Spain                            | February-2021  |        85568038 |   46754783 |           183.01 |
| Spain                            | March-2021     |        99280629 |   46754783 |           212.34 |
| Spain                            | April-2021     |       101966198 |   46754783 |           218.09 |
| Sri Lanka                        | January-2020   |               5 |   21413250 |                0 |
| Sri Lanka                        | February-2020  |              29 |   21413250 |                0 |
| Sri Lanka                        | March-2020     |            1471 |   21413250 |             0.01 |
| Sri Lanka                        | April-2020     |            9067 |   21413250 |             0.04 |
| Sri Lanka                        | May-2020       |           31986 |   21413250 |             0.15 |
| Sri Lanka                        | June-2020      |           57101 |   21413250 |             0.27 |
| Sri Lanka                        | July-2020      |           78455 |   21413250 |             0.37 |
| Sri Lanka                        | August-2020    |           90093 |   21413250 |             0.42 |
| Sri Lanka                        | September-2020 |           97197 |   21413250 |             0.45 |
| Sri Lanka                        | October-2020   |          184458 |   21413250 |             0.86 |
| Sri Lanka                        | November-2020  |          519494 |   21413250 |             2.43 |
| Sri Lanka                        | December-2020  |         1064723 |   21413250 |             4.97 |
| Sri Lanka                        | January-2021   |         1640683 |   21413250 |             7.66 |
| Sri Lanka                        | February-2021  |         2102971 |   21413250 |             9.82 |
| Sri Lanka                        | March-2021     |         2741305 |   21413250 |             12.8 |
| Sri Lanka                        | April-2021     |         2923063 |   21413250 |            13.65 |
| Sudan                            | March-2020     |              48 |   43849269 |                0 |
| Sudan                            | April-2020     |            2897 |   43849269 |             0.01 |
| Sudan                            | May-2020       |           71755 |   43849269 |             0.16 |
| Sudan                            | June-2020      |          221561 |   43849269 |             0.51 |
| Sudan                            | July-2020      |          327938 |   43849269 |             0.75 |
| Sudan                            | August-2020    |          385040 |   43849269 |             0.88 |
| Sudan                            | September-2020 |          404872 |   43849269 |             0.92 |
| Sudan                            | October-2020   |          424972 |   43849269 |             0.97 |
| Sudan                            | November-2020  |          459778 |   43849269 |             1.05 |
| Sudan                            | December-2020  |          686746 |   43849269 |             1.57 |
| Sudan                            | January-2021   |          860954 |   43849269 |             1.96 |
| Sudan                            | February-2021  |          838465 |   43849269 |             1.91 |
| Sudan                            | March-2021     |          959112 |   43849269 |             2.19 |
| Sudan                            | April-2021     |          982035 |   43849269 |             2.24 |
| Suriname                         | March-2020     |              88 |     586634 |             0.02 |
| Suriname                         | April-2020     |             300 |     586634 |             0.05 |
| Suriname                         | May-2020       |             342 |     586634 |             0.06 |
| Suriname                         | June-2020      |            7377 |     586634 |             1.26 |
| Suriname                         | July-2020      |           30514 |     586634 |              5.2 |
| Suriname                         | August-2020    |           92088 |     586634 |             15.7 |
| Suriname                         | September-2020 |          137565 |     586634 |            23.45 |
| Suriname                         | October-2020   |          157566 |     586634 |            26.86 |
| Suriname                         | November-2020  |          158057 |     586634 |            26.94 |
| Suriname                         | December-2020  |          172469 |     586634 |             29.4 |
| Suriname                         | January-2021   |          230537 |     586634 |             39.3 |
| Suriname                         | February-2021  |          245498 |     586634 |            41.85 |
| Suriname                         | March-2021     |          279961 |     586634 |            47.72 |
| Suriname                         | April-2021     |          287403 |     586634 |            48.99 |
| Sweden                           | February-2020  |              55 |   10099270 |                0 |
| Sweden                           | March-2020     |           47284 |   10099270 |             0.47 |
| Sweden                           | April-2020     |          391340 |   10099270 |             3.87 |
| Sweden                           | May-2020       |          938735 |   10099270 |              9.3 |
| Sweden                           | June-2020      |         1611074 |   10099270 |            15.95 |
| Sweden                           | July-2020      |         2280371 |   10099270 |            22.58 |
| Sweden                           | August-2020    |         2519171 |   10099270 |            24.94 |
| Sweden                           | September-2020 |         2632351 |   10099270 |            26.06 |
| Sweden                           | October-2020   |         3240753 |   10099270 |            32.09 |
| Sweden                           | November-2020  |         5546377 |   10099270 |            54.92 |
| Sweden                           | December-2020  |        10695430 |   10099270 |            105.9 |
| Sweden                           | January-2021   |        15946013 |   10099270 |           157.89 |
| Sweden                           | February-2021  |        17201658 |   10099270 |           170.33 |
| Sweden                           | March-2021     |        22569251 |   10099270 |           223.47 |
| Sweden                           | April-2021     |        26658585 |   10099270 |           263.97 |
| Switzerland                      | February-2020  |              36 |    8654618 |                0 |
| Switzerland                      | March-2020     |          155101 |    8654618 |             1.79 |
| Switzerland                      | April-2020     |          767858 |    8654618 |             8.87 |
| Switzerland                      | May-2020       |          943988 |    8654618 |            10.91 |
| Switzerland                      | June-2020      |          935609 |    8654618 |            10.81 |
| Switzerland                      | July-2020      |         1033677 |    8654618 |            11.94 |
| Switzerland                      | August-2020    |         1188157 |    8654618 |            13.73 |
| Switzerland                      | September-2020 |         1438863 |    8654618 |            16.63 |
| Switzerland                      | October-2020   |         2627252 |    8654618 |            30.36 |
| Switzerland                      | November-2020  |         7765995 |    8654618 |            89.73 |
| Switzerland                      | December-2020  |        12135482 |    8654618 |           140.22 |
| Switzerland                      | January-2021   |        15277220 |    8654618 |           176.52 |
| Switzerland                      | February-2021  |        15173740 |    8654618 |           175.33 |
| Switzerland                      | March-2021     |        17873268 |    8654618 |           206.52 |
| Switzerland                      | April-2021     |        18901590 |    8654618 |            218.4 |
| Syria                            | March-2020     |              52 |   17500657 |                0 |
| Syria                            | April-2020     |             921 |   17500657 |             0.01 |
| Syria                            | May-2020       |            2083 |   17500657 |             0.01 |
| Syria                            | June-2020      |            5546 |   17500657 |             0.03 |
| Syria                            | July-2020      |           15250 |   17500657 |             0.09 |
| Syria                            | August-2020    |           53007 |   17500657 |              0.3 |
| Syria                            | September-2020 |          107816 |   17500657 |             0.62 |
| Syria                            | October-2020   |          154191 |   17500657 |             0.88 |
| Syria                            | November-2020  |          203042 |   17500657 |             1.16 |
| Syria                            | December-2020  |          299051 |   17500657 |             1.71 |
| Syria                            | January-2021   |          399586 |   17500657 |             2.28 |
| Syria                            | February-2021  |          416099 |   17500657 |             2.38 |
| Syria                            | March-2021     |          525778 |   17500657 |                3 |
| Syria                            | April-2021     |          625640 |   17500657 |             3.57 |
| Taiwan                           | January-2020   |              52 |   23816775 |                0 |
| Taiwan                           | February-2020  |             616 |   23816775 |                0 |
| Taiwan                           | March-2020     |            3877 |   23816775 |             0.02 |
| Taiwan                           | April-2020     |           11888 |   23816775 |             0.05 |
| Taiwan                           | May-2020       |           13625 |   23816775 |             0.06 |
| Taiwan                           | June-2020      |           13341 |   23816775 |             0.06 |
| Taiwan                           | July-2020      |           14062 |   23816775 |             0.06 |
| Taiwan                           | August-2020    |           14954 |   23816775 |             0.06 |
| Taiwan                           | September-2020 |           15038 |   23816775 |             0.06 |
| Taiwan                           | October-2020   |           16593 |   23816775 |             0.07 |
| Taiwan                           | November-2020  |           18038 |   23816775 |             0.08 |
| Taiwan                           | December-2020  |           23118 |   23816775 |              0.1 |
| Taiwan                           | January-2021   |           26502 |   23816775 |             0.11 |
| Taiwan                           | February-2021  |           26198 |   23816775 |             0.11 |
| Taiwan                           | March-2021     |           30735 |   23816775 |             0.13 |
| Taiwan                           | April-2021     |           32190 |   23816775 |             0.14 |
| Tajikistan                       | April-2020     |              15 |    9537642 |                0 |
| Tajikistan                       | May-2020       |           51539 |    9537642 |             0.54 |
| Tajikistan                       | June-2020      |          152296 |    9537642 |              1.6 |
| Tajikistan                       | July-2020      |          208547 |    9537642 |             2.19 |
| Tajikistan                       | August-2020    |          249268 |    9537642 |             2.61 |
| Tajikistan                       | September-2020 |          275116 |    9537642 |             2.88 |
| Tajikistan                       | October-2020   |          322893 |    9537642 |             3.39 |
| Tajikistan                       | November-2020  |          348944 |    9537642 |             3.66 |
| Tajikistan                       | December-2020  |          396783 |    9537642 |             4.16 |
| Tajikistan                       | January-2021   |          412497 |    9537642 |             4.32 |
| Tajikistan                       | February-2021  |          372624 |    9537642 |             3.91 |
| Tajikistan                       | March-2021     |          412548 |    9537642 |             4.33 |
| Tajikistan                       | April-2021     |          399240 |    9537642 |             4.19 |
| Tanzania                         | March-2020     |             163 |   59734213 |                0 |
| Tanzania                         | April-2020     |            4575 |   59734213 |             0.01 |
| Tanzania                         | May-2020       |           15576 |   59734213 |             0.03 |
| Tanzania                         | June-2020      |           15270 |   59734213 |             0.03 |
| Tanzania                         | July-2020      |           15779 |   59734213 |             0.03 |
| Tanzania                         | August-2020    |           15779 |   59734213 |             0.03 |
| Tanzania                         | September-2020 |           15270 |   59734213 |             0.03 |
| Tanzania                         | October-2020   |           15779 |   59734213 |             0.03 |
| Tanzania                         | November-2020  |           15270 |   59734213 |             0.03 |
| Tanzania                         | December-2020  |           15779 |   59734213 |             0.03 |
| Tanzania                         | January-2021   |           15779 |   59734213 |             0.03 |
| Tanzania                         | February-2021  |           14252 |   59734213 |             0.02 |
| Tanzania                         | March-2021     |           15779 |   59734213 |             0.03 |
| Tanzania                         | April-2021     |           15270 |   59734213 |             0.03 |
| Thailand                         | January-2020   |              96 |   69799978 |                0 |
| Thailand                         | February-2020  |             933 |   69799978 |                0 |
| Thailand                         | March-2020     |           13480 |   69799978 |             0.02 |
| Thailand                         | April-2020     |           77098 |   69799978 |             0.11 |
| Thailand                         | May-2020       |           93701 |   69799978 |             0.13 |
| Thailand                         | June-2020      |           93991 |   69799978 |             0.13 |
| Thailand                         | July-2020      |          100363 |   69799978 |             0.14 |
| Thailand                         | August-2020    |          104473 |   69799978 |             0.15 |
| Thailand                         | September-2020 |          104554 |   69799978 |             0.15 |
| Thailand                         | October-2020   |          114072 |   69799978 |             0.16 |
| Thailand                         | November-2020  |          116509 |   69799978 |             0.17 |
| Thailand                         | December-2020  |          154099 |   69799978 |             0.22 |
| Thailand                         | January-2021   |          380681 |   69799978 |             0.55 |
| Thailand                         | February-2021  |          680096 |   69799978 |             0.97 |
| Thailand                         | March-2021     |          847502 |   69799978 |             1.21 |
| Thailand                         | April-2021     |         1243742 |   69799978 |             1.78 |
| Timor                            | March-2020     |              10 |    1318442 |                0 |
| Timor                            | April-2020     |             365 |    1318442 |             0.03 |
| Timor                            | May-2020       |             744 |    1318442 |             0.06 |
| Timor                            | June-2020      |             720 |    1318442 |             0.05 |
| Timor                            | July-2020      |             744 |    1318442 |             0.06 |
| Timor                            | August-2020    |             787 |    1318442 |             0.06 |
| Timor                            | September-2020 |             812 |    1318442 |             0.06 |
| Timor                            | October-2020   |             894 |    1318442 |             0.07 |
| Timor                            | November-2020  |             900 |    1318442 |             0.07 |
| Timor                            | December-2020  |            1054 |    1318442 |             0.08 |
| Timor                            | January-2021   |            1705 |    1318442 |             0.13 |
| Timor                            | February-2021  |            2678 |    1318442 |              0.2 |
| Timor                            | March-2021     |            8190 |    1318442 |             0.62 |
| Timor                            | April-2021     |           38592 |    1318442 |             2.93 |
| Togo                             | March-2020     |             278 |    8278737 |                0 |
| Togo                             | April-2020     |            2313 |    8278737 |             0.03 |
| Togo                             | May-2020       |            8434 |    8278737 |              0.1 |
| Togo                             | June-2020      |           16202 |    8278737 |              0.2 |
| Togo                             | July-2020      |           23804 |    8278737 |             0.29 |
| Togo                             | August-2020    |           36091 |    8278737 |             0.44 |
| Togo                             | September-2020 |           48078 |    8278737 |             0.58 |
| Togo                             | October-2020   |           63293 |    8278737 |             0.76 |
| Togo                             | November-2020  |           80374 |    8278737 |             0.97 |
| Togo                             | December-2020  |          102862 |    8278737 |             1.24 |
| Togo                             | January-2021   |          132772 |    8278737 |              1.6 |
| Togo                             | February-2021  |          166043 |    8278737 |             2.01 |
| Togo                             | March-2021     |          262504 |    8278737 |             3.17 |
| Togo                             | April-2021     |          364486 |    8278737 |              4.4 |
| Tonga                            | April-2021     |               0 |     105697 |                0 |
| Trinidad and Tobago              | March-2020     |             757 |    1399491 |             0.05 |
| Trinidad and Tobago              | April-2020     |            3315 |    1399491 |             0.24 |
| Trinidad and Tobago              | May-2020       |            3598 |    1399491 |             0.26 |
| Trinidad and Tobago              | June-2020      |            3629 |    1399491 |             0.26 |
| Trinidad and Tobago              | July-2020      |            4310 |    1399491 |             0.31 |
| Trinidad and Tobago              | August-2020    |           22008 |    1399491 |             1.57 |
| Trinidad and Tobago              | September-2020 |           98238 |    1399491 |             7.02 |
| Trinidad and Tobago              | October-2020   |          161320 |    1399491 |            11.53 |
| Trinidad and Tobago              | November-2020  |          184145 |    1399491 |            13.16 |
| Trinidad and Tobago              | December-2020  |          214764 |    1399491 |            15.35 |
| Trinidad and Tobago              | January-2021   |          228015 |    1399491 |            16.29 |
| Trinidad and Tobago              | February-2021  |          214119 |    1399491 |             15.3 |
| Trinidad and Tobago              | March-2021     |          242510 |    1399491 |            17.33 |
| Trinidad and Tobago              | April-2021     |          267657 |    1399491 |            19.13 |
| Tunisia                          | March-2020     |            2476 |   11818618 |             0.02 |
| Tunisia                          | April-2020     |           23056 |   11818618 |              0.2 |
| Tunisia                          | May-2020       |           32212 |   11818618 |             0.27 |
| Tunisia                          | June-2020      |           33677 |   11818618 |             0.28 |
| Tunisia                          | July-2020      |           41174 |   11818618 |             0.35 |
| Tunisia                          | August-2020    |           72295 |   11818618 |             0.61 |
| Tunisia                          | September-2020 |          273502 |   11818618 |             2.31 |
| Tunisia                          | October-2020   |         1173458 |   11818618 |             9.93 |
| Tunisia                          | November-2020  |         2394119 |   11818618 |            20.26 |
| Tunisia                          | December-2020  |         3603614 |   11818618 |            30.49 |
| Tunisia                          | January-2021   |         5450840 |   11818618 |            46.12 |
| Tunisia                          | February-2021  |         6240176 |   11818618 |             52.8 |
| Tunisia                          | March-2021     |         7531509 |   11818618 |            63.73 |
| Tunisia                          | April-2021     |         8436921 |   11818618 |            71.39 |
| Turkey                           | March-2020     |           58776 |   84339067 |             0.07 |
| Turkey                           | April-2020     |         2098207 |   84339067 |             2.49 |
| Turkey                           | May-2020       |         4521709 |   84339067 |             5.36 |
| Turkey                           | June-2020      |         5429570 |   84339067 |             6.44 |
| Turkey                           | July-2020      |         6712753 |   84339067 |             7.96 |
| Turkey                           | August-2020    |         7744882 |   84339067 |             9.18 |
| Turkey                           | September-2020 |         8864996 |   84339067 |            10.51 |
| Turkey                           | October-2020   |        10707361 |   84339067 |             12.7 |
| Turkey                           | November-2020  |        13199045 |   84339067 |            15.65 |
| Turkey                           | December-2020  |        51443548 |   84339067 |               61 |
| Turkey                           | January-2021   |        73376598 |   84339067 |               87 |
| Turkey                           | February-2021  |        72545924 |   84339067 |            86.02 |
| Turkey                           | March-2021     |        91423494 |   84339067 |            108.4 |
| Turkey                           | April-2021     |       123292520 |   84339067 |           146.19 |
| Turks and Caicos Islands         | January-2021   |               0 |      38718 |                0 |
| Turks and Caicos Islands         | February-2021  |               0 |      38718 |                0 |
| Turks and Caicos Islands         | March-2021     |               0 |      38718 |                0 |
| Turks and Caicos Islands         | April-2021     |               0 |      38718 |                0 |
| Uganda                           | March-2020     |             211 |   45741000 |                0 |
| Uganda                           | April-2020     |            1797 |   45741000 |                0 |
| Uganda                           | May-2020       |            5937 |   45741000 |             0.01 |
| Uganda                           | June-2020      |           21150 |   45741000 |             0.05 |
| Uganda                           | July-2020      |           32169 |   45741000 |             0.07 |
| Uganda                           | August-2020    |           54950 |   45741000 |             0.12 |
| Uganda                           | September-2020 |          161746 |   45741000 |             0.35 |
| Uganda                           | October-2020   |          320818 |   45741000 |              0.7 |
| Uganda                           | November-2020  |          489403 |   45741000 |             1.07 |
| Uganda                           | December-2020  |          882278 |   45741000 |             1.93 |
| Uganda                           | January-2021   |         1179121 |   45741000 |             2.58 |
| Uganda                           | February-2021  |         1120741 |   45741000 |             2.45 |
| Uganda                           | March-2021     |         1258743 |   45741000 |             2.75 |
| Uganda                           | April-2021     |         1239637 |   45741000 |             2.71 |
| Ukraine                          | March-2020     |            3064 |   43733759 |             0.01 |
| Ukraine                          | April-2020     |          137421 |   43733759 |             0.31 |
| Ukraine                          | May-2020       |          543592 |   43733759 |             1.24 |
| Ukraine                          | June-2020      |         1011298 |   43733759 |             2.31 |
| Ukraine                          | July-2020      |         1797522 |   43733759 |             4.11 |
| Ukraine                          | August-2020    |         2952987 |   43733759 |             6.75 |
| Ukraine                          | September-2020 |         5019534 |   43733759 |            11.48 |
| Ukraine                          | October-2020   |         9292272 |   43733759 |            21.25 |
| Ukraine                          | November-2020  |        16972054 |   43733759 |            38.81 |
| Ukraine                          | December-2020  |        29178756 |   43733759 |            66.72 |
| Ukraine                          | January-2021   |        36713095 |   43733759 |            83.95 |
| Ukraine                          | February-2021  |        37009908 |   43733759 |            84.63 |
| Ukraine                          | March-2021     |        47885644 |   43733759 |           109.49 |
| Ukraine                          | April-2021     |        58596168 |   43733759 |           133.98 |
| United Arab Emirates             | January-2020   |              12 |    9890400 |                0 |
| United Arab Emirates             | February-2020  |             268 |    9890400 |                0 |
| United Arab Emirates             | March-2020     |            5515 |    9890400 |             0.06 |
| United Arab Emirates             | April-2020     |          175824 |    9890400 |             1.78 |
| United Arab Emirates             | May-2020       |          718686 |    9890400 |             7.27 |
| United Arab Emirates             | June-2020      |         1274693 |    9890400 |            12.89 |
| United Arab Emirates             | July-2020      |         1724036 |    9890400 |            17.43 |
| United Arab Emirates             | August-2020    |         2009206 |    9890400 |            20.31 |
| United Arab Emirates             | September-2020 |         2450597 |    9890400 |            24.78 |
| United Arab Emirates             | October-2020   |         3511783 |    9890400 |            35.51 |
| United Arab Emirates             | November-2020  |         4535051 |    9890400 |            45.85 |
| United Arab Emirates             | December-2020  |         5847851 |    9890400 |            59.13 |
| United Arab Emirates             | January-2021   |         7811891 |    9890400 |            78.98 |
| United Arab Emirates             | February-2021  |         9796313 |    9890400 |            99.05 |
| United Arab Emirates             | March-2021     |        13316657 |    9890400 |           134.64 |
| United Arab Emirates             | April-2021     |        14769790 |    9890400 |           149.33 |
| United Kingdom                   | January-2020   |               2 |   67886004 |                0 |
| United Kingdom                   | February-2020  |             606 |   67886004 |                0 |
| United Kingdom                   | March-2020     |          283199 |   67886004 |             0.42 |
| United Kingdom                   | April-2020     |         3328344 |   67886004 |              4.9 |
| United Kingdom                   | May-2020       |         7016710 |   67886004 |            10.34 |
| United Kingdom                   | June-2020      |         8213357 |   67886004 |             12.1 |
| United Kingdom                   | July-2020      |         9120400 |   67886004 |            13.43 |
| United Kingdom                   | August-2020    |         9933759 |   67886004 |            14.63 |
| United Kingdom                   | September-2020 |        11564506 |   67886004 |            17.04 |
| United Kingdom                   | October-2020   |        22002570 |   67886004 |            32.41 |
| United Kingdom                   | November-2020  |        40830975 |   67886004 |            60.15 |
| United Kingdom                   | December-2020  |        61365366 |   67886004 |            90.39 |
| United Kingdom                   | January-2021   |       102180395 |   67886004 |           150.52 |
| United Kingdom                   | February-2021  |       113211684 |   67886004 |           166.77 |
| United Kingdom                   | March-2021     |       132721966 |   67886004 |           195.51 |
| United Kingdom                   | April-2021     |       131952179 |   67886004 |           194.37 |
| United States                    | January-2020   |              41 |  331002647 |                0 |
| United States                    | February-2020  |             402 |  331002647 |                0 |
| United States                    | March-2020     |         1120122 |  331002647 |             0.34 |
| United States                    | April-2020     |        19959287 |  331002647 |             6.03 |
| United States                    | May-2020       |        45533906 |  331002647 |            13.76 |
| United States                    | June-2020      |        64964762 |  331002647 |            19.63 |
| United States                    | July-2020      |       111371152 |  331002647 |            33.65 |
| United States                    | August-2020    |       166357378 |  331002647 |            50.26 |
| United States                    | September-2020 |       199220181 |  331002647 |            60.19 |
| United States                    | October-2020   |       251406215 |  331002647 |            75.95 |
| United States                    | November-2020  |       339796331 |  331002647 |           102.66 |
| United States                    | December-2020  |       528139775 |  331002647 |           159.56 |
| United States                    | January-2021   |       730894746 |  331002647 |           220.81 |
| United States                    | February-2021  |       774254261 |  331002647 |           233.91 |
| United States                    | March-2021     |       916643837 |  331002647 |           276.93 |
| United States                    | April-2021     |       944543693 |  331002647 |           285.36 |
| Uruguay                          | March-2020     |            3023 |    3473727 |             0.09 |
| Uruguay                          | April-2020     |           15144 |    3473727 |             0.44 |
| Uruguay                          | May-2020       |           22718 |    3473727 |             0.65 |
| Uruguay                          | June-2020      |           25962 |    3473727 |             0.75 |
| Uruguay                          | July-2020      |           32857 |    3473727 |             0.95 |
| Uruguay                          | August-2020    |           44615 |    3473727 |             1.28 |
| Uruguay                          | September-2020 |           55050 |    3473727 |             1.58 |
| Uruguay                          | October-2020   |           77922 |    3473727 |             2.24 |
| Uruguay                          | November-2020  |          125784 |    3473727 |             3.62 |
| Uruguay                          | December-2020  |          358979 |    3473727 |            10.33 |
| Uruguay                          | January-2021   |          960688 |    3473727 |            27.66 |
| Uruguay                          | February-2021  |         1383421 |    3473727 |            39.83 |
| Uruguay                          | March-2021     |         2381456 |    3473727 |            68.56 |
| Uruguay                          | April-2021     |         4664168 |    3473727 |           134.27 |
| Uzbekistan                       | March-2020     |            1062 |   33469199 |                0 |
| Uzbekistan                       | April-2020     |           35053 |   33469199 |              0.1 |
| Uzbekistan                       | May-2020       |           85596 |   33469199 |             0.26 |
| Uzbekistan                       | June-2020      |          168606 |   33469199 |              0.5 |
| Uzbekistan                       | July-2020      |          479255 |   33469199 |             1.43 |
| Uzbekistan                       | August-2020    |         1068133 |   33469199 |             3.19 |
| Uzbekistan                       | September-2020 |         1468909 |   33469199 |             4.39 |
| Uzbekistan                       | October-2020   |         1935712 |   33469199 |             5.78 |
| Uzbekistan                       | November-2020  |         2106636 |   33469199 |             6.29 |
| Uzbekistan                       | December-2020  |         2334877 |   33469199 |             6.98 |
| Uzbekistan                       | January-2021   |         2415594 |   33469199 |             7.22 |
| Uzbekistan                       | February-2021  |         2222824 |   33469199 |             6.64 |
| Uzbekistan                       | March-2021     |         2511079 |   33469199 |              7.5 |
| Uzbekistan                       | April-2021     |         2590272 |   33469199 |             7.74 |
| Vanuatu                          | November-2020  |              21 |     307150 |             0.01 |
| Vanuatu                          | December-2020  |              31 |     307150 |             0.01 |
| Vanuatu                          | January-2021   |              31 |     307150 |             0.01 |
| Vanuatu                          | February-2021  |              28 |     307150 |             0.01 |
| Vanuatu                          | March-2021     |              79 |     307150 |             0.03 |
| Vanuatu                          | April-2021     |             100 |     307150 |             0.03 |
| Vatican                          | March-2020     |              58 |        809 |             7.17 |
| Vatican                          | April-2020     |             247 |        809 |            30.53 |
| Vatican                          | May-2020       |             367 |        809 |            45.36 |
| Vatican                          | June-2020      |             360 |        809 |             44.5 |
| Vatican                          | July-2020      |             372 |        809 |            45.98 |
| Vatican                          | August-2020    |             372 |        809 |            45.98 |
| Vatican                          | September-2020 |             360 |        809 |             44.5 |
| Vatican                          | October-2020   |             646 |        809 |            79.85 |
| Vatican                          | November-2020  |             810 |        809 |           100.12 |
| Vatican                          | December-2020  |             837 |        809 |           103.46 |
| Vatican                          | January-2021   |             837 |        809 |           103.46 |
| Vatican                          | February-2021  |             756 |        809 |            93.45 |
| Vatican                          | March-2021     |             837 |        809 |           103.46 |
| Vatican                          | April-2021     |             810 |        809 |           100.12 |
| Venezuela                        | March-2020     |            1296 |   28435943 |                0 |
| Venezuela                        | April-2020     |            6845 |   28435943 |             0.02 |
| Venezuela                        | May-2020       |           22391 |   28435943 |             0.08 |
| Venezuela                        | June-2020      |          101886 |   28435943 |             0.36 |
| Venezuela                        | July-2020      |          349975 |   28435943 |             1.23 |
| Venezuela                        | August-2020    |         1023744 |   28435943 |              3.6 |
| Venezuela                        | September-2020 |         1870624 |   28435943 |             6.58 |
| Venezuela                        | October-2020   |         2638216 |   28435943 |             9.28 |
| Venezuela                        | November-2020  |         2924109 |   28435943 |            10.28 |
| Venezuela                        | December-2020  |         3361140 |   28435943 |            11.82 |
| Venezuela                        | January-2021   |         3711664 |   28435943 |            13.05 |
| Venezuela                        | February-2021  |         3732780 |   28435943 |            13.13 |
| Venezuela                        | March-2021     |         4592207 |   28435943 |            16.15 |
| Venezuela                        | April-2021     |         5402012 |   28435943 |               19 |
| Vietnam                          | January-2020   |              18 |   97338583 |                0 |
| Vietnam                          | February-2020  |             398 |   97338583 |                0 |
| Vietnam                          | March-2020     |            2514 |   97338583 |                0 |
| Vietnam                          | April-2020     |            7778 |   97338583 |             0.01 |
| Vietnam                          | May-2020       |            9465 |   97338583 |             0.01 |
| Vietnam                          | June-2020      |           10196 |   97338583 |             0.01 |
| Vietnam                          | July-2020      |           12278 |   97338583 |             0.01 |
| Vietnam                          | August-2020    |           28091 |   97338583 |             0.03 |
| Vietnam                          | September-2020 |           31897 |   97338583 |             0.03 |
| Vietnam                          | October-2020   |           35048 |   97338583 |             0.04 |
| Vietnam                          | November-2020  |           38113 |   97338583 |             0.04 |
| Vietnam                          | December-2020  |           43541 |   97338583 |             0.04 |
| Vietnam                          | January-2021   |           48059 |   97338583 |             0.05 |
| Vietnam                          | February-2021  |           61812 |   97338583 |             0.06 |
| Vietnam                          | March-2021     |           78997 |   97338583 |             0.08 |
| Vietnam                          | April-2021     |           82567 |   97338583 |             0.08 |
| Yemen                            | April-2020     |              31 |   29825968 |                0 |
| Yemen                            | May-2020       |            4101 |   29825968 |             0.01 |
| Yemen                            | June-2020      |           23264 |   29825968 |             0.08 |
| Yemen                            | July-2020      |           46644 |   29825968 |             0.16 |
| Yemen                            | August-2020    |           57598 |   29825968 |             0.19 |
| Yemen                            | September-2020 |           60327 |   29825968 |              0.2 |
| Yemen                            | October-2020   |           63654 |   29825968 |             0.21 |
| Yemen                            | November-2020  |           62038 |   29825968 |             0.21 |
| Yemen                            | December-2020  |           64649 |   29825968 |             0.22 |
| Yemen                            | January-2021   |           65439 |   29825968 |             0.22 |
| Yemen                            | February-2021  |           60549 |   29825968 |              0.2 |
| Yemen                            | March-2021     |           96700 |   29825968 |             0.32 |
| Yemen                            | April-2021     |          167368 |   29825968 |             0.56 |
| Zambia                           | March-2020     |             194 |   18383956 |                0 |
| Zambia                           | April-2020     |            1754 |   18383956 |             0.01 |
| Zambia                           | May-2020       |           18622 |   18383956 |              0.1 |
| Zambia                           | June-2020      |           40038 |   18383956 |             0.22 |
| Zambia                           | July-2020      |           90582 |   18383956 |             0.49 |
| Zambia                           | August-2020    |          290970 |   18383956 |             1.58 |
| Zambia                           | September-2020 |          410862 |   18383956 |             2.23 |
| Zambia                           | October-2020   |          486509 |   18383956 |             2.65 |
| Zambia                           | November-2020  |          514878 |   18383956 |              2.8 |
| Zambia                           | December-2020  |          579474 |   18383956 |             3.15 |
| Zambia                           | January-2021   |         1112407 |   18383956 |             6.05 |
| Zambia                           | February-2021  |         1923634 |   18383956 |            10.46 |
| Zambia                           | March-2021     |         2627072 |   18383956 |            14.29 |
| Zambia                           | April-2021     |         2711129 |   18383956 |            14.75 |
| Zimbabwe                         | March-2020     |              53 |   14862927 |                0 |
| Zimbabwe                         | April-2020     |             618 |   14862927 |                0 |
| Zimbabwe                         | May-2020       |            1871 |   14862927 |             0.01 |
| Zimbabwe                         | June-2020      |           12096 |   14862927 |             0.08 |
| Zimbabwe                         | July-2020      |           48113 |   14862927 |             0.32 |
| Zimbabwe                         | August-2020    |          163293 |   14862927 |              1.1 |
| Zimbabwe                         | September-2020 |          223571 |   14862927 |              1.5 |
| Zimbabwe                         | October-2020   |          251343 |   14862927 |             1.69 |
| Zimbabwe                         | November-2020  |          268984 |   14862927 |             1.81 |
| Zimbabwe                         | December-2020  |          366341 |   14862927 |             2.46 |
| Zimbabwe                         | January-2021   |          787416 |   14862927 |              5.3 |
| Zimbabwe                         | February-2021  |          984049 |   14862927 |             6.62 |
| Zimbabwe                         | March-2021     |         1132264 |   14862927 |             7.62 |
| Zimbabwe                         | April-2021     |         1126565 |   14862927 |             7.58 |


