-- Sample HR Data: https://docs.google.com/spreadsheets/d/1-1Ldoe-DwZTL77tdMtRgZAIzeAzs0jh3/edit?usp=sharing&ouid=103036376235127672085&rtpof=true&sd=true
-- Tableau Dashboard: 
-- Task: Validate KPI data against Tableau dashboard for the following values:
-- 1. Total # of employees per educational background:
SELECT
  education,
  SUM(employee_count)
FROM
  hrdata
GROUP BY
  1
ORDER BY
  2 DESC;

-- Bachelor's Degree	572
-- Master's Degree	398
-- Associates Degree	282
-- High School	170
-- Doctoral Degree	48

-- 2. # of employees per department:
SELECT
  department,
  SUM(employee_count)
FROM
  hrdata
GROUP BY
  1
ORDER BY
  2 DESC;

-- R&D	961
-- Sales	446
-- HR	63

-- 3. The employee attrition count in Sales department & with High School education only:
SELECT
  COUNT(attrition) AS 'Employee Attrition count'
FROM
  hrdata
WHERE
  attrition = 'Yes'
  AND department = 'Sales'
  AND education = 'High School';

-- 11

-- 4. The employee attrition rate shown as a percentage, rounded to 2 decimal points, per department:
SELECT department AS 'Department',
  ROUND(
    (
      (
        SELECT
          COUNT(attrition) AS 'Employee Attrition count'
        FROM
          hrdata
        WHERE
          attrition = 'Yes'
        AND department = 'Sales'
      ) / SUM(employee_count)
    ) * 100,
    2
  ) AS 'Employee Attrition Rate'
FROM
  hrdata
GROUP BY 1
ORDER BY 2 DESC;

-- HR	146.03
-- Sales	20.63
-- R&D	9.57

-- 5. # of employees per age group:
SELECT
  CASE
    WHEN age < 20 THEN '< 20'
    WHEN age BETWEEN 20
    AND 30 THEN '20 - 30'
    WHEN age BETWEEN 30
    AND 40 THEN '30 - 40'
    WHEN age BETWEEN 40
    AND 50 THEN '40 - 50'
    WHEN age > 50 THEN '50 >'
  END AS 'Age Group',
  COUNT(age) AS '# of Employees'
FROM
  hrdata
GROUP BY
  1
ORDER BY
  1;

-- < 20	17
-- 20 - 30	369
-- 30 - 40	619
-- 40 - 50	322
-- 50 >	143

-- 6. # of employees per gender:
SELECT
  gender,
  COUNT(gender) AS '# of Employees'
FROM
  hrdata
GROUP BY
  1
ORDER BY
  2 DESC;

-- Male	882
-- Female	588

-- 7. # of employees per their educational backgrounds: 
SELECT
  education_field,
  COUNT(attrition) AS '# of Employees'
FROM
  hrdata
WHERE
  attrition = 'Yes'
GROUP BY
  1
ORDER by
  2 DESC;

-- Life Sciences	89
-- Medical	63
-- Marketing	35
-- Technical Degree	32
-- Other	11
-- Human Resources	7

-- 8. Attrition rates of employees per age group and gender, denoted in count and percentage:
SELECT
  age_band,
  gender,
  COUNT(attrition) AS 'Attrition',
  ROUND(
    (
      COUNT(attrition) / (
        SELECT
          COUNT(attrition)
        FROM
          hrdata
        WHERE
          attrition = 'Yes'
      )
    ) * 100, 2)
    AS 'Percentage'
FROM
  hrdata
WHERE
  attrition = 'Yes'
GROUP BY 1, 2
ORDER BY 1;

-- 25 - 34	Female	43	18.14%
-- 25 - 34	Male	69	29.11%
-- 35 - 44	Female	14	5.91%
-- 35 - 44	Male	37	15.61%
-- 45 - 54	Female	9	3.80%
-- 45 - 54	Male	16	6.75%
-- Over 55	Female	3	1.27%
-- Over 55	Male	8	3.38%
-- Under 25	Female	18	7.59%
-- Under 25	Male	20	8.44%

-- 9. Average job satisfaction of employees per department:
SELECT
  job_role,
  SUM(employee_count) AS '# of Employees',
  ROUND(AVG(job_satisfaction), 1) AS 'Satisfaction Score'
FROM
  hrdata
GROUP BY
  1
ORDER BY
  3 DESC;

-- Sales Executive	326	2.8
-- Research Scientist	292	2.8
-- Healthcare Representative	131	2.8
-- Laboratory Technician	259	2.7
-- Manufacturing Director	145	2.7
-- Manager	102	2.7
-- Sales Representative	83	2.7
-- Research Director	80	2.7
-- Human Resources	52	2.6
