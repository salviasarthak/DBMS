DROP TABLE IF EXISTS Salary_Hike;

CREATE TABLE Salary_Hike (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) NOT NULL
);

INSERT INTO Salary_Hike (emp_id, emp_name, salary) VALUES
(101, 'Amit Sharma', 85000.00),
(102, 'Priya Patel', 95000.00),
(103, 'Rahul Verma', 60000.00),
(104, 'Ananya Iyer', 110000.00),
(105, 'Vikram Singh', 55000.00);


CREATE OR REPLACE FUNCTION check_salary_hike()
RETURNS TRIGGER
AS $$
BEGIN

    IF NEW.salary > OLD.salary * 1.15 THEN
        RAISE EXCEPTION
            'Salary increase cannot exceed 15%% of the old salary.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_salary_hike
BEFORE UPDATE OF salary ON Salary_Hike
FOR EACH ROW
EXECUTE FUNCTION check_salary_hike();


SELECT * FROM Salary_Hike;
