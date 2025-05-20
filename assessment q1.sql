SELECT 
    u.id ,
    u.first_name as name,
    COUNT(DISTINCT sa.id) AS savings_accounts,
    COUNT(DISTINCT p.id) AS investment_plans,
    SUM(p.amount) AS total_investment_amount
FROM users_customuser u
JOIN plans_plan p ON p.owner_id = u.id AND p.plan_type_id = 2
JOIN savings_savingsaccount sa ON sa.id = u.id
GROUP BY u.id
ORDER BY total_investment_amount DESC;
