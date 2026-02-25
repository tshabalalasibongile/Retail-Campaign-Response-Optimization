# Retail Campaign Response Prediction & Profit Optimization

## Project Overview
End-to-end predictive modeling solution to optimize retail marketing campaigns.  
Objective: Identify high-probability responders, rank customers by predicted response likelihood, and maximize campaign profitability using data-driven targeting strategies.

## Business Objective
- Predict customer response probability
- Rank customers by likelihood to respond
- Quantify lift and decile performance
- Simulate profit under different targeting thresholds
- Provide an executive decision-support dashboard

## Tech Stack
- Python (Pandas, scikit-learn, Matplotlib)
- SQL Server (Data Cleaning & Feature Engineering)
- Power BI (Interactive Dashboard)
- Logistic Regression
- Lift & Decile Analysis
- AUC / KS Evaluation
- Profit Simulation
- PSI Stability Analysis

## Model Performance
- **AUC:** 0.7322  
- **Gini:** 0.4643  
- **KS Statistic:** 0.3483  
- **Overall Response Rate:** ~11.7%  
- **Top Decile Response Rate:** ~40.16%  
- **Lift (Top Decile):** ~3.43×  
- **PSI:** 0.046 (Model Stable)

## Business Insights
- Customers in top decile are >3× more likely to respond  
- Profit is heavily concentrated in high-score segments  
- Threshold optimization reduces contact volume by ~58%  
- Model demonstrates stable ranking suitable for deployment

## Dashboard Features
- Executive KPI summary (Total Customers, Response Rate, Model AUC, Total Profit)
- Lift curve visualization
- Decile performance table
- Profit by decile chart
- Score distribution histogram
- Interactive targeting threshold simulator

## Key Takeaways
- End-to-end workflow: Data preparation → Modeling → Evaluation → Dashboard  
- Business-aligned interpretation with profit simulation  
- Deployment-ready outputs and executive-level decision support  

## Optional Notes
This project simulates a real-world retail campaign optimization workflow, combining predictive modeling, financial impact analysis, and executive reporting.
