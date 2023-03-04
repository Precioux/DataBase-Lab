 Create Database dataBase2p
 
 Create Table Sailor(
 Sailor_name int  not null primary key,
 Sailor_rank int );

 Create Table Boat(
 Boat_name varchar(20)not null primary key,
 Boat_color varchar(30),
 Boat_rank int constraint rank_limit check(Boat_rank<= 150 AND Boat_rank>=70)
 );

 Create Table Reserve(
 Sailor_name int  not null,
 Boat_name varchar(20)not null,
 Weekday varchar(15),
 foreign key (Sailor_name) references Sailor(Sailor_name),
 foreign key (Boat_name) references Boat(Boat_name),
 primary key (Boat_name, Sailor_name)
 );

 insert into Sailor values (300,1);
 insert into Sailor values (301,2);
 insert into Sailor values (302,3);
 insert into Sailor values (303,4);

 insert into Boat values ('A', 'Blue', 70);
 insert into Boat values ('B', 'Red', 80);
 insert into Boat values ('C', 'Orange', 90);
 insert into Boat values ('D', 'Yellow', 100);

 insert into Reserve values (300, 'A', 'Sat');
 insert into Reserve values (301, 'B', 'Sun');
 insert into Reserve values (302, 'C', 'Mon');
 insert into Reserve values (303, 'D', 'Tue');

SELECT Boat_name
FROM Reserve
WHERE Weekday = 'Sat';

Go 

CREATE VIEW [Boat_Sailor_Color] AS
SELECT Boat.Boat_name, Reserve.Sailor_name, Boat.Boat_color
FROM Boat INNER JOIN Reserve ON Boat.Boat_name = Reserve.Boat_name;

Go 

SELECT Boat_rank
FROM Boat

 
SELECT Boat.Boat_name
FROM Boat INNER JOIN Reserve ON Boat.Boat_name = Reserve.Boat_name
WHERE Reserve.Weekday='Sun' OR Reserve.Weekday='Mon';

SELECT DISTINCT Boat.Boat_color
FROM Boat INNER JOIN Reserve ON Boat.Boat_name = Reserve.Boat_name
WHERE Reserve.Weekday LIKE 'S%';

Create Table Emp(
Emp_id int not null identity primary key,
Name varchar(50),
Salary int,
);

Create Table Project(
id int not null identity primary key,
name varchar(15),
);

Create Table employee_project(
prj_id int not null ,
emp_id int not null ,
foreign key (prj_id) references Project(id),
foreign key (emp_id) references Emp(Emp_id),
primary key (prj_id, emp_id)
);

-- Insert data into the Emp table
INSERT INTO Emp (Name, Salary)
VALUES ('Manager', 100000),
       ('EmpB1', 50000),
       ('EmpB2', 50000),
       ('EmpO1', 45000),
       ('EmpO2', 45000);

-- Insert data into the Project table
INSERT INTO Project (name)
VALUES ('A');

-- Insert data into the employee_project table
INSERT INTO employee_project (prj_id, emp_id)
VALUES (1, 1), -- Manager assigned to project A
       (1, 2), -- EmpB1 assigned to project A
       (1, 3), -- EmpB1 assigned to project A
       (1, 4), -- EmpO1 assigned to project A
       (1, 5); -- EmpO2 assigned to project A


-- Insert data into the Emp table
INSERT INTO Emp (Name, Salary)
VALUES ('EmpC1', 30000),
       ('EmpC2', 30000),
       ('EmpC3', 30000),
	   ('EmpD1', 20000),
       ('EmpD2', 20000),
       ('EmpD3', 20000),
       ('EmpA1', 60000),
       ('EmpA2', 60000),
       ('EmpE1', 80000),
       ('EmpE2', 80000),
       ('EmpB3', 50000);

-- Insert data into the Project table
INSERT INTO Project (name)
VALUES ('B');

