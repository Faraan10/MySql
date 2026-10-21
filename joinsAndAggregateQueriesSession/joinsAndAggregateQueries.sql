-- Q3. Joined first

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


-- Q4. Students in Departments

SELECT 
    d1.dept_name,
    COUNT(s1.student_id) AS 'student_number'
FROM
    student s1
RIGHT JOIN 
    department d1
    ON s1.dept_id = d1.dept_id
GROUP BY
    d1.dept_name
ORDER BY
    COUNT(s1.student_id) DESC,
    d1.dept_name;



-- Q5. Students and examinations

SELECT 
    s1.student_id,
    s1.student_name,
    sb1.subject_name,
    COUNT(e1.subject_name) AS 'attended_exams'
FROM 
    students s1
CROSS JOIN 
    subjects sb1
LEFT JOIN 
    examinations e1 
    ON s1.student_id = e1.student_id
    AND sb1.subject_name = e1.subject_name
GROUP BY 
    s1.student_name, 
    sb1.subject_name
ORDER BY
    s1.student_id,
    sb1.subject_name



-- Q6. Active Sellers and Delivered Items by Region (2024)

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



-- Q8. Project Workload Analysis by Country
SELECT 
    p1.project_name,
    e1.country,
    COUNT(DISTINCT e1.emp_id) AS 'employee_count'
FROM 
    project p1
INNER JOIN 
    assignment a1 
    ON p1.project_id = a1.project_id
INNER JOIN 
    employee e1 
    ON a1.emp_id = e1.emp_id
WHERE 
    p1.project_status = 'Active'
GROUP BY
    p1.project_name,
    e1.country
ORDER BY
    p1.project_name,
    e1.country;



-- Q10. Overloaded Employees with Skill and Assignment Details

SELECT
    e1.emp_name,
    d1.dept_name,
    e1.country,
    SUM(a1.allocation_pct) AS 'total_allocation'
FROM 
    employee e1
INNER JOIN
    assignment a1 
    ON e1.emp_id = a1.emp_id
INNER JOIN 
    department d1
    ON e1.department_id = d1.department_id
INNER JOIN 
    project p1
    ON a1.project_id = p1.project_id
WHERE
    p1.project_status = 'Active'
GROUP BY
    e1.emp_id,
    e1.emp_name,
    d1.dept_name,
    e1.country
HAVING 
    SUM(a1.allocation_pct) > 100
ORDER BY
    SUM(a1.allocation_pct) DESC;