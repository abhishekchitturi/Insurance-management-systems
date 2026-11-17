CREATE DATABASE Insurance_Management;
USE Insurance_Management;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    registration_date DATE
);
CREATE TABLE Policies (
    policy_id INT PRIMARY KEY,
    policy_name VARCHAR(100),
    policy_type VARCHAR(50),
    premium_amount DECIMAL(10,2),
    coverage_amount DECIMAL(12,2),
    duration_years INT
);
CREATE TABLE Agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    branch VARCHAR(100)
);
CREATE TABLE Customer_Policies (
    customer_policy_id INT PRIMARY KEY,
    customer_id INT,
    policy_id INT,
    agent_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id),
    FOREIGN KEY (agent_id) REFERENCES Agents(agent_id)
);
CREATE TABLE Premium_Payments (
    payment_id INT PRIMARY KEY,
    customer_policy_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (customer_policy_id)
    REFERENCES Customer_Policies(customer_policy_id)
);
CREATE TABLE Claims (
    claim_id INT PRIMARY KEY,
    customer_policy_id INT,
    claim_amount DECIMAL(12,2),
    claim_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_policy_id)
    REFERENCES Customer_Policies(customer_policy_id)
);
INSERT INTO Customers VALUES
(1, 'Rahul', 'rahul@gmail.com', '9876543210', 'Hyderabad', '2025-01-10'),
(2, 'Priya', 'priya@gmail.com', '9876543211', 'Vijayawada', '2025-02-15'),
(3, 'Arjun', 'arjun@gmail.com', '9876543212', 'Hyderabad', '2025-03-20'),
(4, 'Sneha', 'sneha@gmail.com', '9876543213', 'Bangalore', '2025-04-05'),
(5, 'Kiran', 'kiran@gmail.com', '9876543214', 'Hyderabad', '2025-05-12');
INSERT INTO Policies VALUES
(101, 'Life Secure', 'Life', 6000, 1000000, 10),
(102, 'Health Plus', 'Health', 4500, 500000, 5),
(103, 'Car Protect', 'Vehicle', 7000, 800000, 3),
(104, 'Family Care', 'Health', 8500, 1500000, 10),
(105, 'Term Life', 'Life', 5500, 2000000, 20);
INSERT INTO Agents VALUES
(201, 'Ramesh', '9988776655', 'ramesh@gmail.com', 'Hyderabad'),
(202, 'Suresh', '9988776656', 'suresh@gmail.com', 'Vijayawada'),
(203, 'Mahesh', '9988776657', 'mahesh@gmail.com', 'Bangalore');
INSERT INTO Customer_Policies VALUES
(301, 1, 101, 201, '2025-01-15', '2035-01-14', 'Active'),
(302, 2, 102, 202, '2025-02-20', '2030-02-19', 'Active'),
(303, 3, 103, 201, '2025-03-25', '2028-03-24', 'Expired'),
(304, 4, 104, 203, '2025-04-10', '2035-04-09', 'Active'),
(305, 5, 105, 201, '2025-05-15', '2045-05-14', 'Active');
INSERT INTO Premium_Payments VALUES
(401, 301, 6000, '2025-02-15', 'UPI', 'Paid'),
(402, 302, 4500, '2025-03-20', 'Card', 'Paid'),
(403, 303, 7000, '2025-04-25', 'Cash', 'Paid'),
(404, 304, 8500, '2025-05-10', 'UPI', 'Paid'),
(405, 305, 5500, '2025-06-15', 'Net Banking', 'Pending');
INSERT INTO Claims VALUES
(501, 301, 50000, '2025-06-10', 'Approved'),
(502, 302, 25000, '2025-07-15', 'Pending'),
(503, 303, 100000, '2025-08-20', 'Rejected'),
(504, 304, 75000, '2025-09-05', 'Approved'),
(505, 301, 30000, '2025-10-12', 'Pending');
SELECT * FROM Customers;
SELECT * FROM Policies
WHERE premium_amount > 5000;
SELECT * FROM Customers
WHERE address = 'Hyderabad';
SELECT
    cp.customer_policy_id,
    c.name AS customer_name,
    p.policy_name,
    cp.status
FROM Customer_Policies cp
JOIN Customers c
ON cp.customer_id = c.customer_id
JOIN Policies p
ON cp.policy_id = p.policy_id
WHERE cp.status = 'Active';
SELECT * FROM Policies
WHERE duration_years > 5;
SELECT
    c.name AS customer_name,
    p.policy_name,
    p.policy_type,
    p.premium_amount
FROM Customers c
JOIN Customer_Policies cp
ON c.customer_id = cp.customer_id
JOIN Policies p
ON cp.policy_id = p.policy_id;
SELECT
    p.policy_name,
    p.policy_type,
    a.agent_name,
    a.phone,
    a.branch
FROM Customer_Policies cp
JOIN Policies p
ON cp.policy_id = p.policy_id
JOIN Agents a
ON cp.agent_id = a.agent_id;
SELECT
    cl.claim_id,
    c.name AS customer_name,
    p.policy_name,
    cl.claim_amount,
    cl.claim_date,
    cl.status
FROM Claims cl
JOIN Customer_Policies cp
ON cl.customer_policy_id = cp.customer_policy_id
JOIN Customers c
ON cp.customer_id = c.customer_id
JOIN Policies p
ON cp.policy_id = p.policy_id;
SELECT
    pp.payment_id,
    c.name AS customer_name,
    p.policy_name,
    pp.amount,
    pp.payment_date,
    pp.payment_mode,
    pp.status
FROM Premium_Payments pp
JOIN Customer_Policies cp
ON pp.customer_policy_id = cp.customer_policy_id
JOIN Customers c
ON cp.customer_id = c.customer_id
JOIN Policies p
ON cp.policy_id = p.policy_id;
SELECT
    c.name AS customer_name,
    a.agent_name,
    a.branch
FROM Customer_Policies cp
JOIN Customers c
ON cp.customer_id = c.customer_id
JOIN Agents a
ON cp.agent_id = a.agent_id;
SELECT COUNT(*) AS total_policies
FROM Policies;
SELECT AVG(premium_amount) AS average_premium
FROM Policies;
SELECT SUM(amount) AS total_premium_collected
FROM Premium_Payments
WHERE status = 'Paid';
SELECT COUNT(*) AS total_claims
FROM Claims;
SELECT
    policy_name,
    coverage_amount
FROM Policies
WHERE coverage_amount = (
    SELECT MAX(coverage_amount)
    FROM Policies
);
SELECT
    c.name,
    pp.amount,
    pp.status
FROM Customers c
JOIN Customer_Policies cp
ON c.customer_id = cp.customer_id
JOIN Premium_Payments pp
ON cp.customer_policy_id = pp.customer_policy_id
WHERE pp.status = 'Pending';
SELECT * FROM Claims
WHERE status = 'Approved';
SELECT
    a.agent_name,
    COUNT(cp.customer_id) AS total_customers
FROM Agents a
JOIN Customer_Policies cp
ON a.agent_id = cp.agent_id
GROUP BY a.agent_name;
SELECT SUM(claim_amount) AS total_claim_amount
FROM Claims;
SELECT policy_name, premium_amount
FROM Policies
ORDER BY premium_amount DESC;