-- Insert data into the employee_project table
INSERT INTO employee_project (prj_id, emp_id)
VALUES (2, 6), -- EmpC1 assigned to project B
       (2, 7), -- EmpC2 assigned to project B
       (2, 8), -- EmpC3 assigned to project B
       (2, 9), -- EmpD1 assigned to project B
       (2, 10), -- EmpD2 assigned to project B
       (2, 11), -- EmpD3 assigned to project B
       (2, 12), -- EmpA1 assigned to project B
       (2, 13), -- EmpA2 assigned to project B
       (2, 14), -- EmpE1 assigned to project B
       (2, 15), -- EmpE2 assigned to project B
       (2, 16); -- EmpB3 assigned to project B


-- Insert data into the Emp table
INSERT INTO Emp (Name, Salary)
VALUES ('EmpA3', 60000),
       ('EmpF1', 30000),
       ('EmpF2', 30000);

-- Insert data into the Project table
INSERT INTO Project (name)
VALUES ('C');

-- Insert data into the employee_project table
INSERT INTO employee_project (prj_id, emp_id)
VALUES (3, 17), -- EmpA3 assigned to project C
       (3, 18), -- EmpF1 assigned to project C
       (3, 19); -- EmpF2 assigned to project C
	   

-- Insert data into the Emp table
INSERT INTO Emp (Name, Salary)
VALUES ('EmpF3', 50000),
       ('EmpF4', 50000),
       ('EmpH1', 45000),
       ('EmpH2', 45000),
       ('EmpH3', 45000),
	   ('EmpI1', 65000),
       ('EmpI2', 65000),
       ('EmpI3', 65000),
       ('EmpI4', 65000),
       ('EmpG1', 55000),
       ('EmpG2', 55000),
       ('EmpK1', 40000),
       ('EmpK2', 40000),
       ('EmpK3', 40000);

-- Insert data into the Project table
INSERT INTO Project (name)
VALUES ('D');

-- Insert data into the employee_project table
INSERT INTO employee_project (prj_id, emp_id)
VALUES (4, 1),  -- Manager assigned to project D
       (4, 20), -- EmpF3 assigned to project D
       (4, 21), -- EmpF4 assigned to project D
       (4, 22), -- EmpH1 assigned to project D
       (4, 23), -- EmpH2 assigned to project D
	   (4, 24), -- EmpH3 assigned to project D
       (4, 25), -- EmpI1 assigned to project D
       (4, 26), -- EmpI2 assigned to project D
       (4, 27), -- EmpI3 assigned to project D
       (4, 28), -- EmpI4 assigned to project D
       (4, 29), -- EmpG1 assigned to project D
       (4, 30), -- EmpG2 assigned to project D
       (4, 31), -- EmpK1 assigned to project D
       (4, 32), -- EmpK2 assigned to project D
       (4, 33); -- EmpK3 assigned to project D

SELECT Project.name
FROM Project INNER JOIN employee_project ON Project.id = employee_project.prj_id
GROUP BY Project.name
HAVING COUNT(employee_project.emp_id) < 4;

SELECT Emp.Name, Project.name AS ProjectName
FROM Emp
JOIN employee_project ON Emp.Emp_id = employee_project.emp_id
JOIN Project ON employee_project.prj_id = Project.id;

SELECT SUM(Salary)
FROM Emp
WHERE Emp_id IN (
  SELECT emp_id
  FROM employee_project
  WHERE prj_id = (
    SELECT id
    FROM Project
    WHERE name = 'B'
  )
);


SELECT p.name AS project_name, AVG(e.salary) AS avg_salary
FROM Project p
INNER JOIN employee_project ep ON p.id = ep.prj_id
INNER JOIN Emp e ON ep.emp_id = e.Emp_id
GROUP BY p.name


SELECT Project.name
FROM Project
INNER JOIN employee_project ON Project.id = employee_project.prj_id
INNER JOIN Emp ON employee_project.emp_id = Emp.Emp_id
WHERE Emp.Name = 'Manager';
