# Retail Campaign Response Prediction & Profit Optimization

## Project Overview

This project develops an end-to-end predictive modeling solution to optimize retail marketing campaigns.

The objective is to identify high-probability responders, rank customers by predicted response likelihood, and maximize campaign profitability through data-driven targeting strategies and interactive decision support.

---

## Business Objectives

- Predict customer response probability  
- Rank customers by likelihood to respond  
- Quantify lift and decile performance  
- Simulate profitability under different targeting thresholds  
- Provide an executive-level decision-support dashboard  

---

## Tech Stack

- Python (Pandas, Scikit-learn, Matplotlib)  
- SQL Server (Data Cleaning & Feature Engineering)  
- Power BI (Interactive Dashboard & Business Simulation)  
- Logistic Regression  
- Lift & Decile Analysis  
- AUC / KS Evaluation  
- Profit Simulation  
- PSI (Population Stability Index)  

---

## Model Performance

- AUC: 0.7322  
- Gini: 0.4643  
- KS Statistic: 0.3483  
- Overall Response Rate: ~11.7%  
- Top Decile Response Rate: ~40.16%  
- Lift (Top Decile): ~3.43×  
- PSI: 0.046 (Model Stable)  

---

## Business Insights

- Customers in the top decile are more than 3× more likely to respond.  
- Profit is heavily concentrated in high-score segments.  
- Threshold optimization reduces contact volume by approximately 58%, demonstrating cost-efficiency trade-offs.  
- The model shows stable ranking performance suitable for operational deployment.  

---

## Dashboard Features

The Power BI dashboard includes:

- Executive summary cards (Total Customers, Overall Response Rate, Model AUC, Total Profit)  
- Lift curve visualization  
- Decile performance table  
- Profit by decile analysis  
- Score distribution histogram  
- Interactive targeting score threshold simulator  

The dashboard allows stakeholders to dynamically evaluate how changing the targeting threshold impacts customer volume, response rate, and profitability.

---

## Key Takeaways

- End-to-end workflow: Data Preparation → Modeling → Evaluation → Business Simulation → Dashboard Deployment  
- Strong ranking performance demonstrated through lift and decile analysis  
- Business-aligned interpretation with financial impact simulation  
- Deployment-ready scoring output and executive-level reporting  

---

## Project Context

This project simulates a real-world retail campaign optimization workflow, combining predictive modeling, financial impact analysis, and executive reporting to support data-driven marketing decisions.
