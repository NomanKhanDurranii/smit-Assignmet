-- Exercise #01

SELECT 
    main_distance,
    COUNT(*) AS runners_number
FROM runner
GROUP BY main_distance
HAVING COUNT(*) > 3;


-- Exercise #02

SELECT 
    e.name AS event_name,
    COUNT(re.runner_id) AS runner_count
FROM event e
LEFT JOIN runner_event re 
    ON e.id = re.event_id
GROUP BY e.id, e.name
ORDER BY e.name;


-- Exercise #03

SELECT 
    main_distance,
    COUNT(CASE WHEN age < 20 THEN 1 END) AS under_20,
    COUNT(CASE WHEN age BETWEEN 20 AND 29 THEN 1 END) AS age_20_29,
    COUNT(CASE WHEN age BETWEEN 30 AND 39 THEN 1 END) AS age_30_39,
    COUNT(CASE WHEN age BETWEEN 40 AND 49 THEN 1 END) AS age_40_49,
    COUNT(CASE WHEN age >= 50 THEN 1 END) AS over_50
FROM runner
GROUP BY main_distance
ORDER BY main_distance;

