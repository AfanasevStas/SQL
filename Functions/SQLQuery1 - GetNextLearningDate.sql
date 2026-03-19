--SQLQuery1 - GetNextLearningDate - возвращает дату проведения следующего занятия
USE PV_522_Import
GO

CREATE FUNCTION GetNextLearningDate(@group_name AS NCHAR(10), @last_learning_date AS DATE = N'1900-01-01')RETURNS DATE
AS
BEGIN
	
END