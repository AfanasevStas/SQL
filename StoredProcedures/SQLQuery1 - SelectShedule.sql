--SQLQuery1 - SelectShedule
USE PV_522_Import;
GO
ALTER PROCEDURE sp_SelectedShedule
AS
BEGIN
		SELECT
					[Группа]		=	group_name,
					[Дисциплины]	=	discipline_name,
					[Преподаватель]	=	FORMATMESSAGE(N'%s %s %s', last_name,first_name,middle_name),
					[Дата]			=	[date],
					[День недели]	=	DATENAME(WEEKDAY,[date]),
					[Время]			=	[time],
					[Статус]		=	IIF(spent=1,N'Проведено',N'Запланировано')
		FROM		Schedule,Groups,Disciplines,Teachers
		WHERE		[group]			=	group_id
		AND			discipline		=	discipline_id
		AND			teacher			=	teacher_id
		ORDER BY	[date]
END