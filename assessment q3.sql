SELECT 
    p.id AS plan_id,
    p.owner_id,
    p.plan_type_id AS type,
    MAX(t.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(t.created_on)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount t ON t.plan_id = p.id
GROUP BY p.id
HAVING last_transaction_date IS NOT NULL AND inactivity_days > 365;
