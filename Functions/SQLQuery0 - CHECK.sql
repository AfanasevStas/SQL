--SQLQuery0 - CHECK
USE PV_522_Import;
SET DATEFIRST 1;
--PRINT	dbo.GetLastLearningDate(N'PV_522');
--EXEC	sp_SelectedShedule;

PRINT	dbo.GetNextLearningDay(N'PV_522',N'2026-03-19')
PRINT	dbo.GetNextLearningDate(N'PV_522',N'2026-03-21')

