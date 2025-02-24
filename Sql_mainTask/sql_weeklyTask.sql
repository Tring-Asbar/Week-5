--students table
create table students(
	student_rollNo serial primary key,
	student_name varchar(30) not null
);
insert into students(student_name) values('Asbar');
insert into students(student_name) values('Manoj');
insert into students(student_name) values('Dinesh');
insert into students(student_name) values('Yeswanth');
insert into students(student_name) values('Mithun');

select * from students;

--subjects table
create table subjects(
	subject_one varchar(30) not null,
	subject_two varchar(30) not null,
	subject_three varchar(30) not null,
	student_rollNo int unique references students(student_rollNo)
);
insert into subjects(subject_one,subject_two,subject_three,student_rollNo) values('Maths','Physics','Chemistry',5);
insert into subjects(subject_one,subject_two,subject_three,student_rollNo) values('Maths','Computer Science','Chemistry',3);
insert into subjects(subject_one,subject_two,subject_three,student_rollNo) values('Maths','Physics','Chemistry',2);
insert into subjects(subject_one,subject_two,subject_three,student_rollNo) values('Maths','Computer Science','Chemistry',4)
insert into subjects(subject_one,subject_two,subject_three,student_rollNo) values('Maths','Physics','Chemistry',1);

select * from subjects;

--marks table
create table marks(
	mark_one int check(0<mark_one<101) not null,
	mark_two int check(0<mark_two<101) not null,
	mark_three int check(0<mark_three<101) not null,
	student_rollNo int unique references students(student_rollNo)
);
insert into marks(mark_one,mark_two,mark_three,student_rollNo) values(82,85,87,4);
insert into marks(mark_one,mark_two,mark_three,student_rollNo) values(75,80,70,5);
insert into marks(mark_one,mark_two,mark_three,student_rollNo) values(65,85,57,2);
insert into marks(mark_one,mark_two,mark_three,student_rollNo) values(37,55,49,1);
insert into marks(mark_one,mark_two,mark_three,student_rollNo) values(82,95,100,3);

select * from marks;

--calculate average marks
create function average(mark_one int ,mark_two int , mark_three int)
returns text as $$
declare
	avg_marks int;
begin
	avg_marks = (mark_one+mark_two+mark_three)/3;
	return avg_marks;
end;
$$ language plpgsql;

--calculate grade
create function grade(mark_one int ,mark_two int , mark_three int)
returns text as $$
declare
	avg_marks int;
begin
	avg_marks = (mark_one+mark_two+mark_three)/3;
	if(avg_marks>90)
	then 
		return 'A+';
	elsif(avg_marks>80)
	then 
		return 'A';
	elsif(avg_marks>70)
	then
		return 'B+';
	elsif(avg_marks>50)
	then
		return 'B';
	else
		return 'Fail';
	end if;
end;
$$ language plpgsql;

select mark_one,mark_two,mark_three,average(mark_one,mark_two,mark_three) as Average_Marks , grade(mark_one,mark_two,mark_three) as Grade from marks;

--display with students,marks,subjects and grade
select st.student_rollNo,st.student_name, s.subject_one,s.subject_two,s.subject_three,m.mark_one,m.mark_two,m.mark_three ,
average(m.mark_one,m.mark_two,m.mark_three) as Average_Marks , grade(m.mark_one,m.mark_two,m.mark_three) as Grade from students st 
inner join subjects s on st.student_rollNo = s.student_rollNo inner join marks m on st.student_rollNo = m.student_rollNo order by(s.student_rollNo);












