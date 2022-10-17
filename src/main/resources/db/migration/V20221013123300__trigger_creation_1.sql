DECLARE
    v_col_exists NUMBER := 0;
BEGIN
    SELECT count(*) INTO v_col_exists
    FROM user_tab_cols
    WHERE upper(column_name) = 'DEPARTMENT_AMOUNT'
      AND upper(table_name) = 'LOCATIONS';

    IF (v_col_exists = 0) THEN
        EXECUTE IMMEDIATE 'ALTER TABLE locations ADD department_amount NUMBER(6)';
    ELSE
        DBMS_OUTPUT.PUT_LINE('The column DEPARTMENT_AMOUNT already exists');
    END IF;
END;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location.';


CREATE OR REPLACE TRIGGER updateDepartmentAmount
    AFTER INSERT OR DELETE
    ON DEPARTMENTS
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE LOCATIONS
        SET DEPARTMENT_AMOUNT = DEPARTMENT_AMOUNT + 1
        WHERE LOCATION_ID = :NEW.LOCATION_ID;
    ELSIF DELETING THEN
        UPDATE LOCATIONS
        SET DEPARTMENT_AMOUNT = DEPARTMENT_AMOUNT - 1
        WHERE LOCATION_ID = :OLD.LOCATION_ID
          AND DEPARTMENT_AMOUNT >= 0;
    END IF;
END;