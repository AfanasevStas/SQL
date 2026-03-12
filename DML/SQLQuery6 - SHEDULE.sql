--SQLQuery6 - SHEDULE
USE PV_522_Import

DECLARE @A INT;
SET @A = 0;
WHILE @A < 10
BEGIN
		INSERT Schedule 
				([group],discipline,teacher,	[date],			[time],		spent)
		VALUES	(11,			1,		1,		N'2020-01-01',	N'00:01',	1)
SET @A = @A + 1
END

SELECT *
FROM Schedule 