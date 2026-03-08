--SQLQuery4-CREATE Schadule branch

USE PV_522_DDL

--CREATE TABLE Shedule
--(
--  lesson_id     BIGINT           PRIMARY KEY IDENTITY(1,1),
--	[group]       INT              NOT NULL
--  CONSTRAINT		FK_Shedule_Groups		FOREIGN KEY		REFERENCES Groups(group_id),
--	discipline    SMALLINT         NOT NULL
--	CONSTRAINT    FK_Shedule_Discipline  FOREIGN KEY REFERENCES Disciplines(discipline_id),
--	[date]        DATE             NOT NULL,
--	teacher       INT              NOT NULL
--	CONSTRAINT    FK_Shedule_Teacher     FOREIGN KEY REFERENCES Teachers(teacher_id),
--	[subject]     NVARCHAR(256)    NULL,
--	spent         BIT              NOT NULL,
--  time          TIME(0)
--);

--CREATE TABLE Grades
--(
--   student        INT,
--   lesson         BIGINT,
--   PRIMARY KEY(student,lesson),
--   CONSTRAINT     FK_Grades_Student    FOREIGN KEY(student)   REFERENCES Students(student_id),
--   CONSTRAINT     FK_Grades_Shedule    FOREIGN KEY(lesson)    REFERENCES Shedule(lesson_id),
--   grade_1        TINYINT   CONSTRAINT  CK_Grade_1  CHECK(grade_1 > 0 AND grade_1 <= 12),
--   grade_2        TINYINT   CONSTRAINT  CK_Grade_2  CHECK(grade_2 > 0 AND grade_2 <= 12)
--);

--CREATE TABLE HomeWorks
--(
--   [group]        INT,
--   lesson         BIGINT,
--	 PRIMARY KEY([group],lesson),
--	 CONSTRAINT     FK_HomeWorks_Group   FOREIGN KEY(group)  REFERENCES Group(group_id),
--	 CONSTRAINT     FK_HomeWorks_Shedule   FOREIGN KEY(lesson)   REFERENCES Shedule(lesson_id),
--	 [data]         VARBINARY(2000),
--	 [description]  NVARCHAR(255),
--	 CONSTRAINT     CK_Payload_HW   CHECK([description] IS NOT NULL OR [data] IS NOT NULL)
--);

--CREATE TABLE Exams
--(
--   teacher       INT,
--   student       INT,
--   discipline    SMALLINT,
--   PRIMARY KEY(student,discipline, teacher),
--   CONSTRAINT    FK_Exams_Teacher        FOREIGN KEY REFERENCES Teachers(teacher_id),
--   CONSTRAINT    FK_Exams_Student        FOREIGN KEY(student) REFERENCES Students(student_id),
--   CONSTRAINT    FK_Exams_Discipline     FOREIGN KEY(discipline) REFERENCES Disciplines(discipline_id),
--   grade         INT,
--   CONSTRAINT    CK_Grade                CHECK(grade > 0 AND grade <= 12),
--   completed     DATETIME2(0)
--);

--CREATE TABLE HWResults
--(
--  student        INT,
--  lessone        BIGINT,
--  [group]        INT,
--  PRIMARY KEY(student,lessone,[group]),
--  CONSTRAINT     FK_HWResults_HomeWorks  FOREIGN KEY([group],lessone) REFERENCES HomeWorks([group],lesson),
--  CONSTRAINT     FK_HWResults_Student      FOREIGN KEY(student) REFERENCES Students(student_id),
--  [description]  NVARCHAR(255),
--  [data]         VARBINARY(2000),
--  CONSTRAINT     CK_Payload_HWR   CHECK([description] IS NOT NULL OR [data] IS NOT NULL),
--  grade          INT                     NULL,
--  upload         DATETIME2(0)            NULL
--);