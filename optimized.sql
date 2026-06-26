-- індекси для оптимізації блоків where
CREATE INDEX idx_customers_country ON bank.customers(country);
CREATE INDEX idx_cards_brand_status ON bank.cards(brand, status);
CREATE INDEX idx_transactions_type ON bank.transactions(type);

-- індекси для оптимізації блоків join
CREATE INDEX idx_accounts_customer_id ON bank.accounts(customer_id);
CREATE INDEX idx_cards_account_id ON bank.cards(account_id);
CREATE INDEX idx_transactions_card_id ON bank.transactions(card_id);

WITH us_customers AS (
    SELECT id, full_name
    FROM bank.customers
    WHERE country = 'United States'
),
active_visa_cards AS (
   SELECT id, account_id
   FROM bank.cards
   WHERE brand = 'Visa' AND status = 'active'
),
purchases AS (
   SELECT card_id, amount
   FROM bank.transactions
   WHERE type = 'purchase'
)
SELECT
    c.full_name,
    SUM(p.amount) AS total_spent
FROM us_customers c
         JOIN bank.accounts a ON c.id = a.customer_id
         JOIN active_visa_cards vc ON a.id = vc.account_id
         JOIN purchases p ON vc.id = p.card_id
GROUP BY c.full_name;
