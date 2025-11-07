-- Write a stored procedure named proc_Grade that categorizes students based on the marks they scored in an examination.
-- If marks are ≤ 1500 and ≥ 990, the student is placed in Distinction category.
-- If marks are between 989 and 900, the category is First Class.
-- If marks are between 899 and 825, the category is Higher Second Class.
-- The procedure should take the student’s name and total marks from the table Stud_Marks, and insert their name, roll number, and class category into the Result table.
-- A PL/SQL block should be written to call this stored procedure for execution.

CREATE TABLE Stud_Marks (
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    total_marks NUMBER
);

CREATE TABLE Result (
    roll_no NUMBER,
    name VARCHAR2(50),
    class VARCHAR2(30)
);

INSERT INTO Stud_Marks VALUES (1, 'Yash', 1200);
INSERT INTO Stud_Marks VALUES (2, 'Aarav', 950);
INSERT INTO Stud_Marks VALUES (3, 'Neha', 870);
INSERT INTO Stud_Marks VALUES (4, 'Riya', 800);

CREATE OR REPLACE PROCEDURE proc_Grade (
    p_roll Stud_Marks.roll_no%TYPE,
    p_name Stud_Marks.name%TYPE,
    p_marks Stud_Marks.total_marks%TYPE
) IS
    v_class VARCHAR2(30);
BEGIN
    -- Determine category based on marks
    IF p_marks BETWEEN 990 AND 1500 THEN
        v_class := 'Distinction';
    ELSIF p_marks BETWEEN 900 AND 989 THEN
        v_class := 'First Class';
    ELSIF p_marks BETWEEN 825 AND 899 THEN
        v_class := 'Higher Second Class';
    ELSE
        v_class := 'Fail';
    END IF;

    -- Insert result into Result table
    INSERT INTO Result (roll_no, name, class)
    VALUES (p_roll, p_name, v_class);

    DBMS_OUTPUT.PUT_LINE('Student: ' || p_name || ' | Category: ' || v_class);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    -- Loop through all students and call procedure for each
    FOR rec IN (SELECT * FROM Stud_Marks) LOOP
        proc_Grade(rec.roll_no, rec.name, rec.total_marks);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- All Student Grades Processed ---');
END;
/
