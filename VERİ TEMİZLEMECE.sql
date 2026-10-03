


SELECT *
FROM [dbo].[subscriptions_raw]



SELECT
DISTINCT(COUNT(subscription_id)),
COUNT(*),
COUNT(subscription_id)
from [dbo].[subscriptions_raw]



SELECT
DISTINCT(COUNT(customer_id)),
COUNT(*),
COUNT(customer_id)
from [dbo].[subscriptions_raw]










SELECT COUNT(customer_email)
FROM [dbo].[subscriptions_raw]


SELECT *
FROM [dbo].[subscriptions_raw]




SELECT TRIM(LOWER(customer_email))
FROM [dbo].[subscriptions_raw]
WHERE customer_email IS NOT NULL 
AND customer_email  LIKE '%@%'
AND customer_email NOT LIKE '%test%'
GROUP BY LOWER(customer_email)







SELECT
DISTINCT(country)
from dbo.subscriptions_raw


SELECT
    CASE
        WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.') THEN 'United Kingdom'
        WHEN UPPER(TRIM(country)) IN ('IT', 'ITALY') THEN 'Italy'
        WHEN UPPER(TRIM(country)) IN ('IRELAND', 'IE') THEN 'Ireland'
        WHEN UPPER(TRIM(country)) IN ('GERMANY', 'DE') THEN 'Germany'
        ELSE country
    END AS country,
    COUNT(*) AS country_count
FROM dbo.subscriptions_raw
GROUP BY
    CASE
        WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.') THEN 'United Kingdom'
        WHEN UPPER(TRIM(country)) IN ('IT', 'ITALY') THEN 'Italy'
        WHEN UPPER(TRIM(country)) IN ('IRELAND', 'IE') THEN 'Ireland'
        WHEN UPPER(TRIM(country)) IN ('GERMANY', 'DE') THEN 'Germany'
        ELSE country
    END;






SELECT
    DISTINCT([plan])
FROM dbo.subscriptions_raw;


WITH cte as (
SELECT 
    CASE
        WHEN TRIM(LOWER([plan])) IN ('basýc') THEN 'basic'
        WHEN TRIM(LOWER([plan])) IN ('free') THEN 'free'
        WHEN TRIM(LOWER([plan])) IN ('premýum') THEN 'premium'
        ELSE TRIM(LOWER([plan]))
    END AS cleaned_plan
FROM dbo.subscriptions_raw
)

SELECT
cleaned_plan,
COUNT(*)
from cte
group by cleaned_plan;








SELECT monthly_price
FROM [dbo].[subscriptions_raw]



SELECT
    monthly_price,
    CASE
        WHEN monthly_price < 0 THEN ABS(monthly_price)
        WHEN monthly_price > 100 THEN monthly_price / 100
        ELSE monthly_price
    END AS monthly_price_cleaned
FROM dbo.subscriptions_raw
WHERE monthly_price < 0
   OR monthly_price > 100;



SELECT
    monthly_price,
    CASE
        WHEN monthly_price < 0 THEN ABS(monthly_price)
        WHEN monthly_price > 100 THEN monthly_price / 100
        ELSE monthly_price
    END AS monthly_price_cleaned
FROM dbo.subscriptions_raw;





SELECT
DISTINCT(TRIM(LOWER(status)))
FROM dbo.subscriptions_raw



SELECT DISTINCT
CASE 
WHEN TRIM(LOWER(status)) IN ('actýve') THEN 'active'
WHEN TRIM(LOWER(status)) IN ('cancelled') THEN 'canceled'
ELSE TRIM(LOWER(status))
end as status
FROM dbo.subscriptions_raw




SELECT 
CASE 
WHEN TRIM(LOWER(status)) IN ('actýve') THEN 'active'
WHEN TRIM(LOWER(status)) IN ('cancelled') THEN 'canceled'
ELSE TRIM(LOWER(status))
end as status
FROM dbo.subscriptions_raw





SELECT
    start_date,
    CASE
        WHEN start_date IS NULL THEN 'Missing'
        WHEN start_date < '2024-01-01'
          OR start_date > '2026-12-31' THEN 'Suspicious'
        ELSE 'Valid'
    END AS date_quality
FROM dbo.subscriptions_raw;




SELECT
*
FROM dbo.subscriptions_raw



SELECT
    subscription_id,
    COUNT(*) AS record_count
FROM dbo.subscriptions_raw
GROUP BY subscription_id
HAVING COUNT(*) > 1;




SELECT
CASE
WHEN LOWER(status) LIKE '%active%' AND end_date IS NOT NULL THEN 'active with an end date'
WHEN LOWER(status) LIKE '%cancel%' AND end_date IS  NULL THEN 'cancelled without an end date'
WHEN LOWER([plan]) NOT LIKE '%free%' AND monthly_price = 0 THEN 'paid plan with 0 price'
ELSE 'ok'
END AS quality_flag,
COUNT(*)
from dbo.subscriptions_raw
GROUP BY 
CASE
WHEN LOWER(status) LIKE '%active%' AND end_date IS NOT NULL THEN 'active with an end date'
WHEN LOWER(status) LIKE '%cancel%' AND end_date IS  NULL THEN 'cancelled without an end date'
WHEN LOWER([plan]) NOT LIKE '%free%' AND monthly_price = 0 THEN 'paid plan with 0 price'
ELSE 'ok'
END;













