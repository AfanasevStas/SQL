--SQLQuery5 - COUNT Disciplines
USE PV_522_Import

SELECT
		--discipline_name
		FORMATMESSAGE(N'%s %s %s', last_name, first_name,middle_name)
FROM	Teachers,Disciplines,TeachersDisciplinesRelation
WHERE	teacher		=	teacher_id
AND		discipline	=	discipline_id
--AND		last_name	=	N'Глазунов'
AND		discipline_name		LIKE	N'%MS SQL%'
;