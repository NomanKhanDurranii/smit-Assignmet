--		Exercise #01

SELECT 
    cl.name AS clothes,
    col.name AS color,
    cu.last_name,
    cu.first_name
FROM clothing_order co
JOIN clothing cl 
    ON co.clothing_id = cl.id
JOIN color col 
    ON cl.color_id = col.id
JOIN customer cu 
    ON co.customer_id = cu.id
WHERE cl.color_id = cu.favorite_color_id
ORDER BY col.name ASC;


-- 			Exercise #02

SELECT 
    cu.last_name,
    cu.first_name,
    col.name AS favorite_color
FROM customer cu
LEFT JOIN color col 
    ON cu.favorite_color_id = col.id
LEFT JOIN clothing_order co 
    ON cu.id = co.customer_id
WHERE co.id IS NULL;

-- 			Exercise #03

SELECT 
    main.name AS category,
    sub.name AS subcategory
FROM category main
LEFT JOIN category sub 
    ON sub.parent_id = main.id
WHERE main.parent_id IS NULL;
