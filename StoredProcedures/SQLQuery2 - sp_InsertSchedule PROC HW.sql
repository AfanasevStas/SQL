--SQLQuery2 - sp_InsertSchedule PROC
USE PV_522_Import
SET DATEFIRST 1
GO
ALTER PROCEDURE sp_InsertSchedule
		@group_name			AS		NCHAR(10),
		@discipline_name	AS		NVARCHAR(150),
		@teacher_name		AS		NVARCHAR(50),
		@start_date			AS		DATE,
		@schedule_type		AS		SMALLINT
AS
BEGIN
		DECLARE @group		AS INT		= (SELECT group_id FROM Groups WHERE group_name=@group_name);
		DECLARE @discipline AS SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discipline_name);
		DECLARE @number_of_lessons AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_name LIKE @discipline_name);
		DECLARE @lesson_number	   AS TINYINT = 0;
		DECLARE @teacher	AS SMALLINT	= (SELECT teacher_id FROM Teachers WHERE first_name LIKE @teacher_name OR last_name LIKE @teacher_name);
		DECLARE @start_time AS TIME(0)	= (SELECT start_time FROM Groups WHERE group_id=@group);
		DECLARE @date		AS DATE		= @start_date;
		DECLARE @time		AS TIME(0)	= @start_time;
		DECLARE @march		AS DATE		= DATEFROMPARTS(DATEPART(year,@date),3,8); --my code
		DECLARE @february	AS DATE		= DATEFROMPARTS(DATEPART(year,@date),2,23); --my code
		DECLARE @NewYearStart AS DATE	= DATEFROMPARTS(DATEPART(year,@date),1,1); --my code
		DECLARE @NewYearFinish AS DATE	= DATEFROMPARTS(DATEPART(year,@date),1,12); --my code
		DECLARE @NewYear	AS DATE		= DATEFROMPARTS(DATEPART(year,@date),12,31); --my code
		DECLARE @basic_semester AS DATE = DATEADD(MONTH,1,@start_date); --my code
		DECLARE @check AS SMALLINT = 0; --my code
		DECLARE @startyear	AS INT		= DATEPART(YEAR,@date); --my code
		
		PRINT	@group;
		PRINT	@discipline
		PRINT	@number_of_lessons
		PRINT	@teacher
		PRINT	@start_date
		PRINT	@start_time
		PRINT	@basic_semester
		PRINT	N'======================================================';
		
		WHILE	@lesson_number < @number_of_lessons
		BEGIN
				SET	@time = @start_time;
				IF	@date != @march AND @date != @february AND @date != @NewYear --my code
				BEGIN --my code
							IF	@startyear < DATEPART(YEAR,@date) --my code
							BEGIN --my code
									SET		@NewYearStart = DATEADD(YEAR,1,@NewYearStart) --my code
									SET		@NewYearFinish = DATEADD(YEAR,1,@NewYearFinish) --my code
									SET		@startyear += 1 --my code
							END
							IF  @date < @NewYearFinish --my code
							BEGIN --my code
									-------------------------------------
																		IF @schedule_type = 1 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 6,3,2), @date); --my code
									IF @schedule_type = 2 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,2), @date); --my code
									IF @schedule_type = 3 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 4,5,2), @date); --my code
									IF @schedule_type = 4 --my code
										BEGIN --my code
											IF DATEPART(WEEKDAY,@date) = 2 --my code
											SET		@date = DATEADD(DAY, 2, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 4 --my code
											SET		@date = DATEADD(DAY, 1, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 5 --my code
											SET		@date = DATEADD(DAY, 4, @date) --my code
										END --my code
									IF @schedule_type = 5 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,4), @date); --my code
									---------------------------------------
							END --my code
							IF  @date >= @NewYearFinish --my code
							BEGIN--my code
									PRINT	FORMATMESSAGE(N'%i %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY,@date), CAST(@time AS NVARCHAR(12)));
									EXEC sp_InsertLesson @group, @discipline, @teacher,@date, @time OUTPUT, @lesson_number OUTPUT,@basic_semester,@check OUTPUT; --my code
									PRINT	FORMATMESSAGE(N'%i %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY,@date), CAST(@time AS NVARCHAR(12)));
									EXEC sp_InsertLesson @group, @discipline, @teacher,@date, @time OUTPUT, @lesson_number OUTPUT,@basic_semester,@check OUTPUT; --my code
									IF @schedule_type = 1 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 6,3,2), @date); --my code
									IF @schedule_type = 2 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,2), @date); --my code
									IF @schedule_type = 3 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 4,5,2), @date); --my code
									IF @schedule_type = 4 --my code
										BEGIN --my code
											IF DATEPART(WEEKDAY,@date) = 2 --my code
											SET		@date = DATEADD(DAY, 2, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 4 --my code
											SET		@date = DATEADD(DAY, 1, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 5 --my code
											SET		@date = DATEADD(DAY, 4, @date) --my code
										END --my code
									IF @schedule_type = 5 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,4), @date); --my code
							END--my 
				END--my code
				ELSE--my code
				BEGIN--my code
				  ---------------------
				  									IF @schedule_type = 1 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 6,3,2), @date); --my code
									IF @schedule_type = 2 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,2), @date); --my code
									IF @schedule_type = 3 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 4,5,2), @date); --my code
									IF @schedule_type = 4 --my code
										BEGIN --my code
											IF DATEPART(WEEKDAY,@date) = 2 --my code
											SET		@date = DATEADD(DAY, 2, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 4 --my code
											SET		@date = DATEADD(DAY, 1, @date) --my code
											IF DATEPART(WEEKDAY,@date) = 5 --my code
											SET		@date = DATEADD(DAY, 4, @date) --my code
										END --my code
									IF @schedule_type = 5 --my code
									SET		@date = DATEADD(DAY, IIF(DATEPART(WEEKDAY,@date) = 5,3,4), @date); --my code
					--------------------
				  CONTINUE--my code
				END--my code
	END
END