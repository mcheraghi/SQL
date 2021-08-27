SELECT 
  country 
FROM 
  eurovision;
  
  
SELECT TOP(50) country 
FROM eurovision;
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT country 
FROM eurovision
LIMIT 50;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Return unique countries and use an alias
SELECT DISTINCT country AS unique_country 
FROM eurovision;

SELECT 
  country, 
  event_year 
FROM 
  eurovision;
  




-------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
  TOP (50) PERCENT * 
FROM 
  eurovision;
  
  
  
  
------------------------------------------------------------------------------------------------------------------------------------------- 
-- Select the first 5 rows from the specified columns
SELECT 
  TOP (5) description, 
  event_date 
FROM 
  grid 
  -- Order your results by the event_date column
ORDER BY 
  event_date;
 
 
 
 
 
------------------------------------------------------------------------------------------------------------------------------------------- 
-- Select the top 20 rows from description, nerc_region and event_date
SELECT 
  TOP (20) description,
  nerc_region,
  event_date
FROM 
  grid 
  -- Order by nerc_region, affected_customers & event_date
  -- Event_date should be in descending order
ORDER BY
  nerc_region,
  affected_customers,
  event_date DESC ;
  
  
  
-------------------------------------------------------------------------------------------------------------------------------------------
-- Select description and affected customers
SELECT 
  description, 
  affected_customers
FROM 
  grid 
  -- Retrieve rows where the event_date was the 22nd December, 2013    
WHERE 
  event_date = '2013-12-22';




-------------------------------------------------------------------------------------------------------------------------------------------
-- Select description, affected_customers and event date
SELECT 
  description, 
  affected_customers,
  event_date
FROM 
  grid 
  -- The affected_customers column should be >= 50000 and <=150000   
WHERE 
  affected_customers  BETWEEN 50000 
  AND 150000 
   -- Define the order   
ORDER BY 
  event_date DESC;





-------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve all columns
SELECT 
  * 
FROM 
  grid 
  -- Return rows where demand_loss_mw is not missing or unknown   
WHERE 
  demand_loss_mw IS NULL;
  
  
  
  
  

-------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
  artist, 
  release_year, 
  song 
FROM 
  songlist 
  -- Choose the correct artist and specify the release year
WHERE 
  (
    artist LIKE 'B%' 
    AND release_year = 1986
  ) 
  -- Or return all songs released after 1990
  OR release_year > 1990
  -- Order the results
ORDER BY 
  release_year, 
  artist, 
  song;
  



 -------------------------------------------------------------------------------------------------------------------------------------------
CHARINDEX(substring, string, start)
LEFT(string, number_of_chars)

 
 
 
 -------------------------------------------------------------------------------------------------------------------------------------------
 LEFT JOIN, RIGHT JOIN, INNER‌ JOIN, UNION, UNION ALL
 
 
 SELECT 
  album_id AS ID,
  title AS description,
  'Album' AS Source
  -- Complete the FROM statement
FROM album 
 -- Combine the result set using the relevant keyword
UNION
SELECT 
  artist_id AS ID,
  name AS description,
  'Artist'  AS Source
  -- Complete the FROM statement
FROM artist ; 
  
  
  
  
 -------------------------------------------------------------------------------------------------------------------------------------------
  
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	track_length_mins INT,

	);
	
	
	
-------------------------------------------------------------------------------------------------------------------------------------------  
 INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
  ('Basket Case', 'Dookie', 3);
  

-------------------------------------------------------------------------------------------------------------------------------------------

UPDATE 
  album 
SET 
  title = 'Pure Cult: The Best Of The Cult' 
WHERE 
  album_id = 213;
  

-------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM 
  album 
WHERE 
 album_id = 1
  
-------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM 
  album 
WHERE 
 album_id = 1
  
-------------------------------------------------------------------------------------------------------------------------------------------

-- Declare your variables
DECLARE @start DATE
DECLARE @stop DATE
DECLARE @affected INT;
-- SET the relevant values for each variable
SET @start = '2014-01-24'
SET @stop  = '2014-07-02'
SET @affected =  5000 ;

SELECT 
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM 
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE event_date BETWEEN @start AND @stop
AND  affected_customers >= @affected;


-------------------------------------------------------------------------------------------------------------------------------------------
SELECT  album.title AS album_title,
  artist.name as artist,
  MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
-- Name the temp table #maxtracks
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track on album.album_id = track.album_id
GROUP BY artist.artist_id, album.title, artist.name,album.album_id


-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM  #maxtracks
ORDER BY max_track_length_mins DESC, artist;


-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

------------------------------------------------------------------------------------------------------------------------ALTER TABLE

-- Change the type of firstname
ALTER TABLE professors
ALTER COLUMN firstname 
TYPE varchar(64);

-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16);


-- Disallow NULL values in firstname
ALTER TABLE professors 
ALTER COLUMN firstname SET NOT NULL;

-- Make universities.university_shortname unique
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);

ALTER TABLE table_name
ADD column_name datatype;
ALTER TABLE Customers
ADD Email varchar(255);

ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;
------------------------------------------------------------------------------------------------------------------------PRIMARY‌ KEY

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);

CREATE TABLE students (
  last_name varchar(128) NOT NULL,
  ssn INTEGER PRIMARY KEY,
  phone_no char(12)
);

-- Rename the university_shortname column to id
ALTER TABLE universities
RENAME COLUMN university_shortname TO id;

ALTER TABLE universities
ADD CONSTRAINT university_pk PRIMARY KEY (id);

-- Add the new column to the table
ALTER TABLE professors 
ADD COLUMN id serial PRIMARY KEY;


#----------------------------------------------------------------------------------------concatenating two columns as PK
-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model)) 
FROM cars;

-- Add the id column
ALTER TABLE cars
ADD COLUMN id varchar(128);

-- Update id with make + model
UPDATE cars
SET id = CONCAT(make, model);

-- Make id a primary key
ALTER TABLE cars
ADD CONSTRAINT id_pk PRIMARY KEY(id);

-- Have a look at the table
SELECT * FROM cars;



---------------------------------------------------------------------------------------------------Foreign key

CREATE TABLE Orders (
    OrderID int NOT NULL PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
);


-- Add a foreign key on professors referencing universities
ALTER TABLE professors
ADD CONSTRAINT professors_fkey FOREIGN KEY (university_id) REFERENCES  universities (id);


-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);



-- Update professor_id to professors.id where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;



