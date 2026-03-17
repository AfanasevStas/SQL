--SQLQuery1 - GetLastLearningDate
USE PV_522_Import;
GO
ALTER FUNCTION GetLastLearningDate (@group_name AS NCHAR(10)) RETURNS DATE
AS
BEGIN
		RETURN (SELECT MAX([date]) FROM Schedule WHERE [group] = (SELECT group_id FROM Groups WHERE group_name=@group_name));
		--DECLARE @group_id	AS	INT		=	(SELECT group_id FROM Groups WHERE group_name = @group_name);
		--RETURN	(SELECT MAX([date]) FROM Schedule WHERE [group]=@group_id);
		--DECLARE @date		AS	DATE	=	(SELECT MAX([date]) FROM Schedule WHERE [group] = @group_id);
		--RETURN	@date;
END