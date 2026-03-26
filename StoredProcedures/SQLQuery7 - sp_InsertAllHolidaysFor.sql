--SQLQuery7 - sp_InsertAllHolidaysFor
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE sp_InsertAllHolidaysFor @year AS SMALLINT
AS
BEGIN
	EXEC sp_InsertHolidays @year, N'Новогодние%';
	EXEC sp_InsertHolidays @year, N'23%';
	EXEC sp_InsertHolidays @year, N'8%';
	EXEC sp_InsertHolidays @year, N'Пасха';
	EXEC sp_InsertHolidays @year, N'Майские%';
	EXEC sp_InsertHolidays @year, N'Летние%';
END