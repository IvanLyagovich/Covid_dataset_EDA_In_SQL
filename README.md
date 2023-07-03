## README for the SQL File

This SQL file contains a series of queries performed on the "CovidDeaths" and "CovidVaccinations" tables within the "PortfolioProject" database. The purpose of these queries is to analyze COVID-19 data and calculate various statistics. Here is a brief overview of each section:

1. **Filtering and Ordering:**
   - Retrieves all rows from the "CovidDeaths" table where the "continent" column is not null and orders the results by the third and fourth columns.

2. **Basic Data Selection and Ordering:**
   - Retrieves specific columns ("location," "date," "total_cases," "new_cases," "total_deaths," "population") from the "CovidDeaths" table and orders the results by the first and second columns.

3. **Likelihood of Dying from COVID-19 in the US:**
   - Calculates the death percentage by dividing "total_deaths" by "total_cases" and multiplying the result by 100. Filters the results for locations containing the word "states" and orders them by the first and second columns.

4. **Timeline of COVID-19 Cases in the US:**
   - Calculates the case percentage by dividing "total_cases" by "population" and multiplying the result by 100. Filters the results for locations containing the word "states," where the population is greater than 10,000,000, and the total_cases are greater than or equal to 464. Orders the results by the first and second columns.

5. **Countries with the Highest Infection Rate:**
   - Calculates the percentage of the population infected by dividing "total_cases" by "population" and multiplying the result by 100. Groups the results by location and population, and orders them by the percentage of the population infected in descending order.

6. **Countries with the Highest Death Count:**
   - Calculates the maximum total death count for each location. Filters the results for locations where the continent is not null and orders them by the total death count in descending order.

7. **Continents with the Highest Death Count:**
   - Calculates the maximum total death count for each continent and location. Groups the results by continent and orders them by the total death count in descending order.

8. **Continents with the Highest Death Count per Population:**
   - Calculates the death count and deaths per million by dividing "total_deaths" by "population" and multiplying the result by 1,000,000. Filters the results for continents where the continent is null and excludes specific locations. Groups the results by location and population and orders them by deaths per million in descending order.

9. **Global COVID-19 Statistics:**
   - Calculates the total cases, total deaths, and death percentage for all continents combined. Orders the results by the total cases and total deaths.

10. **Timeline of Population vs. Vaccinations:**
    - Retrieves the continent, location, date, population, new_vaccinations, and rolling people vaccinated columns by joining the "CovidDeaths" and "CovidVaccinations" tables. Orders the results by location and date.

11. **Timeline of Population vs. Vaccinations with Percent Vaccinated:**
    - Retrieves the continent, location, date, population, new_vaccinations, rolling people vaccinated, and percent vaccinated columns by joining the "CovidDeaths" and "CovidVaccinations" tables. Calculates the percent vaccinated by dividing the rolling people vaccinated by the population and multiplying the result by 100.

12. **Creating a View:**
    - Drops the existing "PercentPeopleVaccinated" view if it exists, and then creates a new view with the same name. The view retrieves the same data as the query

 in section 10 and can be used for later visualizations.

Please note that these queries assume the existence of the "CovidDeaths" and "CovidVaccinations" tables in the "PortfolioProject" database. Before executing these queries, ensure that you have the necessary permissions and have imported the required data into the tables.
