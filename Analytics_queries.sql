-- Tala Mobile Lending Uganda - KPI Queries

-- 1. Total loan portfolio
SELECT COUNT(*) AS total_loans, SUM(amount_ugx) AS total_disbursed
FROM loans;

-- 2. Total repayments collected
SELECT SUM(amount_paid) AS total_collected
FROM repayments;

-- 3. Outstanding loans
SELECT l.loan_id, c.first_name, c.last_name, l.amount_ugx, l.status
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
WHERE l.status IN ('Pending','Active','Defaulted');

-- 4. Loan officer performance
SELECT lo.first_name || ' ' || lo.last_name AS officer_name,
       COUNT(l.loan_id) AS loans_handled,
       SUM(l.amount_ugx) AS total_amount
FROM loans l
JOIN loan_officers lo ON l.officer_id = lo.officer_id
GROUP BY lo.first_name, lo.last_name
ORDER BY total_amount DESC;

-- 5. Average loan size
SELECT AVG(amount_ugx) AS avg_loan_amount
FROM loans;

-- 6. Loan status breakdown
SELECT status, COUNT(*) AS count, SUM(amount_ugx) AS total_amount
FROM loans
GROUP BY status
ORDER BY total_amount DESC;

-- 7. Repayment rate (collected vs disbursed)
SELECT 
    SUM(r.amount_paid)/SUM(l.amount_ugx)*100 AS repayment_percentage
FROM loans l
JOIN repayments r ON l.loan_id = r.loan_id;
