-- Write an unnamed PL/SQL block to accept a roll number and book name from the user.
-- The program should calculate the number of days since the book was issued.
-- If the number of days is:
-- Between 15 and 30, fine = ₹5 per day
-- More than 30 days, fine = ₹50 per day
-- Otherwise, no fine

SET SERVEROUTPUT ON;

DECLARE
    v_rollno Borrower.rollin%TYPE := &rollno;       -- Input roll number
    v_book Borrower.nameofbook%TYPE := '&bookname'; -- Input book name
    v_dateofissue Borrower.dateofissue%TYPE;
    v_days NUMBER;
    v_fine NUMBER := 0;

BEGIN
    -- Step 1: Get the date of issue for the given student and book
    SELECT dateofissue INTO v_dateofissue
    FROM Borrower
    WHERE rollin = v_rollno AND nameofbook = v_book AND status = 'I';

    -- Step 2: Calculate number of days between issue date and today
    v_days := TRUNC(SYSDATE - v_dateofissue);

    DBMS_OUTPUT.PUT_LINE('Number of days: ' || v_days);

    -- Step 3: Check fine conditions using IF-ELSE control structure
    IF v_days BETWEEN 15 AND 30 THEN
        v_fine := v_days * 5;
    ELSIF v_days > 30 THEN
        v_fine := v_days * 50;
    ELSE
        v_fine := 0;
    END IF;

    -- Step 4: Update book status to 'R' after submission
    UPDATE Borrower
    SET status = 'R'
    WHERE rollin = v_rollno AND nameofbook = v_book;

    -- Step 5: If fine > 0, insert details into Fine table
    IF v_fine > 0 THEN
        INSERT INTO Fine (roll_no, date, amt)
        VALUES (v_rollno, SYSDATE, v_fine);
        DBMS_OUTPUT.PUT_LINE('Fine of Rs. ' || v_fine || ' has been recorded.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No fine to pay. Book returned successfully.');
    END IF;

    COMMIT;

-- Step 6: Exception Handling
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found for this roll number or book.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);

END;
/
