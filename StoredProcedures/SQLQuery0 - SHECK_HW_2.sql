--SQLQuery0 - SHECK_HW_2
USE PV_522_Import;
SET DATEFIRST 1;
SET LANGUAGE RUSSIAN;

PRINT DATENAME(QUARTER, GETDATE());

--DELETE FROM Schedule --WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name = N'HTML/CSS')
EXEC sp_InsertSchedule_HW_2 N'PV_522', N'%Win%C++',N'Юыху',N'2025-12-09';
EXEC sp_InsertSchedule_HW_2 N'PV_522', N'%Win%C#',N'Юыху',N'2025-12-30';
--EXEC	sp_InsertSchedule N'PV_522', N'%Win%C++',N'Юыху',N'2025-12-08'
EXEC	sp_SelectedShedule;
--EXEC	sp_SlectetDisciplineFromSchedule N'%ADO.NET%'



--SELECT * FROM Schedule;