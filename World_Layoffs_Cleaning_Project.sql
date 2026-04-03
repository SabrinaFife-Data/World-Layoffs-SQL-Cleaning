/*
--------------------------------------------------------------------------------------------------------------------------------
Project: World Layoffs Data Cleaning 
Author: Sabrina Fife
Goal: Transform raw layoff data into a standardized, clean dataset for analysis.
--------------------------------------------------------------------------------------------------------------------------------
*/

DROP TABLE IF EXISTS layoffs_staging;
DROP TABLE IF EXISTS layoffs_staging2;

-- 1. DATA STAGING
-- Creating a staging table to protect the integrity of the raw data.

CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;


-- 2. REMOVING DUPLICATES
-- Using a secondary staging table to handle MySQL's DML limitations with CTEs.

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, 
                 percentage_laid_off, `date`, stage, country, 
                 funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Deleting exact duplicates where row_num > 1

DELETE FROM layoffs_staging2
WHERE row_num > 1;


-- 3. STANDARDIZING DATA
-- Objective: Fix inconsistencies in naming conventions and data types.

-- A. Trimming White Space
-- Removing leading/trailing spaces that can break grouping in visualizations.
UPDATE layoffs_staging2
SET company = TRIM(company);

-- B. Consolidating Industry Names
-- Fixing variations like 'CryptoCurrency' and 'Crypto Currency' into one standard label.

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- C. Cleaning Country Names
-- Removing trailing punctuation (e.g., 'United States.') found in geographic data.
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- D. Converting Date Strings to Date Objects
-- Transforming the text 'date' column into a proper SQL Date format for time-series analysis.
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Modifying the column type to finalize the conversion.
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- 4. VIEWING CLEANED DATA
SELECT * FROM layoffs_staging2;

--------------------------------------------------------------------------------------------------------------------------------
-- 4. HANDLING NULLS & BLANK VALUES
-- Objective: Populate missing data where possible and remove rows that provide no analytical value.
--------------------------------------------------------------------------------------------------------------------------------

-- A. Standardizing Blanks to Nulls
-- Converting empty strings to NULL values for easier manipulation and filtering.

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


-- B. Populating Missing 'Industry' Data
-- Logic: If a company has multiple entries, we can use a populated 'industry' field to fill a NULL field for the same company.

-- We perform a Self-Join to find matching companies where one row is NULL and the other is not.

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- C. Identifying & Removing Unusable Data
-- Rows where both 'total_laid_off' and 'percentage_laid_off' are NULL offer no quantitative value for our analysis.

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


--------------------------------------------------------------------------------------------------------------------------------
-- 5. FINAL TABLE REFINEMENT
--------------------------------------------------------------------------------------------------------------------------------

-- Removing the helper column 'row_num' used for duplicate identification.
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final verification of cleaned dataset
SELECT * FROM layoffs_staging2;