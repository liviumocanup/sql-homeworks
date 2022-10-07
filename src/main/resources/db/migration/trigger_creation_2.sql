CREATE TABLE employment_logs
(
    employment_log_id              NUMBER(6) PRIMARY KEY,
    first_name                     VARCHAR2(20),
    last_name                      VARCHAR2(25),
    employment_action              CHAR(5) CHECK (employment_action IN ('HIRED', 'FIRED') ),
    employment_status_updtd_tmstmp TIMESTAMP
);


CREATE OR REPLACE PROCEDURE new_log(first_name VARCHAR2, last_name VARCHAR2, employment_action CHAR)
AS
BEGIN
    INSERT INTO employment_logs (first_name, last_name, employment_action, employment_status_updtd_tmstmp)
    VALUES (first_name, last_name, employment_action, SYSTIMESTAMP);
END;


CREATE OR REPLACE TRIGGER updateEmployeeLogs
    AFTER INSERT OR DELETE
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        new_log(:new.first_name, :new.last_name, 'HIRED');
    ELSIF DELETING THEN
        new_log(:old.first_name, :old.last_name, 'FIRED');
    END IF;
END;