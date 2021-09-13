/*
CS557 Assignment2P2 GroupA23
Junjia Lin (#002268506)
Luyun Nie (#002268087)
Wentao Lu (#002276355)
Yi Ren (#002269013)
*/

/*Question 1: */
select distinct student.name from student
where student.id in (
	select distinct takes.id from takes
	where takes.course_id in(
		select course.course_id from course
		where course.dept_name like 'Comp. Sci.'));

/* Question 2: */
select distinct student.id, student.name from student
where student.id not in(
	select takes.id from takes where takes.year < 2009 );

/* Question 3: */
select instructor.dept_name, max(instructor.salary) from instructor
group by instructor.dept_name;

/* Question 4: */
select instructor.dept_name, max(instructor.salary) from instructor
group by instructor.dept_name
order by max(instructor.salary) asc limit 1;

/* Question 5: 0 credit couldn't be inserted since the constraints*/
/* Unless we DISABLE or DROP the CONSTRAINT*/
insert into course values ('CS-001','Weekly Seminar',null,1);

/* Question 6: */
insert into public.section values('CS-001', '1', 'Fall', '2009',null,null,null);

/* Question 7 : */
Insert into takes(id,course_id,sec_id,semester,year)
Select id,'CS-001','1','Fall',2009 From student
where dept_name like 'Comp. Sci.';

/* Question 8: */
Delete from takes 
Where course_id ='CS-001' and sec_id = '1' and semester='Fall' and year =2009
and id in(
	select id from student
	where name like '%Chavez%');
	
/* Question 9: */
/* If we delete the course CS-001 without deleting section of this course, the change would be 
cascaded to the data related in table 'section' 'prereq' and 'take', since we have `on delete cascade`
 referential action for the foreign key in the tables mentioned. */
delete from course
where course_id  = 'CS-001';

/* Question 10: */
delete from section
where course_id in (
	select course_id from course
	where lower(title) like '%database%'
);

/* Question 11: */

/* Question 11-a: */
SELECT id, score,  
	CASE 
		WHEN score < 40 THEN 'F'
	    WHEN 40 <= score and score < 60 THEN 'C'
		WHEN 60 <= score and score < 80 THEN 'B'
		WHEN 80 <= score THEN 'A'
	END AS grade FROM marks;

/* Question 11-b: for this question, we implemented our query with 2 method: WITH and UPDATE*/
/* Method - 1: WITH*/
WITH temp_marks AS (
	SELECT id, score, 
	CASE 
		WHEN score < 40 THEN 'F'
	    WHEN 40 <= score and score < 60 THEN 'C'
		WHEN 60 <= score and score < 80 THEN 'B'
		WHEN 80 <= score THEN 'A'
	END AS grade FROM marks
)
SELECT grade, COUNT(grade) FROM temp_marks GROUP BY grade ORDER BY grade;

/* Method - 2: UPDATE*/
/* We need to add a new COLUMN or change the type of COLUMN score from numeric to varchar before UPDATE*/
ALTER TABLE marks
ADD COLUMN grade VARCHAR;
UPDATE marks SET grade = 
CASE
	    WHEN score < 40 THEN 'F'
	    WHEN 40 <= score and score < 60 THEN 'C'
		WHEN 60 <= score and score < 80 THEN 'B'
		WHEN 80 <= score THEN 'A'
		END;
SELECT grade, COUNT(grade) FROM marks GROUP BY grade ORDER BY grade;

/* QUestion 12: */

select * from department
where lower(dept_name) like '%sci%';

