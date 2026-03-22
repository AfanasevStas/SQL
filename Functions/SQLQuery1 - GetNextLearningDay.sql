--SQLQuery1 - GetNextLearningDay - возвращает день недели, в который будет новое занятие
USE PV_522_Import
SET DATEFIRST 1;
GO

ALTER FUNCTION GetNextLearningDay(@group_name AS NCHAR(10), @last_learning_date AS DATE) RETURNS TINYINT
AS
BEGIN
	DECLARE	@group_id			AS	INT		=	(SELECT group_id FROM Groups WHERE group_name = @group_name);
	DECLARE	@learning_days		AS	SMALLINT	=	(SELECT learning_days FROM Groups WHERE group_id = @group_id);
	DECLARE	@last_learning_day	AS	SMALLINT	=	DATEPART(WEEKDAY, @last_learning_date);
	DECLARE	@next_learning_day	AS	SMALLINT	=	0;
	DECLARE	@day				AS	SMALLINT	=	@last_learning_day+1;

	WHILE @day <= 14
	BEGIN
			IF @learning_days & POWER(2,@day%7 - 1) != 0
				RETURN @day%7;
			SET @day += 1;
	END
	RETURN	0;
END