--SQLQuery5-ALL_IN_ONE
USE master

CREATE DATABASE PV_522_ALL_IN_ONE
ON
(
  NAME       =    PV_522_ALL_IN_ONE,
  FILENAME   =    'D:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_522_ALL_IN_ONE.mdf',
  SIZE       =    8 MB,
  MAXSIZE    =    500 MB,
  FILEGROWTH =    8 MB
)
LOG ON
(
  NAME     =  PV_522_ALL_IN_ONE_Log,
  FILENAME = 'D:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_522_ALL_IN_ONE.ldf',
  SIZE     =  8 MB,
  MAXSIZE  =  500 MB,
  FILEGROWTH = 8 MB
);
GO

USE PV_522_ALL_IN_ONE

CREATE TABLE Directions
(
  direction_id   SMALLINT  PRIMARY KEY,
  direction_name NVARCHAR(50)NOT NULL
);

CREATE TABLE Groups
(
  group_id   INT   PRIMARY KEY,
  group_name   NVARCHAR(24)NOT NULL,
  start_date  DATE NOT NULL,
  start_time TIME NOT NULL,
  learning_days INT NOT NULL,
  direction SMALLINT NOT NULL
  CONSTRAINT FK_Groups_Directions FOREIGN KEY REFERENCES Directions(direction_id)
);

CREATE TABLE Teachers
(
  teacher_id    INT             PRIMARY KEY,
  last_name     NVARCHAR(50)   NOT NULL,
  first_name    NVARCHAR(50)   NOT NULL,
  middle_name   NVARCHAR(50),
  birth_date    DATE,
  rate          SMALLMONEY       DEFAULT 50
);


CREATE TABLE Students
(
  student_id        INT       PRIMARY KEY,
  last_name     NVARCHAR(255)   NOT NULL,
  first_name    NVARCHAR(255)   NOT NULL,
  middle_name   NVARCHAR(255),
  birth_date    DATE,
  [group]       INT
  CONSTRAINT    FK_Students_Groups    FOREIGN KEY REFERENCES   Groups(group_id)
);

CREATE TABLE Disciplines
(
  discipline_id     SMALLINT       PRIMARY KEY,
  discipline_name   NVARCHAR(150)  NOT NULL,
  number_of_lessons TINYINT        NOT NULL
);

CREATE TABLE TeachersDisciplinesRelation
(
  teacher        INT,
  discipline     SMALLINT,
  PRIMARY KEY   (teacher,discipline),
  CONSTRAINT    FK_TDR_Teachers   FOREIGN KEY (teacher) REFERENCES Teachers(teacher_id),
  CONSTRAINT    FK_TDR_Discipline FOREIGN KEY (discipline) REFERENCES Disciplines(discipline_id)
);

CREATE TABLE DisciplinesDirectionRelation
(
  discipline   SMALLINT,
  direction    SMALLINT,
  PRIMARY KEY  (discipline,direction),
  CONSTRAINT   FK_DDR_Discipline   FOREIGN KEY (discipline) REFERENCES Disciplines(discipline_id),
  CONSTRAINT   FK_DDR_Directions   FOREIGN KEY (direction)  REFERENCES Directions(direction_id)
);

CREATE TABLE Shedule
(
  lesson_id     BIGINT           PRIMARY KEY IDENTITY(1,1),
  [group]       INT              NOT NULL
  CONSTRAINT		FK_Shedule_Groups		FOREIGN KEY		REFERENCES Groups(group_id),
  discipline    SMALLINT         NOT NULL
  CONSTRAINT    FK_Shedule_Discipline  FOREIGN KEY REFERENCES Disciplines(discipline_id),
  [date]        DATE             NOT NULL,
  teacher       INT              NOT NULL
  CONSTRAINT    FK_Shedule_Teacher     FOREIGN KEY REFERENCES Teachers(teacher_id),
  [subject]     NVARCHAR(256)    NULL,
  spent         BIT              NOT NULL,
  time          TIME(0)
);

CREATE TABLE Grades
(
  student        INT,
  lesson         BIGINT,
  PRIMARY KEY(student,lesson),
  CONSTRAINT     FK_Grades_Student    FOREIGN KEY(student)   REFERENCES Students(student_id),
  CONSTRAINT     FK_Grades_Shedule    FOREIGN KEY(lesson)    REFERENCES Shedule(lesson_id),
  grade_1        TINYINT   CONSTRAINT  CK_Grade_1  CHECK(grade_1 > 0 AND grade_1 <= 12),
  grade_2        TINYINT   CONSTRAINT  CK_Grade_2  CHECK(grade_2 > 0 AND grade_2 <= 12)
);

CREATE TABLE HomeWorks
(
  [group]        INT,
  lesson         BIGINT,
  PRIMARY KEY([group],lesson),
  CONSTRAINT     FK_HomeWorks_Group   FOREIGN KEY([group])  REFERENCES Groups(group_id),
  CONSTRAINT     FK_HomeWorks_Shedule   FOREIGN KEY(lesson)   REFERENCES Shedule(lesson_id),
  [data]         VARBINARY(2000),
  [description]  NVARCHAR(255),
  CONSTRAINT     CK_Payload_HW   CHECK([description] IS NOT NULL OR [data] IS NOT NULL)
);

CREATE TABLE Exams
(
  teacher       INT,
  student       INT,
  discipline    SMALLINT,
  PRIMARY KEY(student,discipline, teacher),
  CONSTRAINT    FK_Exams_Teacher        FOREIGN KEY(teacher) REFERENCES Teachers(teacher_id),
  CONSTRAINT    FK_Exams_Student        FOREIGN KEY(student) REFERENCES Students(student_id),
  CONSTRAINT    FK_Exams_Discipline     FOREIGN KEY(discipline) REFERENCES Disciplines(discipline_id),
  grade         INT,
  CONSTRAINT    CK_Grade                CHECK(grade > 0 AND grade <= 12),
  completed     DATETIME2(0)
);

CREATE TABLE HWResults
(
  student        INT,
  lessone        BIGINT,
  [group]        INT,
  PRIMARY KEY(student,lessone,[group]),
  CONSTRAINT     FK_HWResults_HomeWorks  FOREIGN KEY([group],lessone) REFERENCES HomeWorks([group],lesson),
  CONSTRAINT     FK_HWResults_Student      FOREIGN KEY(student) REFERENCES Students(student_id),
  [description]  NVARCHAR(255),
  [data]         VARBINARY(2000),
  CONSTRAINT     CK_Payload_HWR   CHECK([description] IS NOT NULL OR [data] IS NOT NULL),
  grade          INT                     NULL,
  upload         DATETIME2(0)            NULL
);