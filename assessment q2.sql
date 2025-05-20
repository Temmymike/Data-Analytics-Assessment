WITH txn_per_month AS (
    SELECT 
        id,
        DATE_FORMAT(created_on, '%Y-%m') AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY id, txn_month
),
avg_txn AS (
    SELECT 
        id,
        AVG(txn_count) AS avg_txn_per_month
    FROM txn_per_month
    GROUP BY id
)
SELECT 
    CASE
        WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_band,
    COUNT(id) AS customers,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_txn
FROM avg_txn
GROUP BY frequency_band;
