1. How many customers has Foodie-Fi ever had?

```
-- Counting the distinct customer IDs
SELECT COUNT(DISTINCT customer_id) AS customers
FROM subscriptions;
```


2. What is the monthly distribution of trial plan start_date values for our dataset - use the start
of the month as the group by value
```
-- Selecting the start of the month and the count of distinct customer IDs
SELECT 
    DATE_FORMAT(s.start_date, '%Y-%m-01') AS start_of_month, 
    COUNT(DISTINCT s.customer_id) AS customer_count
FROM 
    -- From the subscriptions table, aliased as 's'
    subscriptions s
    
-- Joining with the plans table to get plan information, aliased as 'p'
JOIN 
    plans p ON p.plan_id = s.plan_id
    
-- Filtering to include only records where the plan_name is 'trial'
WHERE 
    p.plan_name = 'trial'
    
-- Grouping the results by the start of the month
GROUP BY 
    DATE_FORMAT(s.start_date, '%Y-%m-01');
```
