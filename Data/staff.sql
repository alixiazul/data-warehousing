DROP DATABASE IF EXISTS ncstaffsql;
CREATE DATABASE ncstaffsql;

\c ncstaffsql

CREATE TABLE staff
(
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    area VARCHAR(50),
    course VARCHAR(100),
    manager VARCHAR(50),
    mentees INT,
    next_cohort_date TEXT,
    mentees_staff_rating INT,
    daily_rate FLOAT,
    revenue FLOAT
);

INSERT INTO staff 
    (first_name, last_name, area, course, manager, mentees, next_cohort_date, mentees_staff_rating, daily_rate, revenue)
VALUES 
('Alex', 'Swain', 'Remote', 'Data', 'Joe Mulvey', 11, '12 January 2024', 10, 700.98, 9112.74),
('Stephen', 'Corke', 'Manchester', 'Software', 'Paul Rogerson', 0, '24 February 2024', 8, 600.28, 7803.64),
('Verity', 'Gregory', 'Remote', 'Software', 'Stephen Corke', 13, '24 March 2024', 9, 578.26, 7517.38),
('Simon', 'Jackson', 'Leeds', 'Data', 'Alex Swain', 18, '12 January 2024', 2, 12.99, 168.87),
('Paul', 'Copley', 'Manchester', 'Data', 'Paul Rogerson', 0, '12 May 2024', 9, 699.00, 9087.00),
('Paul', 'Rogerson', 'Manchester', 'Software', 'Sam Caine', 0, '24 June 2024', 4, 150.01, 1950.13),
('John', 'Hutcheon', 'Manchester', 'Software', 'August Aldred', 9, '24 July 2024', 7, 200.67, 2608.71),
('Jodie', 'Cheung', 'Manchester', 'Software', 'August Aldred', 9, '24 August 2024', 7, 400.05, 5200.65),
('Pippa', 'Austin', 'Manchester', 'Software', 'August Aldred', 10, '13 April 2024', 8, 400.04, 5200.52),
('Bela', 'Bertalan', 'Manchester', 'Software', 'August Aldred', 11, '17 October 2024', 6, 370.89, 4821.57),
('Emily', 'Bennett', 'Manchester', 'Cloud', 'James Heggs', 6, '03 November 2024', 7, 550.35, 7154.55),
('Mezz', 'Davies', 'Leeds', 'Software', 'David Bartlett', 12, '17 December 2024', 7, 548.33, 7128.29),
('Danika', 'Crawley', 'Manchester', 'Data', 'Joe Mulvey', 8, '12 May 2024', 9, 698.99, 9086.87),
('August', 'Aldred', 'Manchester', 'Software', 'Paul Rogerson', 13, '24 August 2024', 8, 439.09, 5708.17),
('Lee', 'Kirkham', 'Leeds', 'Software', 'David Bartlett', 14, '17 January 2024', 5, 421.89, 5484.57),
('Hev', 'Magnier-Ashton', 'Manchester', 'Software', 'Rose Mullan', 9, '17 January 2024', 5, 511.45, 6648.85),
('Eli', 'Wiggins', 'Manchester', 'Cloud', 'James Heggs', 11, '03 March 2024', 8, 588.88, 7655.44),
('Kyle', 'McPhail', 'Manchester', 'Data', 'Joe Mulvey', 7, '12 January 2024', 5, 199.99, 2599.87),
('Katherine', 'Hurst', 'Manchester', 'Software', 'Stephen Corke', 10, '13 April 2024', 8, 665.35, 8649.55),
('David', 'Bartlett', 'Leeds', 'Software', 'Rose Mullan', 2, '13 April 2024', 3, 89.98, 1709.62),
('Chon', 'Lee', 'Manchester', 'Data', 'Joe Mulvey', 15, '12 May 2024', 4, 50.67, 658.71);

SELECT * FROM staff;