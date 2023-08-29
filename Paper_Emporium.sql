
CREATE DATABASE Paper_Emporium;
USE Paper_Emporium

--First create the employee table, with employee_id (emp_id) as the primary key and super_id as the foreign key.
--We can't add branch_id as foreign key yet because the branch table doesn't exist yet.
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  gender VARCHAR(40),
  salary INT,
  super_id INT FOREIGN KEY REFERENCES employee(emp_id),
  branch_id INT
);
SELECT* from employee

--Create the branch table with branch_id as the PRIMARY KEY. The manager_id column is a foreign key in the branch table
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  manager_id INT,
  manager_start_date DATE,
  FOREIGN KEY(manager_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

SELECT* FROM branch

--Now that the branch table exists, we go back to set branch_id as foreign key in employee table
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;


--Create Client table which contains the information about all clients that belong to Paper Emporium.
--client_id is the PRIMARY KEY, and branch_id is a foreign key that points to the PRIMARY KEY of branch table.

CREATE TABLE client (
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL --"ON DELETE SET NULL" means that if the corresponding rows in the
--parent table were to be deleted, set these rows to NULL
);

SELECT* from client


--Create the Works_With table which has a composite primary key, which means it is made up of multiple columns (client_id and emp_id).
--And each component of the primary composite key is a foreign key.
CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE --"ON DELETE CASCADE" means when rows in the primary/parent table are deleted,
  --SQL server also deletes rows in the child table
);
select* from works_with



--5.	Branch_supplier table shows Paper Emporium branches and their products suppliers.
--Branch_Supplier table has a composite key made up of branch_id and supplier_name.
--Branch_id is also a foreign key in this case but supplier_name is not.

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);
 select * from branch_supplier


 -- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); --branch_id is initially set at NULL because the branch table
																							--is not yet populated. Setting it to '1' gives an error until
																							--the branch table has been populated with the relevant values.

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100; --Now that the branch table has the relevant values we need for emp_id 100, we go back to update the branch_id in employee table
					--for emp_id = 100 entry.

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'William', 'Scott', '1964-03-15', 'M', 75000, 100, NULL); --branch_id is set to NULL initially, untile the relevant values
																							--have been populated into the branch table.

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102; --Now that the branch table has the relevant values we need for emp_id 102, we go back to update the branch_id in employee table
					--for emp_id = 102 entry

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);


-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL); --branch_id is set to NULL initially, untile the relevant values
																							--have been populated into the branch table.

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);



--populate BRANCH SUPPLIER table
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

--populate CLIENT table
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Populate WORKS_WITH table
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

select* from employee
select* from branch
select* from branch_supplier
select* from client
select* from works_with



