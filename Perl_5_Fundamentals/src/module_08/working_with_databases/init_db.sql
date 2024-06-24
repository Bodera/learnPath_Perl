-- Create the houses table
CREATE TABLE houses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2)
);

INSERT INTO houses (name, price) VALUES
    ('House 1', 100000.00),
    ('House 2', 150000.00),
    ('House 3', 200000.00),
    ('House 4', 180000.00),
    ('House 5', 220000.00),
    ('House 6', 130000.00),
    ('House 7', 190000.00),
    ('House 8', 170000.00),
    ('House 9', 240000.00),
    ('House 10', 160000.00);
