-- Cursors: (All types: Implicit, Explicit, Cursor FOR Loop, Parameterized Cursor) Write a PL/SQL block of code 
-- using parameterized Cursor, that will merge the data available in the newly created table N_RollCall with the data available 
-- in the table O_RollCall. If the data in the first table already exist in the second table, then that data should be skipped. 
-- Frame the separate problem statement for writing PL/SQL block to implement all types of Cursors inline with above 
-- statement.

CREATE TABLE O_RollCall (
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    attendance VARCHAR2(10)
);

CREATE TABLE N_RollCall (
    roll_no NUMBER,
    name VARCHAR2(50),
    attendance VARCHAR2(10)
);

INSERT INTO O_RollCall VALUES (1, 'Yash', 'Present');
INSERT INTO O_RollCall VALUES (2, 'Aarav', 'Absent');

INSERT INTO N_RollCall VALUES (2, 'Aarav', 'Present');
INSERT INTO N_RollCall VALUES (3, 'Neha', 'Present');
INSERT INTO N_RollCall VALUES (4, 'Riya', 'Absent');

SET SERVEROUTPUT ON;

DECLARE
    -- Step 1: Define parameterized cursor
    CURSOR cur_new(p_roll N_RollCall.roll_no%TYPE) IS
        SELECT roll_no, name, attendance
        FROM N_RollCall
        WHERE roll_no = p_roll;

    v_roll N_RollCall.roll_no%TYPE;
    v_name N_RollCall.name%TYPE;
    v_attendance N_RollCall.attendance%TYPE;
    v_count NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Merging Data from N_RollCall to O_RollCall ---');

    -- Step 2: Loop through each record in N_RollCall
    FOR rec IN (SELECT roll_no FROM N_RollCall) LOOP

        -- Step 3: Open cursor with parameter (roll_no)
        OPEN cur_new(rec.roll_no);
        FETCH cur_new INTO v_roll, v_name, v_attendance;
        CLOSE cur_new;

        -- Step 4: Check if record already exists in old table
        SELECT COUNT(*) INTO v_count
        FROM O_RollCall
        WHERE roll_no = v_roll;

        -- Step 5: Insert if not found
        IF v_count = 0 THEN
            INSERT INTO O_RollCall VALUES (v_roll, v_name, v_attendance);
            DBMS_OUTPUT.PUT_LINE('Inserted Roll No: ' || v_roll);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Skipped Roll No: ' || v_roll || ' (Already exists)');
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Merge Completed ---');
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);

END;
/
