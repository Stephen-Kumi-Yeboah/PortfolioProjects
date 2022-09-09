##COVID-19 ANALYSIS OF WEST AFRICAN COUNTRIES

## Summary of the datatype of the columns
desc coviddeaths_westafrica;
desc covidvaccinations_westafrica;

##Changing the datatype of the "Date" column to date datatype
##1. Changing the format of the default date format in MySQL (yyyy-mm-dd)
update coviddeaths_westafrica
set date=str_to_date(date, '%d/%m/%Y');

update covidvaccinations_westafrica
set date=str_to_date(date, '%d/%m/%Y');

##2. 
ALTER TABLE coviddeaths_westafrica
modify date date;

ALTER TABLE covidvaccinations_westafrica
modify date date;

##List of West African Countries in the dataset
Select Location from coviddeaths_westafrica
Group by Location;

##Period covered in the dataset
Select min(date) as 'Start Date', max(date) as 'End Date'
From coviddeaths_westafrica;

##Total Cases and Total Death per day for each West African Country
SELECT Continent, Location, Population, Date, Total_Cases, Total_Deaths
FROM coviddeaths_westafrica
Order by location, date;

##Total Cases vs Total Deaths
SELECT Continent, Location, Date, Total_Cases, Total_Deaths, (Total_Deaths/Total_cases)*100 as DeathPercentage
FROM coviddeaths_westafrica
Order by location, date;

##Total Cases vs Population
##Percentage of Population who got Covid
SELECT Continent, Location, Date, Population, Total_Cases, (total_cases/population)*100  as Daily_PopulationInfected
FROM coviddeaths_westafrica
Order by location, date;

##Countries with Highest Infection Rate
SELECT Continent, Location, Population, max(total_cases) as TotalInfectionCount , max((total_cases/population))*100 as PercentagePopulationInfected
FROM coviddeaths_westafrica
GROUP BY continent, location, population
Order by PercentagePopulationInfected desc;

##Countries with Highest Death Count
SELECT Continent, Location, Population, max(total_deaths) as TotalDeathCountPerCountry
FROM coviddeaths_westafrica
GROUP BY continent, Location
Order by TotalDeathCountPerCountry desc;

##Death Rate per Country
SELECT Continent, Location, Population, max(total_deaths) as TotalDeathCountPerCountry, 
(max(total_deaths)/Population)*100 as DeathRatePerCountry
FROM coviddeaths_westafrica
GROUP BY continent, Location
Order by TotalDeathCountPerCountry desc;

##Total Population vs Vaccinations
Select dea.location, dea.population, vac.total_vaccinations
From coviddeaths_westafrica as dea
	Join covidvaccinations_westafrica as vac
    on dea.location=vac.location
Group by location;

##Total Vaccinations made in the period per Country
Select Location, Sum(total_vaccinations) as TotalVaccinations
From covidvaccinations_westafrica
Group by Location;

##Creating Views for visualization
CREATE VIEW  West_African_Countries_In_Dataset as
Select Location from coviddeaths_westafrica
Group by Location;

CREATE VIEW  Total_CasesVsTotal_Death_per_day as
SELECT Continent, Location, Population, Date, Total_Cases, Total_Deaths
FROM coviddeaths_westafrica
Order by location, date;

CREATE VIEW  DeathPercentage_per_day as    
SELECT Continent, Location, Date, Total_Cases, Total_Deaths, (Total_Deaths/Total_cases)*100 as DeathPercentage
FROM coviddeaths_westafrica
Order by location, date;

CREATE VIEW Daily_PopulationInfected as 
SELECT Continent, Location, Date, Population, Total_Cases, (total_cases/population)*100  as Daily_PopulationInfected
FROM coviddeaths_westafrica
Order by location, date;

CREATE VIEW Percentage_Population_Infected as
SELECT Continent, Location, Population, max(total_cases) as TotalInfectionCount , max((total_cases/population))*100 as PercentagePopulationInfected
FROM coviddeaths_westafrica
GROUP BY continent, location, population
Order by PercentagePopulationInfected desc;

CREATE VIEW TotalDeathCountPerCountry as
SELECT Continent, Location, Population, max(total_deaths) as TotalDeathCountPerCountry
FROM coviddeaths_westafrica
GROUP BY continent, Location
Order by TotalDeathCountPerCountry desc;

CREATE VIEW DeathRatePerCountry as
SELECT Continent, Location, Population, max(total_deaths) as TotalDeathCountPerCountry, 
(max(total_deaths)/Population)*100 as DeathRatePerCountry
FROM coviddeaths_westafrica
GROUP BY continent, Location
Order by TotalDeathCountPerCountry desc;

CREATE VIEW Total_Vaccinations as
Select Location, Sum(total_vaccinations) as TotalVaccinations
From covidvaccinations_westafrica
Group by Location;


