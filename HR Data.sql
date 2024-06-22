-- Validate KPI data against Tableau dashboard for:
-- Total # of employees per educational background:
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

-- # of employees per department:
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
