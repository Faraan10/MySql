SELECT
    r1.region_name,
    s1.seller_id,
    s1.seller_name, 
    SUM(ot1.quantity) AS 'items_delivered'
FROM sellers s1
INNER JOIN products p1 
    ON s1.seller_id = p1.seller_id
INNER JOIN order_items ot1 
    ON p1.product_id = ot1.product_id
INNER JOIN shipments sh1 
    ON ot1.order_id = sh1.order_id
INNER JOIN orders o1
    ON ot1.order_id = o1.order_id
INNER JOIN users u1
    ON o1.user_id = u1.user_id
INNER JOIN regions r1 
    ON u1.region_id = r1.region_id
WHERE 
    s1.status = 'active' 
    AND (o1.order_date >= '2024-01-01' AND o1.order_date < '2025-01-01')
    AND sh1.status = 'Delivered'
GROUP BY
    r1.region_name,
    s1.seller_id,
    s1.seller_name
HAVING 
    SUM(ot1.quantity) >= 10
ORDER BY
    r1.region_name,
    s1.seller_name;



SELECT
    e1.employee_id,
    e1.first_name,
    e1.last_name
FROM employees e1
JOIN employees e2
    ON e1.manager_id = e2.employee_id
WHERE
    e1.hire_date < e2.hire_date
ORDER BY
    e1.employee_id