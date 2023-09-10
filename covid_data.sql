USE covid_data;

-- After uploading the data from CSV file, date format was auto-changed to VARCHAR. Testing to Changing it again to DATE data type.
SELECT date_format(str_to_date(date, '%m/%d/%Y'), '%Y-%m-%d')
FROM covid_death ;

-- Set safe updates OFF. SET SQL_SAFE_UPDATES = 0

-- Updating COVID_DEATH table to change the "date" column from VARCHAR to DATE format and other columns from VARCHAR TO INT

update covid_death set date = date_format(str_to_date(date, '%m/%d/%Y'), '%Y-%m-%d');
update covid_death set new_deaths = new_deaths*1;
update covid_death set icu_patients = icu_patients*1;
update covid_death set new_tests = new_tests*1;
update covid_death set total_tests = total_tests*1;
update covid_death set total_vaccinations = total_vaccinations*1;
update covid_death set people_fully_vaccinated = people_fully_vaccinated*1;

-- Updating COVID_VACCINATIONS table to change the "date" column from VARCHAR to DATE format and other columns from VARCHAR TO INT
update covid_vaccinations set date = date_format(str_to_date(date, '%m/%d/%Y'), '%Y-%m-%d');
update covid_vaccinations set new_tests = new_tests*1;
update covid_vaccinations set total_tests = total_tests*1;
update covid_vaccinations set total_vaccinations = total_vaccinations*1;
update covid_vaccinations set people_fully_vaccinated = people_fully_vaccinated*1;
update covid_vaccinations set new_vaccinations = new_vaccinations*1;

-- Altering the COVID_DEATH table to change table's "date" column from VARCHAR to DATE data type and other columns from VARCHAR to INT.
alter table covid_death change date date date,
CHANGE COLUMN `new_deaths` `new_deaths` INT NULL DEFAULT NULL, 
CHANGE COLUMN `icu_patients` `icu_patients` INT NULL DEFAULT NULL ,
CHANGE COLUMN `new_tests` `new_tests` INT NULL DEFAULT NULL ,
CHANGE COLUMN `total_tests` `total_tests` INT NULL DEFAULT NULL,
CHANGE COLUMN `total_vaccinations` `total_vaccinations` INT NULL DEFAULT NULL,
CHANGE COLUMN `people_fully_vaccinated` `people_fully_vaccinated` INT NULL DEFAULT NULL;

-- Altering the COVID_VACCINATIONS table to change table's "date" column from VARCHAR to DATE data type and other columns from VARCHAR to INT.
alter table covid_vaccinations change date date date,
CHANGE COLUMN `new_tests` `new_tests` INT NULL DEFAULT NULL, 
CHANGE COLUMN `total_tests` `total_tests` INT NULL DEFAULT NULL ,
CHANGE COLUMN `total_vaccinations` `total_vaccinations` INT NULL DEFAULT NULL ,
CHANGE COLUMN `people_fully_vaccinated` `people_fully_vaccinated` INT NULL DEFAULT NULL,
CHANGE COLUMN `new_vaccinations` `new_vaccinations` INT NULL DEFAULT NULL;


--  Total deaths and cases reported in each country.

select location, sum(new_deaths) as Total_deaths, sum(new_cases) as Total_cases
from covid_death
group by location
order by total_deaths desc,Total_cases desc
limit 15;	


-- 1 Percentage of people died in a month, out of number of cases reported in each month
select *, round((sum_total_deaths/sum_total_cases)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year, 
sum(new_deaths) as sum_total_deaths, sum(total_cases) as sum_total_cases
from covid_death
group by Month_year, Location
) e ;

-- 2  Percentage of people diagnosed in a month, out of total population 
select *,round((sum_total_cases/population)*100,2) as Death_Percentage
from (
select Location, date_format(date,"%M-%Y") as Month_year, 
sum(total_cases) as sum_total_cases , max(population) as population
from covid_death
group by Month_year, Location
) e ;

-- 3 Countries with highest percentage of Infection rate, compaared to country's population

select *, round((Total_cases/population)*100,2) as Percentage_infected 
from (
select location, sum(new_cases) as Total_cases, max(population) as population
from covid_death
group by location
) e
order by  Percentage_infected desc
;

-- 4  Countries with highest percentage of death rate, compared to country's total cases reported.

select *, round((Total_deaths/Total_cases)*100,2) as Percentage_died
from (
select location, sum(new_deaths) as Total_deaths, sum(new_cases) as Total_cases
from covid_death
group by location
) e
order by Percentage_died desc;

-- 5 Showing global cases, month wise

select *,  round((deaths/cases_reported)*100,2) as percentage_died
from (
select date_format(date,"%M-%Y") as date_mm,max(new_deaths) as deaths, max(total_cases) cases_reported
from covid_death
group by date_mm
) q;	

-- 6 Percentage of number of people vaccinated in entire population.
with PopVsVac as (
select d.location, max(d.population) as population, max(v.people_fully_vaccinated) as total_vaccinated
from covid_death d
join covid_vaccinations v
on d.location = v.location and d.date = v.date
group by d.location
)
select *, round((total_vaccinated/population)*100,2) as Percent_vaccinated
from PopVsVac 
order by Percent_vaccinated desc;


-- 7  Created stored procedure with input as country name, to see the number of deaths and vaccination happened in each month.
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

CALL vaccination_trend('India');
CALL vaccination_trend('Australia');
CALL vaccination_trend('united states');

-- 8 checking if there is any correlation of number of cases report with population density and GDP of a country.
select location, max(total_cases) as cases_reported, max(population_density) as population_density, max(gdp_per_capita) as GDP
from covid_death
group by location
order by cases_reported desc, population_density desc;


-- representing month-wise number of cases reported with countries in rows and months in columns
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
group by location; 

-- representing month-wise number of deaths reported with countries in rows and months in columns
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
group by location; 


