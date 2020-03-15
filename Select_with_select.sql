--List each country name where the population is larger than that of 'Russia'.

-- world(name, continent, area, population, gdp)

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
-- Per Capita GDP
-- The per capita GDP is the gdp/population
SELECT name 
FROM world
WHERE continent = 'Europe' AND GDP/population >
(SELECT GDP/population
FROM world
WHERE name='United Kingdom')
-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
 ORDER BY name

--Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world where name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland')


--Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
-- Decimal places

SELECT name, CONCAT( ROUND((population/ (SELECT population FROM world WHERE name = 'Germany'))*100) ,'%') AS population
FROM world
WHERE continent = 'Europe'


--Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) 

SELECT name
FROM world
WHERE GDP > (SELECT GDP FROM world WHERE continent = 'Europe' --(select max(GDP) from world where continent = 'Europe')
ORDER BY GDP DESC LIMIT 1)

-- Find the largest country (by area) in each continent, show the continent, the name and the area: 

SELECT continent, name, area 
FROM world
WHERE area IN (SELECT max(area)
                  FROM world 
                group by continent
                 );


-- List each continent and the name of the country that comes first alphabetically.

SELECT continent, name
FROM world 
group by continent 

--Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. 

SELECT name, continent, population
FROM world y
WHERE continent IN 
(SELECT continent FROM world x WHERE 25000000 >= ALL (SELECT population FROM world y WHERE x.continent = y.continent))


-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world x
WHERE population >  3*(SELECT MAX(population) FROM world y WHERE x.continent = y.continent AND x.name <> y.name)

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population 
FROM world   
WHERE continent NOT IN(SELECT continent 
FROM world
where population > 25000000 )