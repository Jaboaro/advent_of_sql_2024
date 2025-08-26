SELECT sum(
    CASE
        WHEN year_end_performance_scores[array_upper(year_end_performance_scores, 1)] > 
            (SELECT avg(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) FROM employees)
        THEN salary*1.15
        ELSE salary
        END 
) AS total_salary_with_bonuses
FROM employees;

