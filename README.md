# Database_Design

As a Data Analyst, I was approached by Paper Emporium, a fictitious company that sells stationery items, to design a database schema for them. 

Company Data Requirements
1.	The company is organized into branches. Each branch has a unique number, a name, and a particular employee who manages it.
2.	The company makes its money by selling to clients. Each client has a name and a unique number to identify it.
3.	The foundation of the company is its employees. Each employee has a name, birthday, gender, salary and a unique number.
4.	An employee can work for one branch at a time, and each branch will be managed by one of the employees that work there. We’ll also want to keep track of when the current manager started as manager.
5.	An employee can act as a supervisor for other employees at the branch, an employee may also act as a supervisor for employees at other branches. An employee can have at most one supervisor.
6.	A branch may handle a number of clients, with each client having a name and a unique number to identify it. A single client may only be handled by one branch at a time.
7.	Employees can work with clients controlled by their branch to sell them stuff. If necessary, multiple employees can work with the same client. We’ll want to keep track of how many dollars’ worth of stuff each employee sells to each client they work with.
8.	Many branches will need to work with suppliers to but inventory. For each supplier we’ll keep track of their name and the type of product they’re selling the branch. A single supplier may supply products to multiple branches.

With the above information, I designed an ER Diagram as follows:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/c86028d3-6df8-404f-ac77-21e615b8e52b)

The following steps were taken to convert the above ER Diagram into a database schema:

Step 1: Mapping of Regular Entity Types – For each regular entity type create a relation (table) that includes all the simple attributes of that entity. [Employee table, Branch Table & Client table with their associated attributes]
Step 2: Mapping of weak Entity Types – For each weak entity type, create a relation (table) that includes all simple attributes of the weak entity. The primary key of the new relation should be the partial key of the weak entity plus the primary key of its owner. [Branch Supplier table with composite primary key of branch_id and supplier_name. Supplier_type is the attribute].
Step 3: Mapping of Binary 1:1 Relationship Types (a binary relationship is a relationship that has two entities participating in it) – Include one side of the relationship as a foreign key in the other and we favor total participation. If both of them are partial participation or both are total participation, we use discretion. [In Branch table, we add mngr_id as foreign key.]
Step 4: Mapping of binary 1: N Relationship Types – Include the 1 side’s primary key as a foreign key on the N side relation (table) [In client table, branch_id is a foreign key. In Employee table, branch_id is a foreign key. In Employee table, super_id is a foreign key]
Step 5: Mapping of Binary M:N Relationship Types – Create a new relation (table) whose primary key is a combination of both entities’ primary keys. Also include any relationship attributes. [Create Works_With table with composite key as Client_id and Emp_id and has Sales as an attribute. Second relation is Supplies/ Branch_supplier table with composite key as branch_id and supplier_name. Attribute is supply_type]


Creating the Tables:
1.	The Employee Table below shows a record of all the employee demographics of Paper Emporium employees. In the first column we have a unique employeeID (Emp_id), second column we have the employee’s first name, last name, their birth_date, gender, salary, supervisorID (super_id), and the branch in which each employee works (Branch_id). Highlighted in blue is the PRIMARY KEY of the table and highlighted in green is the FOREIGN KEY of the table, meaning it points us to the PRIMARY KEY of another table.  
N.B: An employee in the company has a supervisor, who is also another employee of Paper Emporium. For example, Josh Porter, employee 106, has a supervisor with emp_id 100, who is David Wallace.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/f6513480-39c6-4519-8726-cfb6f3d29114)


We created the employee table above using SQL as shown below:
Note: we can’t define branch_id as FOREIGN KEY yet because technically, the branch table does not exist yet.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/95e2ce94-885a-4937-8175-45df3dd9ed7b)

2.	The branch table contains information about all the branches of Paper Emporium, that is, a unique branch_id, branch name, the manager of that particular branch (identified by their employee ID in the employee table), and finally the date the branch manager held that position.


![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/14f10dd3-9141-4a1d-afcf-c24ed052a132)


The branch table above was created using SQL as shown below, and manager_id has been defined as a foreign key:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/c991aa79-0270-4d34-b677-d96123c58ac3)

Now, we go back to the employee table to alter the branch_id column as a foreign key as shown below:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/449cfbd0-6dc8-4208-983d-4f97f6a50e8d)


3.	Next, we create a Client table which contains the information about all clients that belong to Paper Emporium. In it we have a UNIQUE client_id as the PRIMARY KEY, the Client name and the branch_id which is the Paper Emporium branch that supplies the said client. It is worth noting that branch_id is a foreign key that points to the PRIMARY KEY of branch table.


![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/e00190ee-0b94-4e30-9837-0c7a74d4cda5)

The script to create the client table is shown below:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/80da63b1-d787-4a41-b231-d687c468d86f)



4.	Works_With table gives us the information about the sales details inside the company. It shows that, for example, an employee with emp_id 105 has sold supplies to client_id 400 and those supplies are worth 55,000. Alternatively, emp_id 108 has a record of 22,500 worth of sales through client_id 402. Emp_id and Client_id make up a composite key, which is a key made up of multiple columns. Both components of the composite key are foreign keys. We need both keys to identify an attribute of Total_sales, as none of them can single-handedly and uniquely identify that attribute.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/33af0b41-5f72-4b94-8ae2-6a63cf543dc9)

The SQL script used is as follows:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/30a11e75-82fc-42cb-9c34-3ad8881e7854)


5.	Branch_supplier table shows a relationship between Paper Emporium and its suppliers. For example, a supplier named Patriot Paper supllies our company, Paper Emporium with Paper and it supplies branch_id 3 only. Our company’s branch_id 3 gets its Writing Utensils supplied by Uni-ball. Branch_Supplier table has a composite key made up of branch_id and supplier_name. Branch_id is also a foreign key in this case but supplier_name is not.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/0b355b6e-d797-464e-89f3-e5dbd025e6a2)

Script is shown below:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/daa4f652-e1ab-4e9a-b6d7-d8c3216f9d6e)

INSERTING VALUES INTO TABLES
Starting with employee table, we inserted the first row strategically as shown below:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/b61ac78e-0281-4956-812f-c9f401bf4d81)

The branch_id of emp_id 100 is initially set to NULL because the branch table it refers to is not yet populated. Setting it to '1' gives an error until the branch table has been populated with the relevant values. 
The next step is to populate the branch table with the first values as shown:

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/08ba2d27-70c3-48be-9b94-8989eeb3f4ef)

After populating the branch table, we now have a value suitable for branch_id in the previous entry of employee table. It is at this stage where we now update the value.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/06cd3a65-40bf-4888-8e9c-06b04e1e2224)

We continue to insert all the other values normally into the employee table until we get to the entries that would require branch_id 2 in them. In this case we start as previously by inserting the value for branch_id as NULL.

![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/bd632778-7910-46b1-b7a6-201ae30b345c)

The process to populate every other value correctly is as previously demonstrated for the rest of the entries.

These are the resulting tables in the database
![image](https://github.com/rmakhoebe/Database_Design/assets/97227644/941e27af-6010-458a-abcf-c5fa7627e3e3)












