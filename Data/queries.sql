\c ncstaffsql

\! echo ''
\! echo 'Manager with the lowest-rated staff member:'
\! echo ''

SELECT manager, mentees_staff_rating AS lowest_rating_staff_member
FROM dim_manager
JOIN fact_revenue ON fact_revenue.manager_fk = dim_manager.manager_id
JOIN dim_staff ON fact_revenue.staff_fk = dim_staff.staff_id
ORDER BY mentees_staff_rating ASC
LIMIT 1;


\! echo ''
\! echo 'Staff member that has worked the most cohort based on how much they charge per event and the total revenue so far:'
\! echo ''
SELECT 
    first_name || ' ' || last_name AS staff_member,
    daily_rate,
    revenue AS total_revenue,
    (revenue / daily_rate)::INT AS revenue_per_daily_rate
FROM dim_staff
JOIN fact_revenue ON fact_revenue.staff_fk = dim_staff.staff_id
ORDER BY revenue_per_daily_rate DESC
LIMIT 1;

\! echo ''
\! echo 'Busiest quarter for our staff members:'
\! echo ''
SELECT next_cohort_quarter
FROM dim_cohort_date;