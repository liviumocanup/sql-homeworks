--setup for satisfying the constraints
INSERT INTO JOBS
VALUES (50, 'Java Developer', 700, 7500);

INSERT INTO REGIONS
VALUES (1, 'Crescendo Roundabout');

INSERT INTO COUNTRIES
VALUES ('GL', 'Greenland', 1);

INSERT INTO LOCATIONS
VALUES (5, 'Georg Bvd.', 'GB-2020', 'Valenheim', 'Titto', 'GL');

INSERT INTO DEPARTMENTS
VALUES (10, 'IT_DEPARTMENT', NULL, 5);

INSERT INTO EMPLOYEES
VALUES (400, 'Valeriu', 'Butnaru', 'vbut@gmail.com', '069696969',
        TO_DATE('2001-01-13', 'YYYY-MM-DD'),
        50, 1250, null, null, 10);

--insert one row into job_history table.
INSERT INTO JOB_HISTORY
VALUES (400,
        TO_DATE('2001-01-13', 'YYYY-MM-DD'),
        TO_DATE('2003-01-01', 'YYYY-MM-DD'),
        50, 10);