CREATE TABLE pay
(
    cardNr         NUMBER(6) PRIMARY KEY,
    salary         NUMBER(8, 2),
    commission_pct NUMBER(2, 2),
    employee_id    NUMBER(6) UNIQUE REFERENCES EMPLOYEES (employee_id)
);