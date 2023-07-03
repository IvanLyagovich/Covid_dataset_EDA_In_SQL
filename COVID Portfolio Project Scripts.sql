SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2



-- Looking at Total Cases vs Total Deaths
-- Show likelihood of dying if you contract covid in the US

SELECT location, date, total_cases, total_deaths, (CAST(total_deaths as float)/CAST(total_cases as float))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE LOCATION LIKE '%states%'
ORDER BY 1,2



-- Shows timeline of what percentage of population in US got Covid

SELECT location, CAST(Population AS NUMERIC(18,2)) AS Population, total_cases, (CAST(total_cases AS FLOAT) / CAST(Population AS FLOAT)) * 100 AS CasePercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%' AND Population > 10000000 AND total_cases >= 464 -- exclude rows with total_cases less than 464 
ORDER BY 1,2



--Looking at the countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentagePopulationInfected desc



-- Showing countries with highest death count per population

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount desc



-- Break down by continent

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount desc



-- Showing continents with the highest death count per population 

SELECT location, population, MAX(total_deaths) AS DeathCount, MAX(([total_deaths]/population))*1000000 AS DeathsPerMillion
FROM PortfolioProject..CovidDeaths
WHERE continent is null and location NOT IN('Lower middle income', 'Upper middle income', 'High income', 'European Union', 'Low income', 'world')
GROUP BY location, population
ORDER BY DeathsPerMillion desc



-- Global numbers

SELECT 
       SUM(new_cases) AS total_cases, 
       SUM(CAST(new_deaths AS INT)) AS total_deaths, 
       100 * SUM(CAST(new_deaths AS INT)) / NULLIF(SUM(New_Cases), 0) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;



-- Looking at total population vs vaccinations timeline

SELECT  DEA.continent, DEA.location, DEA.date,  DEA.population, VAC.new_vaccinations,
SUM(CAST(VAC.new_vaccinations AS BIGINT)) OVER (PARTITION BY DEA.location ORDER BY DEA.location, DEA.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths AS DEA
JOIN PortfolioProject..CovidVaccinations AS VAC
   ON DEA.location = VAC.location
   AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
ORDER BY 2, 3 ;


-- Looking at total population vs vaccinations timeline with percent vaccinated column

WITH PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated, PercentVaccinated)
AS

(
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CAST(VAC.new_vaccinations AS BIGINT)) OVER (PARTITION BY DEA.location ORDER BY DEA.location, DEA.Date) AS RollingPeopleVaccinated,
(SUM(CAST(VAC.new_vaccinations AS BIGINT)) OVER (PARTITION BY DEA.location ORDER BY DEA.location, DEA.Date)/DEA.population)*100 AS PercentVaccinated
FROM PortfolioProject..CovidDeaths AS DEA
JOIN PortfolioProject..CovidVaccinations AS VAC
ON DEA.location = VAC.location
AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
)

SELECT Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated, PercentVaccinated
FROM PopvsVac;



-- Creating a view to store data for later visualizations


DROP VIEW IF EXISTS PercentPeopleVaccinated;
GO
CREATE VIEW PercentPeopleVaccinated AS
SELECT  DEA.continent, DEA.location, DEA.date,  DEA.population, VAC.new_vaccinations,
SUM(CAST(VAC.new_vaccinations AS BIGINT)) OVER (PARTITION BY DEA.location ORDER BY DEA.location, DEA.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths AS DEA
JOIN PortfolioProject..CovidVaccinations AS VAC
   ON DEA.location = VAC.location
   AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL;


