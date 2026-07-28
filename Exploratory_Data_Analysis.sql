-- =======================================================
-- PROJECT: World Layoffs Exploratory Data Analysis (EDA)
-- AUTHOR: Sabrina Fife
-- PURPOSE: Answering business questions on cleaned layoff data
-- =======================================================

USE world_layoffs; -- Ensure you are using your database


-- -------------------------------------------------------
-- Question 1: Which industries took the hardest hit overall?
-- Business Purpose: Identify sector-level risk and high-volume layoff areas.
-- -------------------------------------------------------
SELECT 
    industry, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY total_layoffs DESC
LIMIT 10;


-- -------------------------------------------------------
-- Question 2: What was the month-by-month trend of layoffs?
-- Business Purpose: Detect economic seasonality or spike periods over time.
-- -------------------------------------------------------
SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS `month`, 
    SUM(total_laid_off) AS monthly_layoffs
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `month`
ORDER BY `month` ASC;


-- -------------------------------------------------------
-- Question 3: Which high-funded companies experienced total shutdown (100% layoff)?
-- Business Purpose: Analyze capital burn vs. complete operational failure.
-- -------------------------------------------------------
SELECT 
    company, 
    industry, 
    total_laid_off,
    funds_raised_millions
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; 