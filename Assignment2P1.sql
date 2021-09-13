/*
CS557 Assignment2P1 GroupA23
Junjia Lin (#002269013)
Luyun Nie (#002268087)
Wentao Lu (#002276355)
Yi Ren (#002269013)
*/

/* Queries */

/* Question 1: Teachers from ECE department*/
SELECT t_name FROM public.TEACHER
WHERE t_dept LIKE 'ECE';

/* Question 2: Students enrolled CS250*/
SELECT s_name FROM public.ENROLMENT
LEFT JOIN public.STUDENT
on ENROLMENT.s_id = STUDENT.s_id
WHERE c_id LIKE 'CS250';

/* Question 3(a): Students enrolled CS348and ECE264 OR CS348 and CS503*/
SELECT  DISTINCT s_id,s_name FROM STUDENT
WHERE s_id in(
	SELECT s_id FROM ENROLMENT
	WHERE c_id In ('CS348','ECE264')
    GROUP By s_id
    HAVING Count (DISTINCT c_id) = 2)
	OR
	s_id in(
	SELECT s_id FROM ENROLMENT
	WHERE c_id In ('CS348','CS503')
    GROUP BY s_id
    HAVING COUNT (DISTINCT c_id) = 2
	);


/* Question 4: Teachers teaching MA525*/
SELECT * FROM public.COURSE_SCHEDULE
LEFT JOIN public.TEACHER
on TEACHER.t_id = COURSE_SCHEDULE.t_id
WHERE c_ID LIKE 'MA525';


/* Question 5: Students enrolled one or three*/
SELECT DISTINCT s_id,s_name FROM STUDENT
WHERE s_id in(
	SELECT s_id FROM ENROLMENT
    Group By s_id
    Having Count (DISTINCT c_id) = 1) 
	OR 
	s_id in(SELECT s_id FROM ENROLMENT
    GROUP BY s_id
    Having Count (DISTINCT c_id) = 3);


/* Question 6: All students taught by Prof. Christopher Clifton*/
SELECT DISTINCT s_id,s_name FROM STUDENT
WHERE s_id in (
	SELECT s_id FROM ENROLMENT
	WHERE c_id in(
		SELECT c_id FROM COURSE_SCHEDULE
		WHERE t_id in (
			SELECT t_id FROM TEACHER
			WHERE t_name LIKE '%Christopher Clifton%'
		)
	)
);


/* Question 7 : undergraduate course(s) being taken by graduate student(s)*/
SELECT DISTINCT c_name FROM COURSE
WHERE c_level != 'GR' AND c_id IN(
	SELECT c_id FROM public.STUDENT
	LEFT JOIN public.ENROLMENT
	ON ENROLMENT.s_id = STUDENT.s_id
	WHERE s_status = 'GR');


/* Question 8 : undergraduate student(s) who is taking a course with Prof. Sheron Noel */
SELECT DISTINCT s_name FROM STUDENT
LEFT JOIN public.ENROLMENT
ON ENROLMENT.s_id = STUDENT.s_id
WHERE s_status != 'GR' AND c_id IN (
	SELECT c_id FROM COURSE_SCHEDULE
	WHERE t_id in (SELECT t_id FROM TEACHER WHERE t_name LIKE '%Sheron Noel')) 