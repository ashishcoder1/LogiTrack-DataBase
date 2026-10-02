DROP DATABASE IF EXISTS LogiTrack;
CREATE DATABASE LogiTrack;

USE LogiTrack;

CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    capacity_units INT NOT NULL,
    manager_name VARCHAR(100)
);

INSERT INTO Warehouses
(warehouse_id, warehouse_name, city, state, capacity_units, manager_name)
VALUES
(101, 'Mumbai Central Warehouse', 'Mumbai', 'Maharashtra', 50000, 'Rajesh Sharma'),
(102, 'Pune Distribution Center', 'Pune', 'Maharashtra', 40000, 'Amit Patil'),
(103, 'Delhi Logistics Hub', 'Delhi', 'Delhi', 60000, 'Vikas Singh'),
(104, 'Bangalore Supply Hub', 'Bangalore', 'Karnataka', 45000, 'Suresh Kumar'),
(105, 'Hyderabad Warehouse', 'Hyderabad', 'Telangana', 35000, 'Ravi Reddy'),
(106, 'Chennai Distribution Center', 'Chennai', 'Tamil Nadu', 42000, 'Arun Kumar');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    weight_kg DECIMAL(10,2)
);

INSERT INTO Products
(product_id, product_name, category, unit_price, weight_kg)
VALUES
(201, 'Laptop', 'Electronics', 65000.00, 2.20),
(202, 'Smartphone', 'Electronics', 28000.00, 0.50),
(203, 'Wireless Headphones', 'Accessories', 3500.00, 0.30),
(204, 'Office Chair', 'Furniture', 8500.00, 12.00),
(205, 'Monitor', 'Electronics', 15000.00, 5.50),
(206, 'Running Shoes', 'Footwear', 4500.00, 0.90);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    warehouse_id INT,
    product_id INT,
    stock_quantity INT NOT NULL,
    reorder_level INT,
    last_restock_date DATE,

    FOREIGN KEY (warehouse_id)
        REFERENCES Warehouses(warehouse_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

INSERT INTO Inventory
(inventory_id, warehouse_id, product_id, stock_quantity, reorder_level, last_restock_date)
VALUES
(301, 101, 201, 450, 100, '2026-09-10'),
(302, 101, 202, 850, 200, '2026-09-12'),
(303, 102, 203, 1200, 300, '2026-09-15'),
(304, 103, 204, 180, 100, '2026-09-08'),
(305, 104, 205, 500, 150, '2026-09-14'),
(306, 105, 206, 750, 200, '2026-09-10');

UPDATE Inventory
SET stock_quantity = 50
WHERE inventory_id = 301;

UPDATE Inventory
SET stock_quantity = 80
WHERE inventory_id = 304;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    customer_type VARCHAR(30)
);

INSERT INTO Customers
(customer_id, customer_name, city, state, customer_type)
VALUES
(401, 'Rahul Mehta', 'Mumbai', 'Maharashtra', 'Retail'),
(402, 'Priya Sharma', 'Pune', 'Maharashtra', 'Business'),
(403, 'Aman Verma', 'Delhi', 'Delhi', 'Retail'),
(404, 'Neha Kapoor', 'Bangalore', 'Karnataka', 'Business'),
(405, 'Rohit Patil', 'Hyderabad', 'Telangana', 'Retail'),
(406, 'Sneha Iyer', 'Chennai', 'Tamil Nadu', 'Business');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    warehouse_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    order_value DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (warehouse_id)
        REFERENCES Warehouses(warehouse_id)
);

INSERT INTO Orders
(order_id, customer_id, warehouse_id, order_date, order_status, order_value)
VALUES
(501, 401, 101, '2026-09-01', 'Delivered', 68000.00),
(502, 402, 102, '2026-09-02', 'Delivered', 15000.00),
(503, 403, 103, '2026-09-03', 'Delivered', 32000.00),
(504, 404, 104, '2026-09-04', 'Delivered', 48000.00),
(505, 405, 105, '2026-09-05', 'Pending', 12500.00),
(506, 406, 106, '2026-09-06', 'Delayed', 8500.00);

CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    vehicle_number VARCHAR(30) UNIQUE,
    vehicle_type VARCHAR(50),
    capacity_kg DECIMAL(10,2),
    fuel_type VARCHAR(30),
    fuel_efficiency_kmpl DECIMAL(10,2),
    maintenance_status VARCHAR(30)
);

INSERT INTO Vehicles
(vehicle_id, vehicle_number, vehicle_type, capacity_kg, fuel_type, fuel_efficiency_kmpl, maintenance_status)
VALUES
(601, 'MH01AB1234', 'Mini Truck', 2000, 'Diesel', 12.5, 'Good'),
(602, 'MH02CD5678', 'Medium Truck', 5000, 'Diesel', 9.5, 'Good'),
(603, 'DL01EF9012', 'Heavy Truck', 10000, 'Diesel', 6.5, 'Maintenance Due'),
(604, 'KA01GH3456', 'Mini Truck', 2000, 'Diesel', 13.0, 'Good'),
(605, 'TS01IJ7890', 'Medium Truck', 5000, 'Diesel', 10.0, 'Good'),
(606, 'TN01KL2345', 'Heavy Truck', 12000, 'Diesel', 6.0, 'Good');


