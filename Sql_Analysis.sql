create database Churnproject;
use churnproject;
SELECT * FROM cleaned_churn LIMIT 10;
DESCRIBE cleaned_churn;

-- 1. OVERALL CHURN RATE
-- Business Question:
-- How serious is the churn problem?
SELECT 
    COUNT(CASE WHEN `Churn Value` = 1 THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM cleaned_churn;

-- 2. CHURN BY CONTRACT TYPE
-- Business Question:
-- Which contract type has the highest churn?

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(`Churn Value`) AS churned,
    ROUND(SUM(`Churn Value`)*100.0/COUNT(*),2) AS churn_rate
FROM cleaned_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 3. CHURN BY TENURE GROUP
-- Business Question:
-- Are new customers more likely to churn?
SELECT 
    Tenure_group,
    COUNT(*) AS total,
    SUM(`Churn Value`) AS churned,
    ROUND(SUM(`Churn Value`)*100.0/COUNT(*),2) AS churn_rate
FROM cleaned_churn
GROUP BY Tenure_group
ORDER BY churn_rate DESC;

-- 4. CHURN BY MONTHLY CHARGES
-- Business Question:
-- Do higher charges influence churn behavior?
SELECT CASE 
        WHEN `Monthly Charges` < 50 THEN 'Low'
        WHEN `Monthly Charges` BETWEEN 50 AND 100 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS total,
    SUM(`Churn Value`) AS churned,
    ROUND(SUM(`Churn Value`)*100.0/COUNT(*),2) AS churn_rate
FROM cleaned_churn
GROUP BY charge_group
ORDER BY churn_rate DESC;

-- 5. CHURN BY INTERNET SERVICE
-- Business Question:
-- Does internet service type impact churn?
SELECT 
    `Internet Service`,
    COUNT(*) AS total_customers,
    SUM(`Churn Value`) AS churned_customers,
    ROUND(SUM(`Churn Value`)*100.0/COUNT(*),2) AS churn_rate
FROM cleaned_churn
GROUP BY `Internet Service`
ORDER BY churn_rate DESC;

-- 6. CHURN BY PAYMENT METHOD
-- Business Question:
-- Does payment method affect churn?
SELECT 
    `Payment Method`,
    COUNT(*) AS total,
    SUM(`Churn Value`) AS churned,
    ROUND(SUM(`Churn Value`)*100.0/COUNT(*),2) AS churn_rate
FROM cleaned_churn
GROUP BY `Payment Method`
ORDER BY churn_rate DESC;



