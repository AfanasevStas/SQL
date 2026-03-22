--SQLQuery1 - GetNextLearningDate - возвращает дату проведения следующего занятия
USE PV_522_Import
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetNextLearningDate(@group_name AS NCHAR(10), @last_learning_date AS DATE = N'1900-01-01')RETURNS DATE
AS
BEGIN
	DECLARE	@last_learning_day	AS	SMALLINT	=	DATEPART(WEEKDAY,@last_learning_date);
	DECLARE	@next_learning_day	AS	SMALLINT	=	dbo.GetNextLearningDay(@group_name, @last_learning_date);
	DECLARE	@interval			AS	SMALLINT	=	@next_learning_day - @last_learning_day;
	IF @interval < 0	SET @interval += 7;
	RETURN	DATEADD(DAY,@interval,@last_learning_date);
END