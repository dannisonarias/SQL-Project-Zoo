--List the films where the yr is 1962 [Show id, title]  
SELECT id, 
       title 
FROM   movie 
WHERE  yr = 1962 

--Give year of 'Citizen Kane'.  
SELECT yr 
FROM   movie 
WHERE  title = 'Citizen Kane' 

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
SELECT id, 
       title, 
       yr 
FROM   movie 
WHERE  title LIKE '%Star Trek%' 
ORDER  BY yr 

--What id number does the actor 'Glenn Close' have?  
SELECT id 
FROM   actor 
WHERE  NAME = 'Glenn Close' 

--What is the id of the film 'Casablanca'  
SELECT id 
FROM   movie 
WHERE  title = 'Casablanca' 

--Obtain the cast list for 'Casablanca'. 
-- what is a cast list? 
-- Use movieid=11768, (or whatever value you got from the previous question)  
SELECT NAME 
FROM   actor 
       JOIN casting 
         ON id = actorid 
WHERE  movieid = 11768 

--Obtain the cast list for the film 'Alien'  
SELECT NAME 
FROM   casting 
       JOIN actor 
         ON actorid = id 
WHERE  movieid = (SELECT id 
                  FROM   movie 
                  WHERE  title = 'Alien') 

--List the films in which 'Harrison Ford' has appeared  
SELECT title 
FROM   movie 
       JOIN casting 
         ON movieid = id 
WHERE  'Harrison Ford' IN (SELECT NAME 
                           FROM   actor 
                           WHERE  casting.actorid = id 
                                  AND NAME = 'Harrison Ford') 

--List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
SELECT title 
FROM   movie 
       JOIN casting 
         ON movieid = id 
WHERE  'Harrison Ford' IN (SELECT NAME 
                           FROM   actor 
                           WHERE  casting.actorid = id 
                                  AND NAME = 'Harrison Ford' 
                                  AND casting.ord != 1) 

--List the films together with the leading star for all 1962 films.  
SELECT title, 
       NAME 
FROM   movie 
       JOIN casting 
         ON movieid = id 
       JOIN actor 
         ON actor.id = casting.actorid 
WHERE  yr = '1962' 
       AND casting.ord = 1 

--Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr, 
       Count(title) 
FROM   movie 
       JOIN casting 
         ON movie.id = movieid 
       JOIN actor 
         ON actorid = actor.id 
WHERE  NAME = 'Rock Hudson' 
GROUP  BY yr 
HAVING Count(title) > 2 

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
-- Did you get "Little Miss Marker twice"? 
-- Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934). 
-- Title is not a unique field, create a table of IDs in your subquery 
SELECT title, 
       NAME 
FROM   movie x 
       JOIN casting 
         ON movieid = id 
       JOIN actor 
         ON actor.id = casting.actorid 
WHERE  casting.ord = 1 
       AND 'Julie Andrews' IN (SELECT NAME 
                               FROM   actor 
                                      JOIN casting 
                                        ON casting.actorid = actor.id 
                                      JOIN movie 
                                        ON casting.movieid = movie.id 
                               WHERE  movie.id = x.id) 

--Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.  
SELECT DISTINCT NAME 
FROM   actor x 
       JOIN casting 
         ON actorid = id 
WHERE  (SELECT Count(movieid) 
        FROM   casting 
        WHERE  ord = 1 
               AND actorid = x.id) >= 15 
ORDER  BY NAME ASC 

--List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
SELECT title, 
       Count(actorid) AS actors 
FROM   movie 
       JOIN casting 
         ON id = movieid 
WHERE  yr = '1978' 
GROUP  BY title 
ORDER  BY actors DESC, 
          title 

--List all the people who have worked with 'Art Garfunkel'.  
SELECT DISTINCT NAME 
FROM   actor 
       JOIN casting 
         ON id = actorid 
WHERE  id IN (SELECT actorid 
              FROM   casting 
                     JOIN actor 
                       ON actorid = id 
              WHERE  movieid IN (SELECT movieid 
                                 FROM   casting 
                                        JOIN actor 
                                          ON actorid = id 
                                 WHERE  NAME = 'Art Garfunkel') 
                     AND NAME <> 'Art Garfunkel') 