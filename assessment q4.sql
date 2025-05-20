SELECT 
    u.id,
    u.first_name as name,
    TIMESTAMPDIFF(MONTH, MIN(sa.created_on), CURDATE()) AS tenure_months,
    sum(deduction_amount) as total_transaction,
    ROUND((COUNT(sa.id) / TIMESTAMPDIFF(MONTH, MIN(sa.created_on), CURDATE())) * 12 * 0.1, 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount sa ON sa.id = u.id
GROUP BY u.id
HAVING tenure_months > 0
ORDER BY estimated_clv DESC;
