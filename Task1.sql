-- TASK 1

CREATE DATABASE SISDB
USE SISDB
CREATE TABLE STUDENTS(
student_id int identity(1,1) NOT NULL primary key,
first_name varchar(20),
last_name varchar(20),
date_of_birth date,
email varchar(50),
phone_number int)

CREATE TABLE COURSES(
course_id int identity(1,1) NOT NULL primary key,
course_name varchar(50),
credits int)

CREATE TABLE ENROLLMENTS(
enrollment_id int identity(1,1) NOT NULL primary key,
student_id int,
FOREIGN KEY (student_id) references STUDENTS(student_id),
course_id int,
FOREIGN KEY (course_id) references COURSES(course_id),
enrollment_date date)

CREATE TABLE TEACHER(
teacher_id int identity(1,1) NOT NULL primary key,
first_name varchar(20),
last_name varchar(20),
email varchar(50))

CREATE TABLE PAYMENTS(
payment_id int identity(1,1) NOT NULL primary key,
student_id int,
FOREIGN KEY (student_id) references STUDENTS(student_id),
amount int,
payment_date date)

ALTER TABLE COURSES ADD teacher_id int Foreign key (teacher_id) references TEACHER(teacher_id)
ALTER TABLE STUDENTS ALTER COLUMN phone_number varchar(10)

INSERT INTO STUDENTS (first_name,last_name,date_of_birth,email,phone_number) VALUES 
('Ann','Paul','05-12-2002','ann@gmail.com','8056349088'),
('Ashlin','Sam','2002/02/16','ashlin@gmail.com','8575669687'),
('Emily','John','2002-01-06','emily@gmail.com','9674395955'),
('Alex','M','2003-03-25','alex@gmail.com','9837457544'),
('Sophia','Martin','2001-07-21','soph@gmail.com','7456956844'),
('Olivia','Smith','2003-05-18','oli@gmail.com','7857675689'),
('Ava','Brown','2002-01-31','ava@gmail.com','9684768468'),
('James','Smith','2001-06-14','james@gmail.com','8976756457'),
('Noah','Mathew','2001-04-28','noah@gmail.com','7986647678'),
('Rebecca','Jones','2002-08-15','rebecca@gmail.com','8576859454')

INSERT INTO TEACHER (first_name,last_name,email) VALUES
('Rose','Thomas','rose@gmail.com'),
('Samuel','Lee','sam@gmail.com'),
('Rachel','Murphy','rachel@gmail.com'),
('Lauren','Thompson','laurel@gmail.com'),
('Damon','Wilson','damon@gmail.com')

INSERT INTO COURSES (course_name,credits,teacher_id) VALUES
('Java',10,1),
('C#',8,2),
('Python',8,3),
('C++',5,4),
('SQL',10,5)

INSERT INTO ENROLLMENTS (student_id,course_id,enrollment_date) VALUES
(19,2,'2024-02-16'),
(20,1,'2023-12-05'),
(21,2,'2023-11-19'),
(22,3,'2024-01-28'),
(23,4,'2024-02-16'),
(24,4,'2023-12-01'),
(25,5,'2024-01-22'),
(26,1,'2023-12-05'),
(27,1,'2024-02-27'),
(28,2,'2023-11-10')

INSERT INTO PAYMENTS (student_id,amount,payment_date) VALUES
(19,1000,'2024-02-16'),
(20,1500,'2023-12-05'),
(21,1000,'2023-11-19'),
(22,800,'2024-01-28'),
(23,1200,'2024-02-16'),
(24,1200,'2023-12-01'),
(25,1000,'2024-01-22'),
(26,1500,'2023-12-05'),
(27,1500,'2024-02-27'),
(28,1000,'2023-11-10')

-- TASK 2

/* 1 Write an SQL query to insert a new student into the "Students" table with the following details:
a. First Name: John
b. Last Name: Doe
c. Date of Birth: 1995-08-15
d. Email: john.doe@example.com
e. Phone Number: 1234567890 */

