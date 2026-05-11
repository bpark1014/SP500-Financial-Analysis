-- Query 1: Average EBITDA by Sector
SELECT sector, 
       ROUND(AVG(CAST(REPLACE(REPLACE(ebitda, '$', ''), ',', '') AS REAL)), 2) AS avg_ebitda
FROM SP500_data
GROUP BY sector
ORDER BY avg_ebitda DESC;

-- Query 2: Average Revenue Growth by Sector
SELECT sector,
       ROUND(AVG(CAST(REPLACE(revenuegrowth, '%', '') AS REAL)), 2) AS avg_revenue_growth
FROM SP500_data
GROUP BY sector
ORDER BY avg_revenue_growth DESC;

-- Query 3: Top 10 Companies by Market Cap
SELECT longname,
       ROUND(CAST(REPLACE(REPLACE(marketcap, '$', ''), ',', '') AS REAL) / 1000000000, 2) AS market_cap_billions
FROM SP500_data
GROUP BY longname
ORDER BY market_cap_billions DESC
LIMIT 10;

-- Query 4: Number of Companies by Sector
SELECT sector, COUNT(DISTINCT symbol) AS number_of_companies
FROM SP500_data
GROUP BY sector
ORDER BY number_of_companies DESC;

-- Query 5: Top Company by EBITDA in Each Sector
SELECT sector, longname, 
       ROUND(CAST(REPLACE(REPLACE(ebitda, '$', ''), ',', '') AS REAL) / 1000000000, 2) AS ebitda_billions
FROM SP500_data
WHERE ebitda IS NOT NULL
GROUP BY sector
HAVING ebitda_billions = MAX(ROUND(CAST(REPLACE(REPLACE(ebitda, '$', ''), ',', '') AS REAL) / 1000000000, 2))
ORDER BY ebitda_billions DESC;