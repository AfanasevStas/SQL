--SQLQuery4 - COUNT
USE PV_522_Import

--SELECT
--		direction_name	AS	N'Направление обучения',
--		COUNT(group_id)	AS	N'Количество групп'
--FROM	Groups, Directions
--WHERE	direction=direction_id
--GROUP BY	direction_name
--ORDER BY	N'Количество групп'		DESC
--;

--SELECT
--			group_name		AS	N'Имя группы',
--			COUNT(stud_id)	AS	N'Количество студентов'
--FROM		Students,Groups
--WHERE		[group]=group_id
--GROUP BY	group_name
--HAVING		COUNT(stud_id) < 10
--;

--SELECT
--		[Направление обучения]	=	direction_name,
--		[Количество групп]		=	COUNT(DISTINCT group_id),
--		[Количество студенитов] =	COUNT(stud_id)
--FROM	Students, Groups, Directions
--WHERE	[group]		= group_id
--AND		direction	= direction_id
--GROUP BY	direction_name
--;

SELECT
		[Направление обучения]	=	direction_name,
		[Количество групп]		=	(SELECT  COUNT(group_id) FROM Groups WHERE direction=direction_id),
		[Количество студентов]	= (SELECT COUNT(stud_id) FROM Students,Groups WHERE [group]=group_id AND direction=direction_id)
FROM	Directions
--WHERE	direction=direction_id
;