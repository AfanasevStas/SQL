--SQLQuery1 - sp_GetNextLearningDate - возвращает дату проведения следующего занятия
USE PV_522_Import
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE sp_GetNextLearningDate @group_name AS NCHAR(10), @last_learning_date AS DATE
AS
BEGIN
	DECLARE	@last_learning_day	AS	TINYINT	=	DATEPART(WEEKDAY,@last_learning_date);
	DECLARE	@next_learning_day	AS	TINYINT	=	dbo.GetNextLearningDay(@group_name, @last_learning_date);
	DECLARE	@interval			AS	TINYINT	=	@next_learning_day - @last_learning_day;
	IF @interval < 0	SET @interval += 7;

	PRINT @last_learning_day	
	PRINT @next_learning_day	
	PRINT @interval			

	PRINT	DATEADD(DAY,@interval,@last_learning_date);
END