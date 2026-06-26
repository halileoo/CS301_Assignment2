SELECT
    c.full_name,
    SUM(t.amount) AS total_spent
FROM bank.customers c
         JOIN bank.accounts a ON c.id = a.customer_id
         JOIN bank.cards cd ON a.id = cd.account_id
         JOIN bank.transactions t ON cd.id = t.card_id
WHERE c.country = 'United States'
  AND cd.brand = 'Visa'
  AND cd.status = 'active'
  AND t.type = 'purchase'
GROUP BY c.full_name;
