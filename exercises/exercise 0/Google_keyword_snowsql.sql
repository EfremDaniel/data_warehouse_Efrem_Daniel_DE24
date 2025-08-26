-- Go into marketplace under data products in snowsight. 
-- Search and get the following dataset Google Keywords search dataset - discover all searches on Google.
-- Now create a worksheet on your local repository and start querying this data through snowsql.


-- A)
-- List schemas
SHOW SCHEMAS IN DATABASE GOOGLE_KEYWORDS_SEARCH_DATASET__DISCOVER_ALL_SEARCHES_ON_GOOGLE;

-- Select schema
USE SCHEMA DATAFEEDS;

-- Show tables in the schema
SHOW TABLES; 

-- Show views in the schema
SHOW VIEWS;

-------------------------------------

-- B) Show table 
DESCRIBE TABLE DATAFEEDS.GOOGLE_KEYWORDS;

--------------------------------------


-- C) Number of rows in the table
SELECT COUNT(*) AS total_rows FROM GOOGLE_KEYWORDS;


-- D) First and latest search in the dataset
SELECT 
    MIN(DATE) AS first_search,
    MAX(DATE) AS latest_search
FROM GOOGLE_KEYWORDS;


-- E) 10 most popular keywords
SELECT keyword, COUNT(*) AS occurrences
FROM GOOGLE_KEYWORDS
GROUP BY keyword
ORDER BY occurrences DESC
LIMIT 10;


-- F) Number of unique keywords
SELECT COUNT(DISTINCT keyword) AS unique_keywords
FROM GOOGLE_KEYWORDS;


-- G) Platforms used and number of users per platform
SELECT PLATFORM, SUM(CALIBRATED_USERS) AS users_per_platform
FROM GOOGLE_KEYWORDS
GROUP BY PLATFORM;


-- H) Top 20 keywords for Sweden (replace 'SWE' with actual code)
SELECT KEYWORD, SUM(CALIBRATED_USERS) AS total_users
FROM GOOGLE_KEYWORDS
WHERE COUNTRY = '752' 
GROUP BY KEYWORD
ORDER BY total_users DESC
LIMIT 20;


-- I) Popularity of Spotify worldwide
SELECT COUNTRY AS COUNTRY_CODE, SUM(CALIBRATED_USERS) AS total_users
FROM GOOGLE_KEYWORDS
WHERE KEYWORD ILIKE '%spotify%'
GROUP BY COUNTRY
ORDER BY total_users DESC
LIMIT 10;


-------------------------------------------

-- J) Additional explorations

-- Top 10 platforms used globally
SELECT PLATFORM, SUM(CALIBRATED_USERS) AS users_per_platform
FROM GOOGLE_KEYWORDS
GROUP BY PLATFORM
ORDER BY users_per_platform DESC
LIMIT 10;

-- Top 10 countries by total searches
SELECT COUNTRY, SUM(CALIBRATED_USERS) AS total_users
FROM GOOGLE_KEYWORDS
GROUP BY COUNTRY
ORDER BY total_users DESC
LIMIT 10;

-- Trend over time: searches per month
SELECT YEAR, MONTH, SUM(CALIBRATED_USERS) AS total_users
FROM GOOGLE_KEYWORDS
GROUP BY YEAR, MONTH
ORDER BY YEAR, MONTH;

-- Top 10 branded keywords
SELECT KEYWORD, SUM(CALIBRATED_USERS) AS total_users
FROM GOOGLE_KEYWORDS
WHERE IS_BRANDED_KEYWORD = TRUE
GROUP BY KEYWORD
ORDER BY total_users DESC
LIMIT 10;


--------------------------------------------------


-- 1 How much does this cost

-- a) Credits: 15 | Cost: 15 × 3.90 = $58.50

-- b) Credits: 45 | Cost: 45 × 3.90 = $175.50

-- c) Credits: 540 | Cost: 540 × 3.90 = $2,106.00

-- d) Credits: 900 | Cost: 900 × 3.90 = $3,510.00











