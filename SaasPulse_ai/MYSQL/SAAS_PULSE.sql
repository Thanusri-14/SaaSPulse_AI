USE saaspulse_ai;

LOAD DATA LOCAL INFILE 'C:/csv/accounts.csv'
INTO TABLE accounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
USE saaspulse_ai;

LOAD DATA LOCAL INFILE 'C:/csv/subscriptions.csv'
INTO TABLE subscriptions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM subscriptions;
LOAD DATA LOCAL INFILE 'C:/csv/feature_usage.csv'
INTO TABLE feature_usage
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'C:/csv/support_tickets.csv'
INTO TABLE support_tickets
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'C:/csv/churn_events.csv'
INTO TABLE churn_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
DROP TABLE IF EXISTS cleaned_subscriptions;
SELECT COUNT(*) FROM accounts;
SELECT COUNT(*) FROM subscriptions;
SELECT COUNT(*) FROM feature_usage;
SELECT COUNT(*) FROM support_tickets;
SELECT COUNT(*) FROM churn_events;
SELECT 
    plan_tier,
    COUNT(*) AS total_subscriptions,
    SUM(mrr_amount) AS total_mrr,
    SUM(arr_amount) AS total_arr
FROM subscriptions
GROUP BY plan_tier
ORDER BY total_mrr DESC;
SELECT 
    plan_tier,
    COUNT(*) AS total_subscriptions,
    SUM(mrr_amount) AS total_mrr,
    SUM(arr_amount) AS total_arr
FROM subscriptions
GROUP BY plan_tier
ORDER BY total_mrr DESC;
SELECT 
    a.customer_id,
    a.company_name,
    COUNT(t.ticket_id) AS total_tickets,
    AVG(t.satisfaction_score) AS avg_satisfaction
FROM accounts a
JOIN support_tickets t
ON a.customer_id = t.account_id
GROUP BY a.customer_id, a.company_name
ORDER BY total_tickets DESC;
SELECT 
    s.subscription_id,
    s.plan_tier,
    SUM(f.usage_count) AS total_usage,
    SUM(f.error_count) AS total_errors
FROM subscriptions s
JOIN feature_usage f
ON s.subscription_id = f.subscription_id
GROUP BY s.subscription_id, s.plan_tier
ORDER BY total_usage DESC;
SELECT 
    reason_code,
    COUNT(*) AS total_churns,
    SUM(refund_amount_usd) AS total_refund
FROM churn_events
GROUP BY reason_code
ORDER BY total_churns DESC;
CREATE VIEW saas_customer_360 AS
SELECT 
    a.customer_id,
    a.company_name,
    a.industry,
    a.country,
    a.plan_type,
    a.churn_flag,
    s.subscription_id,
    s.plan_tier,
    s.mrr_amount,
    s.arr_amount,
    s.billing_frequency
FROM accounts a
LEFT JOIN subscriptions s
ON a.customer_id = s.account_id;
SELECT * FROM saas_customer_360 LIMIT 20;
SELECT 
    SUM(mrr_amount) AS total_monthly_revenue,
    SUM(arr_amount) AS total_annual_revenue
FROM subscriptions;
SELECT 
    DATE_FORMAT(start_date, '%Y-%m') AS month,
    SUM(mrr_amount) AS monthly_revenue
FROM subscriptions
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY month;
SELECT 
    ROUND(SUM(churn_flag) * 100 / COUNT(*), 2) AS churn_rate
FROM accounts;
SELECT 
    plan_tier,
    COUNT(*) AS total_subscriptions,
    SUM(mrr_amount) AS total_mrr,
    SUM(arr_amount) AS total_arr
FROM subscriptions
GROUP BY plan_tier
ORDER BY total_mrr DESC;
SELECT 
    a.customer_id,
    a.company_name,
    a.plan_type,
    SUM(f.usage_count) AS total_usage,
    SUM(f.error_count) AS total_errors,
    AVG(t.satisfaction_score) AS avg_satisfaction,
    COUNT(t.ticket_id) AS total_tickets
FROM accounts a
LEFT JOIN subscriptions s
    ON a.customer_id = s.account_id
LEFT JOIN feature_usage f
    ON s.subscription_id = f.subscription_id
LEFT JOIN support_tickets t
    ON a.customer_id = t.account_id
GROUP BY a.customer_id, a.company_name, a.plan_type
HAVING 
    total_usage < 10 
    OR total_errors >= 5
    OR avg_satisfaction < 3
    OR total_tickets >= 3;
    SELECT 
    reason_code,
    COUNT(*) AS total_churns,
    SUM(refund_amount_usd) AS total_refund
FROM churn_events
GROUP BY reason_code
ORDER BY total_churns DESC;
CREATE OR REPLACE VIEW saas_customer_360 AS
SELECT 
    a.customer_id,
    a.company_name,
    a.industry,
    a.country,
    a.signup_date,
    a.account_status,
    a.plan_type,
    a.seats,
    a.is_trial,
    a.churn_flag,
    s.subscription_id,
    s.start_date,
    s.end_date,
    s.plan_tier,
    s.mrr_amount,
    s.arr_amount,
    s.billing_frequency,
    s.auto_renew_flag
FROM accounts a
LEFT JOIN subscriptions s
    ON a.customer_id = s.account_id;
    SELECT * FROM saas_customer_360 LIMIT 20;
    SELECT 
    a.customer_id,
    a.company_name,
    s.plan_tier,
    s.mrr_amount,
    s.arr_amount
FROM accounts a
JOIN subscriptions s
ON a.customer_id = s.account_id
ORDER BY s.arr_amount DESC
LIMIT 10;
SELECT 
    feature_name,
    SUM(usage_count) AS total_usage,
    SUM(usage_duration_secs) AS total_duration,
    SUM(error_count) AS total_errors
FROM feature_usage
GROUP BY feature_name
ORDER BY total_usage DESC;
SELECT 
    priority,
    COUNT(*) AS total_tickets,
    AVG(resolution_time_hours) AS avg_resolution_hours,
    AVG(first_response_time_minutes) AS avg_first_response_minutes,
    AVG(satisfaction_score) AS avg_satisfaction
FROM support_tickets
GROUP BY priority
ORDER BY total_tickets DESC;
SELECT 
    industry,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(SUM(churn_flag) * 100 / COUNT(*), 2) AS churn_rate
FROM accounts
GROUP BY industry
ORDER BY churn_rate DESC;
CREATE OR REPLACE VIEW saas_dashboard_summary AS
SELECT
    COUNT(DISTINCT a.customer_id) AS total_customers,
    SUM(a.churn_flag) AS churned_customers,
    ROUND(SUM(a.churn_flag) * 100 / COUNT(DISTINCT a.customer_id), 2) AS churn_rate,
    SUM(s.mrr_amount) AS total_mrr,
    SUM(s.arr_amount) AS total_arr,
    AVG(t.satisfaction_score) AS avg_satisfaction
FROM accounts a
LEFT JOIN subscriptions s ON a.customer_id = s.account_id
LEFT JOIN support_tickets t ON a.customer_id = t.account_id;
SELECT * FROM saas_dashboard_summary;