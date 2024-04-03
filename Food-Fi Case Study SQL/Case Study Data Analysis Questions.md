1. How many customers has Foodie-Fi ever had?
<pre>
```markdown
```sql
-- Counting the distinct customer IDs
SELECT COUNT(DISTINCT customer_id) AS customers
FROM subscriptions;
```
```
</pre>


Replace `-- SQL code goes here` with your SQL code. When you wrap it with the `sql` identifier, GitHub will syntax highlight the code accordingly.

Here's an example:

```markdown
```sql
SELECT * FROM subscriptions WHERE plan_id = 3;
