# SaaSPulse AI — SaaS Subscription & Churn Analytics Platform

## Project Overview

SaaSPulse AI is an end-to-end SaaS analytics project focused on:

* Customer churn prediction
* Revenue analytics
* Subscription intelligence
* Customer health analysis
* Business performance visualization

This project combines:

* Excel Data Cleaning
* MySQL Database Management
* SQL Analytics
* Python EDA & Machine Learning
* Power BI Dashboards

---

# Project Architecture

```text
SaaSPulse-AI/
│
├── dataset_raw/
├── dataset_cleaned/
├── excel/
├── mysql/
├── python/
├── powerbi/
├── screenshots/
├── README.md
└── requirements.txt
```

---

# Technologies Used

## Data Processing

* Excel
* Python
* Pandas
* NumPy

## Database

* MySQL
* SQL

## Machine Learning

* Scikit-learn
* Random Forest
* Logistic Regression

## Visualization

* Power BI

---

# Dataset Information

Dataset includes:

* Customer accounts
* Subscription details
* Product usage
* Support tickets
* Churn events

Main target variable:

```text
Churn_Flag
```

---

# SQL Workflow

## Database Creation

```sql
CREATE DATABASE saaspulse_ai;
USE saaspulse_ai;
```

## Tables Created

* accounts
* subscriptions
* feature_usage
* support_tickets
* churn_events

## SQL Analysis Performed

* Revenue analysis
* Churn analysis
* Subscription analytics
* Customer risk analysis
* Customer health metrics

---

# Python Workflow

## Data Cleaning

* Null handling
* Date conversion
* Feature engineering

## Exploratory Data Analysis

* Churn distribution
* Revenue analysis
* Customer segmentation

## Machine Learning Models

### Logistic Regression

Accuracy:

```text
~76%
```

### Random Forest

Accuracy:

```text
~99.1%
```

## Feature Importance Analysis

Top churn-driving factors:

* signup_date
* avg_satisfaction
* total_tickets
* industry
* plan_type

---

# Power BI Dashboard

## Dashboard Pages

### 1. Executive Overview Dashboard

* Revenue KPIs
* Customer KPIs
* Revenue trends
* Country analysis

### 2. Subscription & Revenue Intelligence

* Subscription lifecycle
* Upgrade/downgrade analysis
* Trial conversion
* Billing insights

### 3. Customer & Business Analytics

* Customer segmentation
* Revenue intelligence
* ARR/MRR analysis
* Retention insights

### 4. Churn Risk & Customer Health Insights

* Churn drivers
* Customer health score
* Revenue at risk
* Retention stability

---

# Key Features

* End-to-end SaaS analytics pipeline
* Churn prediction system
* Revenue intelligence dashboard
* Customer health scoring
* Interactive Power BI dashboards
* Machine learning integration

---

# Final Outputs

Generated files:

```text
saaspulse_ml_cleaned_dataset.csv
feature_importance.csv
```

Dashboard file:

```text
SaaSPulse_AI_Dashboard.pbix
```

---

# Business Impact

This project helps SaaS businesses:

* Reduce churn
* Improve customer retention
* Analyze subscription performance
* Identify high-risk customers
* Monitor revenue trends

---

# How to Run the Project

## 1. Clone Repository

```bash
git clone https://github.com/yourusername/SaaSPulse-AI.git
```

## 2. Install Dependencies

```bash
pip install -r requirements.txt
```

## 3. Run Python Notebook

```bash
jupyter notebook
```

## 4. Open Power BI Dashboard

Open:

```text
SaaSPulse_AI_Dashboard.pbix
```

---

# Future Enhancements

* Real-time churn prediction
* Streamlit deployment
* Tableau integration
* Automated reporting
* Cloud deployment

---

# Author

Your Name

---

# License

This project is for educational and portfolio purposes.
