CREATE TABLE projects
(
    project_id          NUMBER(6) PRIMARY KEY,
    project_description VARCHAR2(255) CHECK (LENGTH(project_description) > 0),
    project_investments NUMBER(10, -3) CHECK (project_investments > 0),
    project_revenue     NUMBER(10)
);

CREATE TABLE project_employee
(
    project_id   NUMBER(6) REFERENCES projects (project_id),
    employee_id  NUMBER(6) REFERENCES EMPLOYEES (employee_id),
    hours_worked NUMBER(6)
);