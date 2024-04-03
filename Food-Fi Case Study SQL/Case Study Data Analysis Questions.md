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
3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown
by count of events for each plan_name

-- Selecting the plan_name and the count of events for each plan_name
SELECT 
    p.plan_name, 
    COUNT(*) AS event_count
FROM 
    -- From the subscriptions table, aliased as 's'
    subscriptions s
    
-- Joining with the plans table to get plan information, aliased as 'p'
JOIN 
    plans p ON p.plan_id = s.plan_id
    
-- Filtering to include only records where the year of start_date is greater than 2020
WHERE 
    YEAR(s.start_date) > 2020
    
-- Grouping the results by plan_name
GROUP BY 
    p.plan_name;



4. What is the customer count and percentage of customers who have churned rounded to 1
decimal place?

```
-- Selecting the rounded customer count and percentage of customers who have churned
SELECT 
    -- Rounding the count of distinct customer IDs to 1 decimal place as 'customer_count'
    ROUND(COUNT(DISTINCT s.customer_id), 1) AS customer_count,
    
    -- Rounding the percentage of churned customers to 1 decimal place
    -- Calculating the percentage by dividing the count of distinct churned customer IDs 
    -- by the total count of distinct customer IDs, multiplied by 100
    ROUND(
        (COUNT(DISTINCT s.customer_id) / 
        -- Subquery to count the total number of distinct customer IDs in the subscriptions table
        (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) * 100), 1
    ) AS percentage_churned
FROM 
    -- From the subscriptions table, aliased as 's'
    subscriptions s
    
-- Joining with the plans table to get plan information
JOIN 
    plans p ON p.plan_id = s.plan_id

-- Filtering to include only records where the plan name is 'churn'
WHERE 
    p.plan_name = 'churn';

```


5. How many customers have churned straight after their initial free trial - what percentage is
this rounded to the nearest whole number?

```
WITH cte_next_plan AS(
	SELECT *, LAG(plan_id,1) OVER(PARTITION BY customer_id ORDER BY plan_id )AS prev_plan
	FROM subscriptions )


SELECT ROUND(COUNT((prev_plan)),0) AS churn_count , ROUND(COUNT(prev_plan)/ (SELECT COUNT(DISTINCT(customer_id)) FROM subscriptions)*100, 0) AS percent
FROM cte_next_plan
WHERE plan_id=4 AND prev_plan=0


-- Selecting the rounded customer count and percentage of customers who have churned
SELECT 
    -- Rounding the count of distinct customer IDs to 1 decimal place as 'customer_count'
    ROUND(COUNT(DISTINCT s.customer_id), 0) AS customer_churn_count,
    
    -- Rounding the percentage of churned customers to 1 decimal place
    -- Calculating the percentage by dividing the count of distinct churned customer IDs 
    -- by the total count of distinct customer IDs, multiplied by 100
    ROUND(
        (COUNT(DISTINCT s.customer_id) / 
        -- Subquery to count the total number of distinct customer IDs in the subscriptions table
        (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) * 100), 0) AS percentage_churned
FROM 
    -- From the subscriptions table, aliased as 's'
    subscriptions s
    
-- Joining with the plans table to get plan information
JOIN 
    plans p ON p.plan_id = s.plan_id

-- Filtering to include only records where the plan name is 'churn'
WHERE 
    p.plan_name = 'churn' AND DAY(start_date)<=8; # trial period =7 days


```


6. What is the number and percentage of customer plans after their initial free trial?


```
-- Retrieving the number and percentage of customer plans after their initial free trial

SELECT plan_name,
    -- Rounding the count of distinct customer IDs to 1 decimal place as 'customer_count'
    ROUND(COUNT(DISTINCT s.customer_id), 0) AS customer_churn_count,
    
    -- Rounding the percentage of churned customers to 1 decimal place
    -- Calculating the percentage by dividing the count of distinct churned customer IDs 
    -- by the total count of distinct customer IDs, multiplied by 100
    ROUND(
        (COUNT(DISTINCT s.customer_id) / 
        -- Subquery to count the total number of distinct customer IDs in the subscriptions table
        (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) * 100), 0) AS percentage_churned
FROM 
    -- From the subscriptions table, aliased as 's'
    subscriptions s
  
-- Joining with the plans table to get plan information
JOIN 
    plans p ON p.plan_id = s.plan_id

-- Filtering to include only records where the plan name is 'churn'

WHERE 
    p.plan_name != 'trial'

GROUP BY plan_name

```
