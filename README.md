# World Layoffs Data Cleaning & Analysis Project

## 📌 Project Overview
This project focuses on cleaning, standardizing, and analyzing a raw dataset of global tech and company layoffs using **MySQL Workbench**. Real-world data is inherently messy, containing duplicate entries, inconsistent formatting, missing values, and unhelpful data types. 

The goal of this project was to construct a robust, non-destructive SQL pipeline that transforms raw data into an accurate, query-ready dataset for executive-level decision-making and trend analysis.

---

## 🛠️ Data Cleaning & Preparation Steps
1. **Data Staging:** Created a dedicated duplicate staging table (`layoffs_staging`) to preserve the integrity of the original raw dataset.
2. **Deduplication:** Applied SQL Window Functions (`ROW_NUMBER() OVER (...)`) within Common Table Expressions (CTEs) to isolate and eliminate exact duplicate records.
3. **Data Standardization:**
   * Trimmed leading/trailing whitespaces across key string attributes.
   * Standardized varied naming conventions (e.g., consolidating multiple industry name variations like "Crypto").
   * Converted raw text date strings into standard SQL `DATE` format (`YYYY-MM-DD`).
4. **Handling Missing/Null Values:** Executed self-joins to impute missing industry data where matching company records contained the necessary information.
5. **Database Optimization:** Stripped unnecessary helper columns and empty rows to produce a lean table ready for exploratory analysis and visualization.

---

## 📈 Key Business Insights (EDA)
After standardizing the dataset, I executed exploratory queries to identify core business trends:

* **Top Impacted Sectors:** Identified high-volume layoff patterns across key industries to highlight market risk.
* **Timeline Trends:** Tracked monthly layoff totals to evaluate macroeconomic spikes and seasonality.
* **Complete Capital Burn:** Filtered companies with 100% workforce layoffs to analyze funding amounts vs. operational shutdowns.

---

## 🧰 Technical Skills & Tools
* **Database Management System:** MySQL / MySQL Workbench
* **Version Control:** Git, GitHub Desktop
* **Advanced SQL Concepts:** CTEs, Window Functions (`ROW_NUMBER`), Self-Joins, Aggregate Functions (`SUM`, `GROUP BY`, `ORDER BY`), Data Type Conversion (`STR_TO_DATE`), String Manipulation (`TRIM`).

* ## Executive Power BI Dashboard
![World Layoffs Power BI Dashboard](dashboard_preview.png)
