--                      WORLD
-- name	        continent	area	population  	gdp
-- Afghanistan	Asia	    652230	25500100	20343000000
-- Albania	    Europe	    28748	2831741 	12960000000
-- Algeria	    Africa	    2381741	37100000	188681000000
-- Andorra	    Europe	    468	    78115	    3712000000
-- Angola	    Africa	    1246700	20609294	100990000000
-- ....

-- show the population of Germany
SELECT population FROM world
  WHERE name = 'Germany'

--Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
-- Checking a list The word IN allows us to check if an item is in a list.
SELECT name, population FROM world
  WHERE name IN ('Norway', 'Sweden', 'Denmark');

--show the country and the area for countries with an area between 200,000 and 250,000. 
-- BETWEEN allows range checking (range specified is inclusive of boundary values).
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000