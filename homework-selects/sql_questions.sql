-- Write a query to display:

-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, CITY, STATE_PROVINCE
FROM EMPLOYEES
         LEFT JOIN DEPARTMENTS USING (DEPARTMENT_ID)
         LEFT JOIN LOCATIONS USING (LOCATION_ID);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID IN (40, 80);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, CITY, STATE_PROVINCE
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
         INNER JOIN LOCATIONS USING (LOCATION_ID)
WHERE FIRST_NAME LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT e.FIRST_NAME, m.FIRST_NAME
from EMPLOYEES e
         LEFT JOIN EMPLOYEES m on m.EMPLOYEE_ID = e.MANAGER_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.FIRST_NAME, m.FIRST_NAME
from EMPLOYEES e
         LEFT JOIN EMPLOYEES m on m.EMPLOYEE_ID = e.MANAGER_ID;

-- 8. the details of employees who manage a department.
SELECT e.*
from EMPLOYEES e
         INNER JOIN DEPARTMENTS D on D.MANAGER_ID = e.EMPLOYEE_ID;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Taylor');

--10. the department name and number of employees in each of the department.
SELECT DEPARTMENT_NAME, COUNT(EMPLOYEE_ID)
FROM DEPARTMENTS
         LEFT JOIN EMPLOYEES USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT DEPARTMENT_NAME, AVG(SALARY), COUNT(EMPLOYEE_ID)
FROM DEPARTMENTS
         INNER JOIN EMPLOYEES USING (DEPARTMENT_ID)
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_NAME;

--12. job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY)
FROM EMPLOYEES
         INNER JOIN JOBS USING (JOB_ID)
GROUP BY JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT COUNTRY_NAME, CITY, DEPARTMENT_ID
FROM LOCATIONS
         INNER JOIN DEPARTMENTS d USING (LOCATION_ID)
         INNER JOIN COUNTRIES USING (COUNTRY_ID)
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                                 INNER JOIN EMPLOYEES USING (DEPARTMENT_ID)
                        GROUP BY DEPARTMENT_ID
                        HAVING (COUNT(EMPLOYEE_ID) >= 2));

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT e.EMPLOYEE_ID, j.JOB_TITLE, h.END_DATE - h.START_DATE
FROM JOBS j
         INNER JOIN JOB_HISTORY h USING (JOB_ID)
         INNER JOIN EMPLOYEES e on h.EMPLOYEE_ID = e.EMPLOYEE_ID
WHERE e.DEPARTMENT_ID = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT FIRST_NAME || LAST_NAME as NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);


--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT FIRST_NAME || LAST_NAME as NAME, EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT DEPARTMENT_ID, FIRST_NAME || LAST_NAME as NAME, JOB_TITLE, DEPARTMENT_NAME
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
         INNER JOIN JOBS USING (JOB_ID)
WHERE DEPARTMENT_NAME = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN (SELECT MIN(SALARY) FROM EMPLOYEES) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                                     INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
                            WHERE EMPLOYEE_ID BETWEEN 100 AND 200);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT max(SALARY) FROM EMPLOYEES WHERE SALARY < (SELECT max(SALARY) FROM EMPLOYEES));

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT FIRST_NAME || LAST_NAME as NAME, HIRE_DATE
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Clara')
  and FIRST_NAME <> 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME LIKE '%T%' OR LAST_NAME LIKE '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT FIRST_NAME || LAST_NAME as NAME, JOB_TITLE, START_DATE, END_DATE, COMMISSION_PCT
FROM EMPLOYEES
         INNER JOIN JOB_HISTORY USING (EMPLOYEE_ID)
         INNER JOIN JOBS J on J.JOB_ID = JOB_HISTORY.JOB_ID
WHERE COMMISSION_PCT IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME, SALARY
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME LIKE '%J%' OR LAST_NAME LIKE '%J%')
  AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME, JOB_TITLE
FROM EMPLOYEES
         LEFT JOIN JOBS USING (JOB_ID)
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID LIKE '%MK_MAN%');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME, JOB_TITLE
FROM EMPLOYEES
         LEFT JOIN JOBS USING (JOB_ID)
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID LIKE '%MK_MAN%')
  AND JOB_ID <> '%MK_MAN%';

--29. all the information of those employees who did not have any job in the past.
SELECT e.*
FROM EMPLOYEES e
         LEFT JOIN JOB_HISTORY h on e.EMPLOYEE_ID = h.EMPLOYEE_ID
WHERE END_DATE IS NULL;

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT e.EMPLOYEE_ID, FIRST_NAME || LAST_NAME as NAME, JOB_TITLE
FROM EMPLOYEES e
         INNER JOIN JOBS j on e.JOB_ID = j.JOB_ID
WHERE SALARY > ANY (SELECT AVG(SALARY)
                    FROM EMPLOYEES
                             INNER JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
                    group by DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME as NAME,
       CASE JOB_ID
           WHEN 'ST_MAN' THEN 'SALESMAN'
           WHEN 'IT_PROG' THEN 'DEVELOPER'
           ELSE JOB_ID END     AS JOB_ID
FROM EMPLOYEES;

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME as NAME,
       SALARY,
       CASE
           WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN 'HIGH'
           ELSE 'LOW'
           END                 AS SalaryStatus
FROM EMPLOYEES;

--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME                      as NAME,
       SALARY                                       as SalaryDrawn,
       SALARY - (select avg(SALARY) from EMPLOYEES) as AvgCompare,
       CASE
           WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN 'HIGH'
           ELSE 'LOW'
           END                                      AS SalaryStatus
FROM EMPLOYEES;

--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT e.*
from EMPLOYEES e
         INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE DEPARTMENT_NAME LIKE '%IT%'
  AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--35. who earns more than Mr. Ozer.
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Ozer');

--36. which employees have a manager who works for a department based in the US.
SELECT *
from EMPLOYEES
WHERE MANAGER_ID IN (SELECT e.EMPLOYEE_ID
                       FROM EMPLOYEES e
                                INNER JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
                                INNER JOIN LOCATIONS L ON d.LOCATION_ID = L.LOCATION_ID
                       WHERE COUNTRY_ID = 'US');

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES e
WHERE SALARY > (SELECT SUM(SALARY) * 0.5 FROM EMPLOYEES e1 WHERE e.DEPARTMENT_ID = e1.DEPARTMENT_ID);

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME, CITY
FROM EMPLOYEES e
         INNER JOIN DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
         INNER JOIN LOCATIONS L on d.LOCATION_ID = l.LOCATION_ID
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '01-jan-2002' AND '31-dec-2003');

--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 40);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM DEPARTMENTS
WHERE LOCATION_ID = (SELECT LOCATION_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = 30);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 201);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 40);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 40);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT MIN(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 70);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES)
  AND DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Laura');

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID = ANY (SELECT MANAGER_ID FROM EMPLOYEES GROUP BY MANAGER_ID HAVING COUNT(*) >= 4);

--48. the details of the current job for those employees who worked as a Sales Representative in the past.
SELECT j.*
FROM JOBS j
         INNER JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
         INNER JOIN JOB_HISTORY h on e.EMPLOYEE_ID = h.EMPLOYEE_ID
WHERE h.JOB_ID = 'SA_REP'
  AND h.END_DATE IS NOT NULL;

--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT min(SALARY) FROM EMPLOYEES WHERE SALARY > (SELECT min(SALARY) FROM EMPLOYEES));

--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
SELECT DEPARTMENT_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES e
WHERE SALARY = (SELECT max(SALARY) FROM EMPLOYEES WHERE e.DEPARTMENT_ID = DEPARTMENT_ID);