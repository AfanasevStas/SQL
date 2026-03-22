--SQLQuery2 - sp_InsertLesson_HW_2
USE PV_522_Import
SET DATEFIRST 1
GO

CREATE OR ALTER PROCEDURE sp_InsertLesson_HW_2
				@group AS INT, 
				@discipline AS SMALLINT, 
				@teacher AS SMALLINT, 
				@date AS DATE, 
				@time AS TIME(0) OUTPUT, 
				@lesson_number AS TINYINT OUTPUT,
				@basic_semester AS DATE, --my code
				@check AS SMALLINT OUTPUT --my code
AS
BEGIN
		DECLARE @discipline_2 AS SMALLINT = 31;
		IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time]=@time)
		BEGIN
				PRINT (N'---------------------- sp_InsertLesson ----------------------')
				PRINT (DATENAME(MONTH, @date));
				IF @date <= @basic_semester--my code
				BEGIN--my code
						PRINT DATENAME(WEEKDAY,@date)
						IF DATENAME(WEEKDAY,@date) = N'вторник'--my code
						BEGIN--my code
								PRINT @date;
								INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
								VALUES	(@group,@discipline_2,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
								PRINT(FORMATMESSAGE(N'%s (%s) - %s',CAST(@date AS NVARCHAR(24)), DATENAME(WEEKDAY,@date), N'INSERTED'));
						END--my code
						--------------------------
						IF DATENAME(WEEKDAY,@date) = N'четверг'--my code
						BEGIN--my code
								IF @check = 0--my code
								BEGIN--my code
											INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
											VALUES	(@group,@discipline,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
											PRINT(FORMATMESSAGE(N'%s (%s) - %s',CAST(@date AS NVARCHAR(24)), DATENAME(WEEKDAY,@date), N'INSERTED'));
											SET @check = 1--my code
								END--my code
								ELSE--my code
								BEGIN--my code
											INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
											VALUES	(@group,@discipline_2,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
											PRINT(FORMATMESSAGE(N'%s (%s) - %s',CAST(@date AS NVARCHAR(24)), DATENAME(WEEKDAY,@date), N'INSERTED'));
											SET @check = 0--my code
								END--my code
						END--my code
						--------------------------
						IF DATENAME(WEEKDAY,@date) = N'суббота'--my code
						BEGIN--my code
								INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
								VALUES	(@group,@discipline,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
								PRINT(FORMATMESSAGE(N'%s (%s) - %s',CAST(@date AS NVARCHAR(24)), DATENAME(WEEKDAY,@date), N'INSERTED'));
						END--my code
				END--my code
				IF @date > @basic_semester--my code
				BEGIN--my code
						INSERT	Schedule([group],discipline,teacher,[date],[time],spent)
						VALUES	(@group,@discipline,@teacher,@date,@time, IIF(@date < GETDATE(),1,0));
						PRINT(FORMATMESSAGE(N'%s (%s) - %s',CAST(@date AS NVARCHAR(24)), DATENAME(WEEKDAY,@date), N'INSERTED'));
				END--my code
		END
		SET		@time = DATEADD(MINUTE, 95,@time);
		SET		@lesson_number += 1;
END