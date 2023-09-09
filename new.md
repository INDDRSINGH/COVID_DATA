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


**Query : Percentage of people died in a month, out of number of cases reported in each month**


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