CREATE TABLE Drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    experience_years INT,
    rating DECIMAL(3,2)
);

INSERT INTO Drivers
(driver_id, driver_name, phone, experience_years, rating)
VALUES
(701, 'Ramesh Yadav', '9876500001', 8, 4.60),
(702, 'Mahesh Pawar', '9876500002', 5, 4.20),
(703, 'Sanjay Kumar', '9876500003', 10, 4.80),
(704, 'Deepak Singh', '9876500004', 6, 4.30),
(705, 'Vijay More', '9876500005', 4, 4.00),
(706, 'Ganesh Shinde', '9876500006', 9, 4.70);

CREATE TABLE Routes (
    route_id INT PRIMARY KEY,
    source_city VARCHAR(50),
    destination_city VARCHAR(50),
    distance_km DECIMAL(10,2),
    estimated_time_hours DECIMAL(10,2)
);

INSERT INTO Routes
(route_id, source_city, destination_city, distance_km, estimated_time_hours)
VALUES
(801, 'Mumbai', 'Pune', 150, 4.0),
(802, 'Mumbai', 'Nashik', 170, 4.5),
(803, 'Delhi', 'Jaipur', 280, 6.0),
(804, 'Delhi', 'Agra', 230, 5.0),
(805, 'Bangalore', 'Mysore', 145, 4.0),
(806, 'Hyderabad', 'Vijayawada', 275, 6.0);

CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    vehicle_id INT,
    driver_id INT,
    route_id INT,
    dispatch_date DATE,
    delivery_date DATE,
    delivery_status VARCHAR(30),
    delivery_cost DECIMAL(10,2),
    fuel_cost DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (vehicle_id)
        REFERENCES Vehicles(vehicle_id),

    FOREIGN KEY (driver_id)
        REFERENCES Drivers(driver_id),

    FOREIGN KEY (route_id)
        REFERENCES Routes(route_id)
);

INSERT INTO Deliveries
(delivery_id, order_id, vehicle_id, driver_id, route_id,
 dispatch_date, delivery_date, delivery_status, delivery_cost, fuel_cost)
VALUES
(901, 501, 601, 701, 801, '2026-09-02', '2026-09-02', 'On Time', 4200.00, 1800.00),
(902, 502, 602, 702, 802, '2026-09-03', '2026-09-03', 'On Time', 5000.00, 2100.00),
(903, 503, 603, 703, 803, '2026-09-04', '2026-09-05', 'Delayed', 8500.00, 4300.00),
(904, 504, 604, 704, 805, '2026-09-05', '2026-09-05', 'On Time', 3900.00, 1600.00),
(905, 505, 605, 705, 806, '2026-09-06', NULL, 'Pending', 4500.00, 2200.00),
(906, 506, 606, 706, 806, '2026-09-07', '2026-09-08', 'Delayed', 7800.00, 4200.00);

show tables;

Select * From customers;
Select * From deliveries;
Select * From drivers;
Select * From inventory;
Select * From orders;
Select * From products;
Select * From routes;
Select * From vehicles;
Select * From warehouses;



-- ******************************* Insights Analysis ****************************************

-- 1. Which warehouse holds the most stock?

SELECT w.warehouse_name,SUM(i.stock_quantity) AS total_stock
FROM Inventory i
INNER JOIN Warehouses w
ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_stock DESC;

-- 2. Which products are furthest below reorder level?

SELECT p.product_name, i.stock_quantity, i.reorder_level, i.reorder_level - i.stock_quantity AS shortfall
FROM Inventory i
INNER JOIN Products p
ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level
ORDER BY shortfall DESC;

-- 3. Which vehicle type uses fuel best?

SELECT vehicle_type, COUNT(*) AS vehicles, ROUND(AVG(fuel_efficiency_kmpl), 2) AS avg_kmpl
FROM Vehicles
GROUP BY vehicle_type
ORDER BY avg_kmpl DESC;

-- 4. Which drivers are rated above average?

SELECT driver_name, experience_years, rating
FROM Drivers
WHERE rating > (
                SELECT AVG(rating) FROM Drivers
				)
ORDER BY rating DESC;

-- 5. How many deliveries and how much cost are in each status?

SELECT delivery_status, COUNT(*) AS deliveries,
       SUM(delivery_cost) AS delivery_cost,
       SUM(fuel_cost) AS fuel_cost
FROM Deliveries
GROUP BY delivery_status
ORDER BY deliveries DESC;

-- 6. Which route has the highest fuel cost?

SELECT r.source_city, r.destination_city, SUM(d.fuel_cost) AS total_fuel_cost,
       RANK() OVER (
                    ORDER BY SUM(d.fuel_cost) DESC
                   ) AS cost_rank
FROM Deliveries d
INNER JOIN Routes r ON d.route_id = r.route_id
GROUP BY r.route_id, r.source_city, r.destination_city;







