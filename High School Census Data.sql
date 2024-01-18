+ -- Project title: Analyzing Education & Census Data
+ -- Database source: 
-- https://static-assets.codecademy.com/community/datasets_forum_projects/census_data.csv
-- https://static-assets.codecademy.com/community/datasets_forum_projects/public_hs_data.csv
+ -- Queried using: DBGate

+ -- Tasks: 
-- Get a feel for the data by selecting all available columns from both, census and public_hs tables.
SELECT * 
FROM census_data;
SELECT * 
FROM public_hs_data;

-- How many public high schools are in each zip code ? in each state ?
SELECT zip_code, state_code, COUNT(*) AS '# of public high schools'
FROM public_hs_data
GROUP BY
  state_code
ORDER BY
  state_code ASC;

-- Which city has the greatest math proficieny ?
SELECT
  state_code AS 'State',
  city AS 'City',
  ROUND(AVG(pct_proficient_math), 1) AS 'Math proficieny'
FROM public_hs_data
GROUP BY city
ORDER BY ROUND(AVG(pct_proficient_math), 1) DESC
LIMIT 20;

-- What is the reading proficieny per state ?
SELECT
  state_code AS 'State',
  CASE
    WHEN pct_proficient_reading < 30 THEN 'Low Proficieny'
    WHEN pct_proficient_reading Between 30 AND 50 THEN 'Medium Proficieny'
    WHEN pct_proficient_reading > 50 THEN 'High Proficieny'
  END AS 'Reading Proficieny'
FROM
  public_hs_data
GROUP BY
  state_code
ORDER BY
  pct_proficient_reading DESC;

-- The locale_code column in the high school data corresponds to various levels of urbanization. 
-- Use the CASE statement to display the corresponding locale_text in your query result.
SELECT
    state_code AS 'State',
    CASE
      WHEN locale_code <= 13 THEN 'City'
      WHEN locale_code Between 21 AND 23 THEN 'Suburb'
      WHEN locale_code Between 31 AND 33 THEN 'Town'
      WHEN locale_code >= 41 THEN 'Rural'
    END AS 'Levels of Urbanization'
FROM
    public_hs_data
GROUP BY
    state_code
ORDER BY
    state_code ASC;

-- What is the minimum, maximum, and average median_household_income of the nation ? for each state ?
SELECT
  state_code AS 'State',
  MIN(median_household_income) AS 'Minimum household income',
  MAX(median_household_income) AS 'Maximum household income',
  ROUND(AVG(median_household_income), 2) AS 'Average household income'
FROM
  census_data
WHERE
  median_household_income != 'NULL'
GROUP BY
  state_code
ORDER BY
  state_code ASC;

-- Do characteristics of the zip - code area such as median household income, influence students’ performance in high school ?
SELECT
  ROUND(AVG(pct_proficient_math), 0) AS 'Math Results',
  ROUND (AVG(pct_proficient_reading), 0) AS 'Reading Results',
  CASE
    WHEN median_household_income < 30000 THEN 'Low Income'
    WHEN median_household_income BETWEEN 30000 AND 50000 THEN 'Medium Income'
    WHEN median_household_income > 50000 THEN 'High Income'
    ELSE 'No data available'
  END AS 'Income bracket'
FROM
  public_hs_data
  INNER JOIN census_data ON public_hs_data.zip_code = census_data.zip_code
WHERE
  median_household_income != 'NULL'
GROUP BY 3
Order by 3 ASC;
