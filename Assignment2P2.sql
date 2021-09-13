/*
CS557 Assignment2P2 GroupA23
Junjia Lin (#002269013)
Luyun Nie (#002268087)
Wentao Lu (#002276355)
Yi Ren (#002269013)
*/

/* Question 1: titles of courses in the Comp. Sci. department with 3 credits */
SELECT title FROM COURSE
WHERE dept_name LIKE 'Comp. Sci.' AND credits = 3;

/* Question 2: IDs of all students taught by Einstein  */
/* Attention: name modified--since take.id is a foreign key from table 'student'*/
SELECT DISTINCT TAKES.id FROM TAKES
WHERE TAKES.course_id in (
	SELECT course_id FROM TEACHES
	WHERE TEACHES.id in (
		SELECT INSTRUCTOR.id FROM INSTRUCTOR
		WHERE INSTRUCTOR.name LIKE '%Einstein%'));

/* Question 3: Highest salary indicidual among all instructor */
SELECT INSTRUCTOR.name FROM INSTRUCTOR
ORDER BY INSTRUCTOR.salary DESC LIMIT 1;

/* Question 4: Highest salary people among all instructor */
SELECT * FROM public.INSTRUCTOR
WHERE INSTRUCTOR.id IN(
	SELECT id FROM INSTRUCTOR
	WHERE salary  = (
		SELECT MAX(salary) FROM INSTRUCTOR));

/* Question 5:Enrollment of each section that was offered in Autumn 2009 */
SELECT sec_id FROM public.SECTION
WHERE public.SECTION.year = 2009 AND semester LIKE 'Fall';

/* Question 6: The maximum enrollment, across all sections, in Autumn 2009*/
SELECT course_id,COUNT(*) FROM TAKES
WHERE TAKES.year = 2009 AND semester LIKE 'Fall'
GROUP BY course_id
ORDER BY COUNT(*) DESC LIMIT 1;

/* Question 7: The the section that has maximum enrolment in Autumn 2009*/
SELECT sec_id,COUNT(*) FROM TAKES
WHERE TAKES.year = 2009 AND semester LIKE 'Fall'
GROUP BY sec_id
ORDER BY COUNT(*) DESC LIMIT 1;


/* Question 8: ID12345 greadpoints */
SELECT SUM(gradepoints) FROM(
	SELECT DISTINCT grade, credits,
	CASE
	    WHEN grade = 'A+' THEN 4.3*credits
	    WHEN grade = 'A ' THEN 4.0*credits
	    WHEN grade = 'A-' THEN 3.7*credits
	    WHEN grade = 'B+' THEN 3.3*credits
	    WHEN grade = 'B ' THEN 3.0*credits
	    WHEN grade = 'B-' THEN 2.7*credits
	    WHEN grade ='C+' THEN 2.3*credits
	    WHEN grade ='C ' THEN 2.0*credits
        WHEN grade ='C-' THEN 2.3*credits
    END AS gradepoints
FROM TAKES,COURSE
WHERE TAKES.id = '12345') AS totalgradpoints;

/* Question 9: ID12345 greadpoints */
SELECT ROUND(SUM(gradepoints)/SUM(credits),2) FROM(
	SELECT DISTINCT grade, credits,
	CASE
	    WHEN grade = 'A+' THEN 4.3*credits
	    WHEN grade = 'A' THEN 4.0*credits
	    WHEN grade = 'A-' THEN 3.7*credits
	    WHEN grade = 'B+' THEN 3.3*credits
	    WHEN grade = 'B' THEN 3.0*credits
	    WHEN grade = 'B-' THEN 2.7*credits
	    WHEN grade ='C+' THEN 2.3*credits
	    WHEN grade ='C' THEN 2.0*credits
        WHEN grade ='C-' THEN 2.3*credits
		WHEN grade ='F' THEN 1*credits
		WHEN grade IS NULL THEN 0
    END AS gradepoints
FROM TAKES,COURSE
WHERE TAKES.id = '12345') AS average_gpa;

/* Question 10: The average GPA for each student */
SELECT newsheet.id,ROUND(SUM(newsheet.gradepoints)/SUM(credits),3) 
FROM(
    SELECT DISTINCT TAKES.id,grade,credits,
	CASE
	    WHEN grade = 'A+' THEN 4.3*credits
	    WHEN grade = 'A' THEN 4.0*credits
	    WHEN grade = 'A-' THEN 3.7*credits
	    WHEN grade = 'B+' THEN 3.3*credits
	    WHEN grade = 'B' THEN 3.0*credits
	    WHEN grade = 'B-' THEN 2.7*credits
	    WHEN grade ='C+' THEN 2.3*credits
	    WHEN grade ='C' THEN 2.0*credits
        WHEN grade ='C-' THEN 2.3*credits
		WHEN grade ='F' THEN 1*credits
		WHEN grade IS NULL THEN 0
    END AS gradepoints
FROM TAKES,COURSE) AS newsheet 
GROUP BY newsheet.id 
ORDER BY newsheet.id;

/* Question 11: Increase the salary of each instructor in the Comp. Sci. department by 10%. */

UPDATE public.INSTRUCTOR
SET salary = salary*1.1
WHERE dept_name = 'Comp. Sci.';

/* Question 12: Delete all courses that have never been offered. */
DELETE FROM COURSE
WHERE COURSE.course_id NOT IN (SELECT SECTION.course_id FROM SECTION);

/* Question 13: Insert every student whose tot_cred attribute is greater than 100 as an instructor in
the same department, with a salary of $10,000. */
/* Attention: DISABLE or DROP the CONSTRAINT before INSERT */
-- ALTER TABLE INSTRUCTOR
-- DROP CONSTRAINT instructor_salary_check;

INSERT INTO INSTRUCTOR(id,name,dept_name,salary)
SELECT STUDENT.id, STUDENT.name, STUDENT.dept_name,10000
FROM STUDENT WHERE STUDENT.tot_cred > 100 AND STUDENT.id NOT IN(
	SELECT id FROM INSTRUCTOR);
	
-- ALTER TABLE INSTRUCTOR
-- ADD CONSTRAINT instructor_salary_check check(salary >29000);
