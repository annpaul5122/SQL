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

--1 
INSERT INTO STUDENTS (first_name,last_name,date_of_birth,email,phone_number) VALUES
('John','Doe','1995-08-15','john.doe@example.com','1234567890')

--2
INSERT INTO ENROLLMENTS (student_id,course_id,enrollment_date) VALUES
(19,3,'2024-02-16')

--3
UPDATE TEACHER SET email='samuel@gmail.com' WHERE teacher_id=2;

--4
DELETE FROM ENROLLMENTS WHERE student_id=19 and course_id=3

--5
UPDATE COURSES SET teacher_id=2 WHERE course_name='SQL'

--6
DELETE FROM STUDENTS WHERE student_id=21

--7
UPDATE PAYMENTS SET amount=850 WHERE amount=800

-- TASK 3

--1
SELECT SUM(amount) AS [TOTAL PAYMENTS] FROM PAYMENTS AS P JOIN STUDENTS AS S ON 
P.student_id=S.student_id WHERE P.student_id=19

--2
SELECT C.course_name,count(E.student_id) as [COUNT] FROM COURSES AS C JOIN ENROLLMENTS AS E ON
C.course_id=E.course_id GROUP BY C.course_name ORDER BY [COUNT]

--3
SELECT CONCAT_Ws(' ',first_name,last_name) AS [NAME] FROM STUDENTS AS S LEFT JOIN ENROLLMENTS AS E ON 
S.student_id=E.student_id WHERE E.student_id IS NULL

--4
SELECT first_name,last_name,course_name FROM STUDENTS AS S JOIN ENROLLMENTS AS E ON 
S.student_id=E.student_id JOIN COURSES AS C ON E.course_id=C.course_id

--5
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name],C.course_name FROM TEACHER AS T JOIN COURSES AS C
ON T.teacher_id=C.teacher_id

--6
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name],E.enrollment_date FROM STUDENTS AS S JOIN ENROLLMENTS AS E
ON S.student_id=E.student_id JOIN COURSES AS C ON C.course_id=E.course_id

--7
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name] FROM STUDENTS AS S LEFT JOIN PAYMENTS AS P
ON S.student_id=P.student_id WHERE P.amount IS NULL

--8
SELECT course_name FROM COURSES AS C LEFT JOIN ENROLLMENTS AS E
ON C.course_id=E.course_id WHERE E.course_id IS NULL

--9
SELECT E1.student_id, COUNT(E2.enrollment_id) AS NUMBER_OF_COURSES FROM ENROLLMENTS E1 JOIN ENROLLMENTS E2
ON E1.enrollment_id=E2.enrollment_id GROUP BY E1.student_id 
HAVING COUNT(E2.enrollment_id)>1

--10
SELECT CONCAT_WS(' ',first_name,last_name) AS [Name] FROM TEACHER AS T LEFT JOIN COURSES AS C
ON T.teacher_id=C.teacher_id WHERE C.teacher_id IS NULL

-- TASK 4

--1 
SELECT AVG(sub.total) AS AVERAGE FROM 
(SELECT COUNT(student_id) AS total FROM ENROLLMENTS GROUP BY course_id)sub

--2 
SELECT student_id,sum(amount) as total from PAYMENTS group by student_id having sum(amount)= (SELECT MAX(sub2.total) as [maximum] From 
(select sum(amount) as [total] from PAYMENTS group by student_id)sub2)

--3 
select course_id,COUNT(enrollment_id) as Number from ENROLLMENTS group by course_id having count(enrollment_id) =
(select max(sub.total) from (select count(enrollment_id) as total from ENROLLMENTS group by course_id)sub)

--4 
select t.teacher_id,c.course_id, sum(p.amount) as total from PAYMENTS p join ENROLLMENTS e on p.student_id=e.student_id 
join COURSES c on e.course_id=c.course_id join Teacher t on c.teacher_id=t.teacher_id
group by t.teacher_id,c.course_id

--5
select student_id from ENROLLMENTS group by student_id having count(enrollment_id)=
(select count(course_id) from COURSES)

--6
select CONCAT_WS(' ',first_name,last_name) as [name] from TEACHER where teacher_id not in 
(select teacher_id from COURSES where COURSES.teacher_id=TEACHER.teacher_id)

--7
select avg(sub.AGE) as [AVERAGE AGE] from (select DATEDIFF(year,date_of_birth,GETDATE()) -
case when DATEADD(year, DATEDIFF(year,date_of_birth,GETDATE()),date_of_birth) > GETDATE()
     then 1
	 else 0 end
as AGE from STUDENTS)sub

--8
select course_name from COURSES where course_id not in (select distinct course_id from ENROLLMENTS)

--9 
 SELECT s.student_id,c.course_id,SUM(p.amount) AS total_payments FROM students s
 JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id
 JOIN payments p ON e.student_id = p.student_id
 GROUP BY s.student_id,c.course_id

--10
select student_id,first_name from STUDENTS where student_id in 
(select student_id from Payments group by student_id having count(payment_id)>1) 

--11
select s.student_id,sum(p.amount) as AMOUNT from STUDENTS s join PAYMENTS p on s.student_id=p.student_id group by s.student_id

--12
select c.course_name,count(e.student_id) as NUMBER_OF_STUDENTS from COURSES c join ENROLLMENTS e on c.course_id=e.course_id group by c.course_name

--13
select avg(p.amount) as AVERAGE from STUDENTS s join PAYMENTS p on s.student_id=p.student_id 