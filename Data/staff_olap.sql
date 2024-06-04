\c ncstaffsql

DROP TABLE IF EXISTS fact_revenue;

DROP TABLE IF EXISTS dim_staff;
CREATE TABLE dim_staff
(
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    mentees INT,
    mentees_staff_rating INT,
    daily_rate FLOAT
);

INSERT INTO dim_staff (staff_id, first_name, last_name, mentees, mentees_staff_rating, daily_rate)
SELECT staff_id, first_name, last_name, mentees, mentees_staff_rating, daily_rate 
FROM staff
RETURNING *;

DROP TABLE IF EXISTS dim_manager;
CREATE TABLE dim_manager
(
    manager_id SERIAL PRIMARY KEY,
    manager VARCHAR(50),
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

INSERT INTO dim_manager (manager, first_name, last_name)
SELECT 
    DISTINCT manager, 
    SPLIT_PART(manager, ' ', 1) AS first_name,
    SPLIT_PART(manager, ' ', 2) AS last_name
FROM staff
RETURNING *;

DROP TABLE IF EXISTS dim_course;
CREATE TABLE dim_course
(
    course_id SERIAL PRIMARY KEY,
    course VARCHAR(100)
);

INSERT INTO dim_course (course)
SELECT DISTINCT course
FROM staff
RETURNING *;

DROP TABLE IF EXISTS dim_cohort_date;
CREATE TABLE dim_cohort_date
(
    next_cohort_date_id SERIAL PRIMARY KEY,
    next_cohort_date TEXT,
    next_cohort_day INT,
    next_cohort_month_text TEXT,
    next_cohort_month_number INT,
    next_cohort_quarter INT,
    next_cohort_year INT
);

INSERT INTO dim_cohort_date 
(
    next_cohort_date, 
    next_cohort_day, 
    next_cohort_month_text, 
    next_cohort_month_number,
    next_cohort_quarter,
    next_cohort_year
)
SELECT 
    DISTINCT next_cohort_date,
    EXTRACT(DAY FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) AS next_cohort_day,
    TO_CHAR(TO_DATE(next_cohort_date, 'DD Month YYYY'), 'Month') AS next_cohort_month_text,
    EXTRACT(MONTH FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) AS next_cohort_month_number,
    CASE 
        WHEN EXTRACT(MONTH FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) BETWEEN 1 AND 3 THEN 1
        WHEN EXTRACT(MONTH FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) BETWEEN 4 AND 6 THEN 2
        WHEN EXTRACT(MONTH FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) BETWEEN 7 AND 9 THEN 3
        ELSE 4
    END AS next_cohort_quarter,
    EXTRACT(YEAR FROM TO_DATE(next_cohort_date, 'DD Month YYYY')) AS next_cohort_year
FROM staff
RETURNING *;

DROP TABLE IF EXISTS dim_area;
CREATE TABLE dim_area
(
    area_id SERIAL PRIMARY KEY,
    area TEXT
);

INSERT INTO dim_area (area)
SELECT DISTINCT area
FROM staff
RETURNING *;

CREATE TABLE fact_revenue
(
    revenue_id SERIAL PRIMARY KEY,
    revenue FLOAT,
    staff_fk INT REFERENCES dim_staff(staff_id) ON DELETE SET NULL,
    manager_fk INT REFERENCES dim_manager(manager_id) ON DELETE SET NULL,
    course_fk INT REFERENCES dim_course(course_id) ON DELETE SET NULL,
    date_fk INT REFERENCES dim_cohort_date(next_cohort_date_id) ON DELETE SET NULL,
    area_fk INT REFERENCES dim_area(area_id) ON DELETE SET NULL
);

WITH revenue_with_keys AS (
    -- SELECT revenue FROM staff,
    -- SELECT staff_id FROM staff WHERE staff.revenue = revenue_with_keys.revenue,
    -- SELECT manager_id FROM dim_manager WHERE dim_manager.manager = staff.manager,
    -- SELECT course_id FROM dim_course WHERE dim_course.course = staff.course,
    -- SELECT next_cohort_date_id FROM dim_cohort_date WHERE dim_cohort_date.next_cohort_date = staff.next_cohort_date,
    -- SELECT area_id FROM dim_area WHERE dim_area.area = staff.area
    SELECT 
        staff.revenue,
        staff.staff_id,
        dim_manager.manager_id,
        dim_course.course_id,
        dim_cohort_date.next_cohort_date_id,
        dim_area.area_id
    FROM staff
    JOIN dim_manager ON dim_manager.manager = staff.manager
    JOIN dim_course ON dim_course.course = staff.course
    JOIN dim_cohort_date ON dim_cohort_date.next_cohort_date = staff.next_cohort_date
    JOIN dim_area ON dim_area.area = staff.area
)
INSERT INTO fact_revenue (
    revenue,
    staff_fk,
    manager_fk,
    course_fk,
    date_fk,
    area_fk
)
SELECT
    revenue,
    staff_id,
    manager_id,
    course_id,
    next_cohort_date_id,
    area_id
FROM revenue_with_keys
RETURNING *;