/* ============================================================
Project: Retail Banking Campaign Analytics
Author: Sibongile Tshabalala
============================================================ */

/* ============================================================
1. Database Setup
============================================================ */

CREATE DATABASE RetailCampaignAnalyticsDB;
GO

USE RetailCampaignAnalyticsDB;
GO


/* ============================================================
2. Raw Landing Table
============================================================ */

CREATE TABLE dbo.raw_campaign_data (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    age INT,
    job VARCHAR(50),
    marital VARCHAR(20),
    education VARCHAR(50),
    [default] VARCHAR(10),
    balance INT,
    housing VARCHAR(10),
    loan VARCHAR(10),
    contact VARCHAR(20),
    [day] INT,
    [month] VARCHAR(10),
    duration INT,
    campaign INT,
    pdays INT,
    previous INT,
    poutcome VARCHAR(20),
    y VARCHAR(5)
);


/* ============================================================
3. Data Quality Validation
============================================================ */

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM dbo.raw_campaign_data;

-- Null Checks
SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN balance IS NULL THEN 1 ELSE 0 END) AS null_balance,
    SUM(CASE WHEN y IS NULL THEN 1 ELSE 0 END) AS null_response
FROM dbo.raw_campaign_data;

-- Duplicate Check
SELECT COUNT(*) - COUNT(DISTINCT 
    CONCAT(age, job, marital, education, [default], balance,
           housing, loan, contact, [day], [month], duration,
           campaign, pdays, previous, poutcome, y)
) AS duplicate_count
FROM dbo.raw_campaign_data;

-- Response Distribution
SELECT 
    y,
    COUNT(*) AS total,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() AS response_rate
FROM dbo.raw_campaign_data
GROUP BY y;


/* ============================================================
4. Feature Engineering (Analytics Table)
============================================================ */

IF OBJECT_ID('dbo.campaign_clean', 'U') IS NOT NULL
    DROP TABLE dbo.campaign_clean;

SELECT
    age,
    balance,
    duration,
    campaign,
    previous,

    CASE 
        WHEN LOWER(y) = 'yes' THEN 1
        ELSE 0
    END AS target,

    CASE 
        WHEN age < 30 THEN 'Under30'
        WHEN age BETWEEN 30 AND 45 THEN '30-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_band,

    CASE 
        WHEN balance > 0 THEN 1
        ELSE 0
    END AS positive_balance_flag,

    job,
    marital,
    education,
    housing,
    loan,
    poutcome

INTO dbo.campaign_clean
FROM dbo.raw_campaign_data;


/* ============================================================
5. Campaign Performance Summary
============================================================ */

-- Overall Performance
SELECT 
    COUNT(*) AS total_customers,
    SUM(target) AS responders,
    AVG(CAST(target AS FLOAT)) AS response_rate
FROM dbo.campaign_clean;

-- Response by Age Band
SELECT 
    age_band,
    COUNT(*) AS total,
    SUM(target) AS responders,
    AVG(CAST(target AS FLOAT)) AS response_rate
FROM dbo.campaign_clean
GROUP BY age_band
ORDER BY response_rate DESC;

-- Response by Previous Outcome
SELECT 
    poutcome,
    COUNT(*) AS total,
    AVG(CAST(target AS FLOAT)) AS response_rate
FROM dbo.campaign_clean
GROUP BY poutcome
ORDER BY response_rate DESC;


/* ============================================================
6. Simple SQL Heuristic Score (Pre-Model Baseline)
============================================================ */

ALTER TABLE dbo.campaign_clean
ADD score FLOAT;

UPDATE dbo.campaign_clean
SET score =
      (balance * 0.00001)
    + (duration * 0.0001)
    + (previous * 0.01);


/* ============================================================
7. Decile Analysis
============================================================ */

IF OBJECT_ID('dbo.campaign_scored', 'U') IS NOT NULL
    DROP TABLE dbo.campaign_scored;

SELECT *,
       NTILE(10) OVER (ORDER BY score DESC) AS decile
INTO dbo.campaign_scored
FROM dbo.campaign_clean;

SELECT 
    decile,
    COUNT(*) AS total,
    SUM(target) AS responders,
    AVG(CAST(target AS FLOAT)) AS response_rate
FROM dbo.campaign_scored
GROUP BY decile
ORDER BY decile;


/* ============================================================
8. Profit Simulation
============================================================ */

ALTER TABLE dbo.campaign_scored
ADD profit INT;

UPDATE dbo.campaign_scored
SET profit =
    CASE 
        WHEN target = 1 THEN 500 - 10
        ELSE -10
    END;

SELECT 
    decile,
    SUM(profit) AS total_profit
FROM dbo.campaign_scored
GROUP BY decile
ORDER BY decile;


/* ============================================================
9. Stored Procedure for Summary Reporting
============================================================ */

CREATE OR ALTER PROCEDURE dbo.sp_campaign_summary
AS
BEGIN
    SELECT 
        COUNT(*) AS total_customers,
        SUM(target) AS responders,
        AVG(CAST(target AS FLOAT)) AS response_rate
    FROM dbo.campaign_clean;
END;

EXEC dbo.sp_campaign_summary;