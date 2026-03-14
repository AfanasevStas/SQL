--SQLQuery1 - INSERT Schedule
USE PV_522_Import
SET DATEFIRST 1;
SET LANGUAGE  RUSSIAN;

--DELETE FROM Schedule;

DECLARE @group		AS INT		= (SELECT group_id FROM Groups WHERE group_name=N'PV_522');
DECLARE @discipline AS SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'Сетевое%');
DECLARE @number_of_lessons AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_name LIKE N'Сетевое%');
DECLARE @lesson_number	   AS TINYINT = 0;
DECLARE @teacher	AS SMALLINT	= (SELECT teacher_id FROM Teachers WHERE first_name = N'Олег');
DECLARE @start_date AS DATE		= N'2026-04-28';
DECLARE @start_time AS TIME(0)	= N'18:30';
DECLARE @date		AS DATE		= @start_date;
DECLARE @time		AS TIME(0)	= @start_time;

PRINT	@group;
PRINT	@discipline
PRINT	@number_of_lessons
PRINT	@teacher
PRINT	@start_date
PRINT	@start_time
PRINT	N'======================================================';

WHILE	@lesson_number < @number_of_lessons
BEGIN
		SET		@time = @start_time;
		PRINT	FORMATMESSAGE(N'%i %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY,@date), CAST(@time AS NVARCHAR(12)));
		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time]=@time)
		--		INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
		--		VALUES	(@group,@discipline,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
		--SET		@time = DATEADD(MINUTE, 95,@time);
		--SET		@lesson_number += 1;
		EXEC sp_InsertLesson @group, @discipline, @teacher,@date, @time OUTPUT, @lesson_number OUTPUT;
		PRINT	FORMATMESSAGE(N'%i %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY,@date), CAST(@time AS NVARCHAR(12)));
		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time]=@time)
		--		INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
		--		VALUES	(@group,@discipline,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
		--SET		@lesson_number += 1;
		EXEC sp_InsertLesson @group, @discipline, @teacher,@date, @time OUTPUT, @lesson_number OUTPUT;
		SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 6,3,2), @date);
END

SELECT 
		[Группа]	=	group_name,
		[Дисциплина]=	discipline_name,
		[Преподаватель]= FORMATMESSAGE(N'%s %s %s', last_name,first_name,middle_name),
		[Дата]		=	[date],
		[День недели]	=	DATENAME(WEEKDAY,[date]),
		[Время]		=	[time],
		[Статус]	=	IIf(spent=1, N'Проведено',N'Запланировано')
FROM	Schedule,Groups,Teachers,Disciplines
WHERE	[group]		=	group_id
AND		discipline	=	discipline_id
AND		teacher		=	teacher_id
;