--SQLQuery2-sp_InsertSchedule_HW_2.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE sp_InsertSchedule_HW_2
		@group_name					AS	NCHAR(10),
		@discipline_name			AS	NVARCHAR(150),
		@teacher_name				AS	NVARCHAR(50),
		@start_date					AS	DATE
AS
BEGIN
		DECLARE @group				AS	INT		=	(SELECT group_id			FROM Groups			WHERE group_name=@group_name);
		DECLARE @discipline			AS	SMALLINT=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
		DECLARE @number_of_lessons	AS	TINYINT	=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
		DECLARE @lesson_number		AS	TINYINT	=	0;	--Номер занятия
		DECLARE @teacher			AS	SMALLINT=	(SELECT teacher_id			FROM Teachers		WHERE first_name LIKE @teacher_name OR last_name LIKE @teacher_name);
		DECLARE @start_time			AS	TIME(0)	=	(SELECT start_time FROM Groups WHERE group_id = @group);
		DECLARE @date				AS	DATE	=	@start_date;
		DECLARE @time				AS	TIME(0)	=	@start_time;
		DECLARE	@new_start_date		AS	DATE	=	@date;										--------MY CODE
		DECLARE	@basic_semester		AS	DATE	=	DATEADD(MONTH,1,@start_date);				--------MY CODE
		DECLARE	@check				AS	BIT		=	0;											--------MY CODE
		DECLARE @march				AS DATE		=	DATEFROMPARTS(DATEPART(year,@date),3,8);	--------MY CODE
		DECLARE @february			AS DATE		=	DATEFROMPARTS(DATEPART(year,@date),2,23);	--------MY CODE
		DECLARE @NewYearStart		AS DATE		=	DATEFROMPARTS(DATEPART(year,@date),1,1);	--------MY CODE
		DECLARE @NewYearFinish		AS DATE		=	DATEFROMPARTS(DATEPART(year,@date),1,12);	--------MY CODE
		DECLARE @NewYear			AS DATE		=	DATEFROMPARTS(DATEPART(year,@date),12,31);	--------MY CODE
		DECLARE @startyear			AS INT		=	DATEPART(YEAR,@date);						--------MY CODE

		
		PRINT @group;
		PRINT @discipline;
		PRINT @number_of_lessons;
		PRINT @teacher;
		PRINT @start_date;
		PRINT @start_time;
		PRINT N'===============================================================';
		
		WHILE @lesson_number < @number_of_lessons
		BEGIN
			SET @time = @start_time;
				IF	@date != @march AND @date != @february AND @date != @NewYear	--------MY CODE
				BEGIN																--------MY CODE
					-------------------------------------
						IF	@startyear < DATEPART(YEAR,@date)	--------MY CODE
						BEGIN									--------MY CODE
								SET		@NewYearStart = DATEADD(YEAR,1,@NewYearStart)	--------MY CODE
								SET		@NewYearFinish = DATEADD(YEAR,1,@NewYearFinish)	--------MY CODE
								SET		@startyear += 1--------MY CODE
						END
					-------------------------------------
						IF  @date < @NewYearFinish	--------MY CODE
						BEGIN						--------MY CODE
									SET @date = dbo.GetNextLearningDate(@group_name,@new_start_date)	--------MY CODE
									SET @new_start_date = @date;	--------MY CODE
						END
					-------------------------------------
						IF  @date >= @NewYearFinish --------MY CODE
						BEGIN						--------MY CODE
										PRINT FORMATMESSAGE(N'%i, %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY, @date), CAST(@time AS NVARCHAR(12)));
										EXEC sp_InsertLesson_HW_2 @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT, @basic_semester, @check OUTPUT;--------MY CODE
										EXEC sp_InsertLesson_HW_2 @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT, @basic_semester, @check OUTPUT;--------MY CODE
										
										SET @date = dbo.GetNextLearningDate(@group_name,@new_start_date)	--------MY CODE
										SET @new_start_date = @date;										--------MY CODE

						END	--------MY CODE 
				END			--------MY CODE
				ELSE		--------MY CODE
				BEGIN		--------MY CODE
				  ---------------------
						SET @date = dbo.GetNextLearningDate(@group_name,@new_start_date)	--------MY CODE
						SET @new_start_date = @date;										--------MY CODE
					--------------------
				CONTINUE	--------MY CODE
				END			--------MY CODE
		END
END