--SQLQuery3 - SELECT Student
USE PV_522_Import

--SELECT
--		[Студент]	=	FORMATMESSAGE(N'%s %s %s', last_name,first_name,middle_name),
--		[Дата рождения]=birth_date,
--		[Возраст]	=	CAST(DATEDIFF(DAY, [birth_date], GETDATE())/365.25 AS TINYINT),
--		[Группа]	=	group_name,
--		[Специальность]=direction_name
--FROM	Students, Groups, Directions
--WHERE	[group]		=	group_id
--AND		direction	=	direction_id
--ORDER BY	[Возраст]	DESC
--;

--SELECT 
--		[Преподаватель] = FORMATMESSAGE(N'%s %s %s', last_name,first_name,middle_name),
--		[Дисциплина]	= discipline_name,
--		[Первичный Ключ Дисциплины]	= discipline_id,
--		[Номер Дисциплины]	= number_of_lessons
--FROM Disciplines,Teachers,TeachersDisciplinesRelation
--WHERE	teacher=1
--AND		discipline=discipline_id
--AND		teacher=teacher_id
--
--;

--SELECT
--		[Дисциплина]	=	discipline_name,
--		[Преподаватель]	=	FORMATMESSAGE(N'%s %s %s', last_name,first_name,middle_name),
--		[Первичный Ключ Преподавателя]	=	teacher_id
--FROM	Disciplines,Teachers,TeachersDisciplinesRelation
--WHERE	discipline_id=1
--AND		discipline=discipline_id
--AND		teacher=teacher_id
--
--;