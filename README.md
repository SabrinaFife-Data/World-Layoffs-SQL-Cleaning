# World Layoffs Data Cleaning & Executive Power BI Dashboard

## Executive Summary
This end-to-end data analytics project cleans, transforms, and analyzes global tech layoff data to uncover major industry trends and macroeconomic impacts. Raw, unorganized data was staged in MySQL, subjected to a rigorous data-cleaning lifecycle, and then connected to Power BI to deliver interactive, executive-level insights.

---

## Technical Stack & Tools
* **Database Management:** MySQL (SQL Data Cleaning & Staging)
* **Data Visualization:** Power BI Desktop
* **Version Control:** Git & GitHub Desktop

---

## Project Workflow & Architecture

### Phase 1: Data Cleaning in MySQL
Raw datasets frequently contain duplicate records, blank entries, irregular date formats, and null values. The following multi-step SQL process was executed on a staging table (`layoffs_staging2`) to ensure data integrity without altering raw source data:

1. **Duplicate Removal:** Used `ROW_NUMBER()` over partition windows (`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`) to identify and purge identical rows.
2. **Standardization:**
   * Trimmed trailing whitespace across string columns.
   * Standardized variations of industry names (e.g., consolidating `Crypto`, `CryptoCurrency`, and `Crypto Currency` into `Crypto`).
   * Cleaned trailing punctuation from geographic fields (e.g., `United States.` to `United States`).
3. **Date Conversion:** Converted text dates (`MM/DD/YYYY`) into standard MySQL `DATE` format (`YYYY-MM-DD`) using `STR_TO_DATE()`.
4. **Populating Null Values:** Utilized self-joins to populate missing `industry` records based on existing entries for the same company.
5. **Irrelevant Record Removal:** Removed rows where both `total_laid_off` and `percentage_laid_off` were null, as they provided no analytical value.

---

### Phase 2: Key Executive Metrics

* **Total Layoffs Recorded:** 193K employees
* **Total Capital Raised (Impacted Companies):** $429 Billion ($429,000 Million)
* **Unique Companies Impacted:** 823 companies

---

## Executive Power BI Dashboard

The cleaned dataset was imported into Power BI Desktop to build an executive overview highlighting affected industries, timeline trends, and the hardest-hit organizations.

![World Layoffs Power BI Dashboard](dashboard_preview.png)

### Key Dashboard Insights:
* **Industry Impact:** Hardest-hit sectors include Consumer, Retail, Transportation, and Finance.
* **Timeline Trajectory:** Layoff events surged significantly across specific quarterly peaks, reflecting broader macroeconomic headwinds.
* **Organizational Breakdown:** Visualizes headcount reduction concentration across top-tier enterprise organizations versus mid-stage startups.

---

## How to Reproduce This Project
1. Clone this repository:
   ```bash
   git clone [https://github.com/SabrinaFife-Data/World-Layoffs-SQL-Cleaning.git](https://github.com/SabrinaFife-Data/World-Layoffs-SQL-Cleaning.git)
