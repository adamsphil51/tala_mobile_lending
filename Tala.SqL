-- Tala Microfinance Uganda - Loan Database
-- Realistic sample data for portfolio analysis
-- PostgreSQL

DROP TABLE IF EXISTS repayments CASCADE;
DROP TABLE IF EXISTS loans CASCADE;
DROP TABLE IF EXISTS loan_officers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- CUSTOMERS
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(20),
    city VARCHAR(100),
    date_joined DATE NOT NULL,
    credit_score INT CHECK (credit_score BETWEEN 300 AND 850)
);

INSERT INTO customers (first_name, last_name, email, phone, city, date_joined, credit_score)
VALUES
('Brian', 'Kato', 'xxxxx@email.com', '07XXXXXXX', 'Kampala', '2023-01-10', 720),
('Sarah', 'Nabirye', 'xxxxx@email.com', '07XXXXXXX', 'Jinja', '2023-02-15', 690),
('Michael', 'Okello', 'xxxxx@email.com', '07XXXXXXX', 'Gulu', '2023-03-12', 710),
('Prossy', 'Namugenyi', 'xxxxx@email.com', '07XXXXXXX', 'Mbarara', '2023-04-05', 650),
('David', 'Mugisha', 'xxxxx@email.com', '07XXXXXXX', 'Kampala', '2023-05-20', 730),
('Grace', 'Achieng', 'xxxxx@email.com', '07XXXXXXX', 'Lira', '2023-06-01', 705),
('Daniel', 'Ssekandi', 'xxxxx@email.com', '07XXXXXXX', 'Entebbe', '2023-07-18', 675),
('Esther', 'Nakimuli', 'xxxxx@email.com', '07XXXXXXX', 'Masaka', '2023-08-22', 740);

-- LOAN OFFICERS
CREATE TABLE loan_officers (
    officer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO loan_officers (first_name, last_name, branch_city, hire_date)
VALUES
('Joseph', 'Balikuddembe', 'Kampala', '2020-03-12'),
('Annet', 'Namazzi', 'Jinja', '2021-06-08'),
('Robert', 'Byaruhanga', 'Mbarara', '2019-11-25'),
('Miriam', 'Nakitende', 'Kampala', '2022-01-14'),
('Patrick', 'Ouma', 'Gulu', '2020-09-05');

-- LOANS
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    officer_id INT REFERENCES loan_officers(officer_id),
    amount_ugx NUMERIC(15,2) NOT NULL,
    interest_rate NUMERIC(5,2) NOT NULL,
    date_issued DATE NOT NULL,
    due_date DATE NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Active', 'Paid', 'Defaulted'))
);

INSERT INTO loans (customer_id, officer_id, amount_ugx, interest_rate, date_issued, due_date, status)
VALUES
(1,1,500000,5.5,'2023-02-01','2023-03-01','Paid'),
(2,2,800000,6.0,'2023-03-10','2023-04-10','Active'),
(3,5,600000,5.2,'2023-04-05','2023-05-05','Paid'),
(4,1,1200000,6.8,'2023-05-15','2023-06-15','Defaulted'),
(5,4,950000,5.7,'2023-06-01','2023-07-01','Paid'),
(6,3,700000,5.5,'2023-07-12','2023-08-12','Active'),
(7,2,1100000,6.3,'2023-08-20','2023-09-20','Pending'),
(8,1,1500000,6.9,'2023-09-10','2023-10-10','Active');

-- REPAYMENTS
CREATE TABLE repayments (
    repayment_id SERIAL PRIMARY KEY,
    loan_id INT REFERENCES loans(loan_id),
    payment_date DATE NOT NULL,
    amount_paid NUMERIC(15,2) NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Mobile Money', 'Bank Transfer', 'Cash'))
);

INSERT INTO repayments (loan_id, payment_date, amount_paid, payment_method)
VALUES
(1,'2023-02-28',527500,'Mobile Money'),
(3,'2023-05-03',631200,'Bank Transfer'),
(5,'2023-06-30',1004350,'Mobile Money');