INSERT INTO STUDENTS (first_name,last_name,date_of_birth,email,phone_number) VALUES
('John','Doe','1995-08-15','john.doe@example.com','1234567890')

--2 Write an SQL query to enroll a student in a course. 
--Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.

INSERT INTO ENROLLMENTS (student_id,course_id,enrollment_date) VALUES
(19,3,'2024-02-16')

--3 Update the email address of a specific teacher in the "Teacher" table. 
--Choose any teacher and modify their email address.

UPDATE TEACHER SET email='samuel@gmail.com' WHERE teacher_id=2;

--4 Write an SQL query to delete a specific enrollment record from the "Enrollments" table. 
--Select an enrollment record based on the student and course.
DELETE FROM ENROLLMENTS WHERE student_id=19 and course_id=3

--5 Update the "Courses" table to assign a specific teacher to a course. 
--Choose any course and teacher from the respective tables.
UPDATE COURSES SET teacher_id=2 WHERE course_name='SQL'

--6 Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table.
--Be sure to maintain referential integrity.

-- set on demand cascade manually
DELETE FROM STUDENTS WHERE student_id=21

--7 Update the payment amount for a specific payment record in the "Payments" table. 
--Choose any payment record and modify the payment amount.
UPDATE PAYMENTS SET amount=850 WHERE amount=800

-- TASK 3

--1 Write an SQL query to calculate the total payments made by a specific student. 
--You will need to join the "Payments" table with the "Students" table based on the student's ID.
SELECT SUM(amount) AS [TOTAL PAYMENTS] FROM PAYMENTS AS P JOIN STUDENTS AS S ON 
P.student_id=S.student_id WHERE P.student_id=19

--2 Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
--Use a JOIN operation between the "Courses" table and the "Enrollments" table.
SELECT C.course_name,count(E.student_id) as [COUNT] FROM COURSES AS C JOIN ENROLLMENTS AS E ON
C.course_id=E.course_id GROUP BY C.course_name ORDER BY [COUNT]

--3 Write an SQL query to find the names of students who have not enrolled in any course. 
-- Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.
SELECT CONCAT_Ws(' ',first_name,last_name) AS [NAME] FROM STUDENTS AS S LEFT JOIN ENROLLMENTS AS E ON 
S.student_id=E.student_id WHERE E.student_id IS NULL

--4 Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. 
--Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
SELECT first_name,last_name,course_name FROM STUDENTS AS S JOIN ENROLLMENTS AS E ON 
S.student_id=E.student_id JOIN COURSES AS C ON E.course_id=C.course_id

--5 Create a query to list the names of teachers and the courses they are assigned to. 
--Join the "Teacher" table with the "Courses" table.
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name],C.course_name FROM TEACHER AS T JOIN COURSES AS C
ON T.teacher_id=C.teacher_id

--6 Retrieve a list of students and their enrollment dates for a specific course. 
--You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name],E.enrollment_date FROM STUDENTS AS S JOIN ENROLLMENTS AS E
ON S.student_id=E.student_id JOIN COURSES AS C ON C.course_id=E.course_id

--7 Find the names of students who have not made any payments. 
--Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name] FROM STUDENTS AS S LEFT JOIN PAYMENTS AS P
ON S.student_id=P.student_id WHERE P.amount IS NULL

--8 Write a query to identify courses that have no enrollments. 
--You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.
SELECT course_name FROM COURSES AS C LEFT JOIN ENROLLMENTS AS E
ON C.course_id=E.course_id WHERE E.course_id IS NULL

--9 Identify students who are enrolled in more than one course.
--Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
SELECT E1.student_id, COUNT(E2.enrollment_id) AS NUMBER_OF_COURSES FROM ENROLLMENTS E1 JOIN ENROLLMENTS E2
ON E1.enrollment_id=E2.enrollment_id GROUP BY E1.student_id 
HAVING COUNT(E2.enrollment_id)>1

