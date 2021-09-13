/*
Junjia Lin (#002269013)
Luyun Nie (#002268087)
Wentao Lu (#002276355)
Yi Ren (#002269013)
*/

create table TEACHER(
	t_id   integer,
	t_name    text,
	t_states   text,
	t_dept   text,
	primary key(t_id)
);

create table COURSE(
	c_id   text,
	c_name    text,
	c_level   text,
	primary key(c_id)
);

create table STUDENT(
	s_id   integer,
	s_name   text,
	s_status    text,
	primary key(s_id)
);

create table ENROLMENT(
	c_id   text,
	s_id    integer,
	foreign key(c_id) references COURSE 
	    on delete set null,
	foreign key(s_id) references STUDENT 
	    on delete set null	
);
create table COURSE_SCHEDULE(
	c_id   text,
	t_id   integer,
	foreign key(c_id) references COURSE
	    on delete set null,
	foreign key(t_id) references TEACHER
	    on delete set null
);
