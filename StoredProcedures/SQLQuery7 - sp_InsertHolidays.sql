--SQLQuery7 - sp_InsertHolidays
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE sp_InsertHolidays
											@year			AS	SMALLINT,
											@holiday_name	AS	NVARCHAR(50)
AS
BEGIN
		DECLARE	@holiday_id	AS	TINYINT	=	(SELECT	holiday_id	FROM	Holidays	WHERE	holiday_name	LIKE	@holiday_name);
		DECLARE	@duration	AS	TINYINT	=	(SELECT	duration	FROM	Holidays	WHERE	holiday_name	LIKE	@holiday_name);
		DECLARE	@day		AS	TINYINT	=	0;
		DECLARE	@date	AS	DATE	=	dbo.GetHolidaysStartDate(@year,@holiday_name);
		WHILE	@day < @duration
		BEGIN
			INSERT	DaysOFF([date],holiday) VALUES(@date,@holiday_id);
			SET		@date =	DATEADD(DAY,1,@date);
			SET		@day+= 1;
		END

END