--10 Find teachers who are not assigned to any courses.
--Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name] FROM TEACHER AS T LEFT JOIN COURSES AS C
ON T.teacher_id=C.teacher_id WHERE C.teacher_id IS NULL

-- TASK 4

--1 Write an SQL query to calculate the average number of students enrolled in each course.
--Use aggregate functions and subqueries to achieve this.
SELECT AVG(sub.total) AS AVERAGE FROM 
(SELECT COUNT(student_id) AS total FROM ENROLLMENTS GROUP BY course_id)sub

--2 Identify the student(s) who made the highest payment.
--Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.
SELECT student_id,sum(amount) as total from PAYMENTS group by student_id having sum(amount)= (SELECT MAX(sub2.total) as [maximum] From 
(select sum(amount) as [total] from PAYMENTS group by student_id)sub2)

--3 Retrieve a list of courses with the highest number of enrollments. 
--Use subqueries to find the course(s) with the maximum enrollment count.
select course_id,COUNT(enrollment_id) as Number from ENROLLMENTS group by course_id having count(enrollment_id) =
(select max(sub.total) from (select count(enrollment_id) as total from ENROLLMENTS group by course_id)sub)

--4 Calculate the total payments made to courses taught by each teacher.
--Use subqueries to sum payments for each teacher's courses.
select t.teacher_id,c.course_id, sum(p.amount) as total from PAYMENTS p join ENROLLMENTS e on p.student_id=e.student_id 
join COURSES c on e.course_id=c.course_id join Teacher t on c.teacher_id=t.teacher_id
group by t.teacher_id,c.course_id

--5 Identify students who are enrolled in all available courses. 
--Use subqueries to compare a student's enrollments with the total number of courses.
select student_id from ENROLLMENTS group by student_id having count(enrollment_id)=
(select count(course_id) from COURSES)

--6 Retrieve the names of teachers who have not been assigned to any courses. 
--Use subqueries to find teachers with no course assignments.
select CONCAT_WS(' ',first_name,last_name) as [name] from TEACHER where teacher_id not in 
(select teacher_id from COURSES where COURSES.teacher_id=TEACHER.teacher_id)

--7 Calculate the average age of all students. 
--Use subqueries to calculate the age of each student based on their date of birth.
select avg(sub.AGE) as [AVERAGE AGE] from (select DATEDIFF(year,date_of_birth,GETDATE()) -
case when DATEADD(year, DATEDIFF(year,date_of_birth,GETDATE()),date_of_birth) > GETDATE()
     then 1
	 else 0 end
as AGE from STUDENTS)sub

--8 Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
select course_name from COURSES where course_id not in (select distinct course_id from ENROLLMENTS)

--9 Calculate the total payments made by each student for each course they are enrolled in. 
--Use subqueries and aggregate functions to sum payments.
 SELECT s.student_id,c.course_id,SUM(p.amount) AS total_payments FROM students s
 JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id
 JOIN payments p ON e.student_id = p.student_id
 GROUP BY s.student_id,c.course_id

--10 Identify students who have made more than one payment. 
--Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.
select student_id,first_name from STUDENTS where student_id in 
(select student_id from Payments group by student_id having count(payment_id)>1) 

--11 Write an SQL query to calculate the total payments made by each student. 
--Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
select s.student_id,sum(p.amount) as AMOUNT from STUDENTS s join PAYMENTS p on s.student_id=p.student_id group by s.student_id

--12 Retrieve a list of course names along with the count of students enrolled in each course. 
--Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
select c.course_name,count(e.student_id) as NUMBER_OF_STUDENTS from COURSES c join ENROLLMENTS e on c.course_id=e.course_id group by c.course_name

--13 Calculate the average payment amount made by students.
--Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.
select avg(p.amount) as AVERAGE from STUDENTS s join PAYMENTS p on s.student_id=p.student_id 