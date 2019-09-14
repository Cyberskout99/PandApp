DROP TABLE Inf_tbl CASCADE;
CREATE TABLE  Inf_tbl (
	InfID	serial PRIMARY KEY,
	LitterID_fk	int,
	InfDOB	date,
	InfName	varchar(25),
	NumBirth	INTEGER,
	PandaID_fk	INTEGER
	--FOREIGN KEY(LitterID_fk) REFERENCES Litter_tbl(LitterID),
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID),
);
-- Copying in from CSV template
-- The Copy function will write in the PK (serial) variable automatically
COPY Inf_tbl(InfID,LitterID_fk,NumBirth,InfDOB,PandaID_fk,InfName)
FROM './X/Inf_tbl.csv' DELIMITER ',' CSV HEADER;


DROP TABLE Stools_tbl CASCADE;
CREATE TABLE  Stools_tbl (
	StoolID	serial PRIMARY KEY,
	LabID_fk	int,
	StoolTime	varchar(10),
	StoolLoc	varchar(25),
	FzStartDate	date,
	FzEndDate	date,
	TubesNo	int,
	CheckDate	date,
	CheckNotes	varchar(100)
	--FOREIGN KEY(LabID_fk) REFERENCES Labs_tbl(LabID)
);
COPY Stools_tbl(StoolID,LabID_fk,StoolTime,StoolLoc,FzStartDate,FzEndDate,TubesNo,CheckDate,CheckNotes)
FROM './X/Stools_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE RoleApp_Assignments CASCADE;
CREATE TABLE  RoleApp_Assignments (
	StaffRoleID	int,
	StaffID_fk	int,
	RoleAppID_fk	int,
	--FOREIGN KEY(StaffID_fk) REFERENCES Staff_tbl(StaffID),
	PRIMARY KEY(StaffRoleID)
	--FOREIGN KEY(RoleAppID_fk) REFERENCES Roles_app(RoleAppID)
);
-- COPY IN ANY CSV THINGS HERE

DROP TABLE RoleDB_Assignments CASCADE;
CREATE TABLE  RoleDB_Assignments (
	StaffRoleID	int,
	StaffID_fk	int,
	RoleDbId_fk	int,
	--FOREIGN KEY(StaffID_fk) REFERENCES Staff_tbl(StaffID),
	PRIMARY KEY(StaffRoleID)
	--FOREIGN KEY(RoleDbId_fk) REFERENCES Roles_db(RoleDbID)
);
-- COPY IN ANY CSV THINGS HERE

DROP TABLE Roles_app CASCADE;
CREATE TABLE  Roles_app (
	RoleAppID	int,
	Role	varchar(30),
	Description	varchar(45),
	PRIMARY KEY(RoleAppID)
);
-- COPY IN ANY CSV THINGS HERE

DROP TABLE Roles_DB CASCADE;
CREATE TABLE  Roles_DB (
	RoleDbID	int,
	Role	varchar(30),
	Description	varchar(30),
	PRIMARY KEY(RoleDbID)
);
-- COPY IN ANY CSV THINGS HERE

DROP TABLE Staff_tbl CASCADE;
CREATE TABLE  Staff_tbl (
	StaffID	int,
	StaffFirst	varchar(45),
	StaffLast	varchar(45),
	Username	varchar(25) NOT NULL UNIQUE,
	Password	text NOT NULL,
	PRIMARY KEY(StaffID)
);
-- COPY IN ANY CSV THINGS HERE

DROP TABLE Estrous_tbl CASCADE;
CREATE TABLE  Estrous_tbl (
	EstrID	serial PRIMARY KEY,
	LabID_fk	int,
	EstrMonitor	boolean,
	EstrPeak	boolean,
	EstrLevel	numeric
	--FOREIGN KEY(LabID_fk) REFERENCES Labs_tbl(LabID)
);
COPY Estrous_tbl(EstrID,LabID_fk,EstrMonitor,EstrPeak,EstrLevel)
FROM './X/Estrous_tbl.csv' DELIMITER ',' CSV HEADER;


DROP TABLE Lead_tbl CASCADE;
CREATE TABLE  Lead_tbl (
	LeadID	int,
	LabID_fk	int,
	LeadRefrig	boolean,
	LeadFrozen	boolean,
	LeadBelowLimit	boolean NOT NULL,
	LeadResult	numeric,
	LeadComments	varchar(50),
	PRIMARY KEY(LeadID)
	--FOREIGN KEY(LabID_fk) REFERENCES Labs_tbl(LabID)
);
--COPY Lead_tbl(LeadID,LabID_fk,LeadRefrig,LeadFrozen,LeadBelowLimit,LeadResult,LeadComments)
--FROM './X/Lead_tbl.csv' DELIMITER ',' CSV HEADER;
--LEAVE BLANK FOR NOW

DROP TABLE Labs_tbl CASCADE;
CREATE TABLE  Labs_tbl (
	LabsID	int,
	PandaID_fk	int,
	LabEntryID	int,
	LabDate	date,
	LabTime	time,
	LabCollectID	int,
	CollectDate	date,
	CollectTime	time,
	Processed	boolean,
	PRIMARY KEY(LabsID)
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(LabCollectID) REFERENCES Staff_tbl(StaffID)
);
COPY Labs_tbl(LabsID,PandaID_fk,LabEntryID,LabDate,LabTime,LabCollectID,CollectDate,CollectTime)
FROM './X/Labs_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Locate_tbl CASCADE;
CREATE TABLE  Locate_tbl (
	PenBFX	varchar(5),
	Area	varchar(25),
	LocateDate	date,
	PandaID_fk	int
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID)
);
COPY Locate_tbl(PenBFX,Area,LocateDate,PandaID_fk)
FROM './X/Locate_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Behav_tbl CASCADE;
CREATE TABLE  Behav_tbl (
	BehavID	serial PRIMARY KEY,
	BehavDate	date,
	BehavWeather	varchar(25),
	BehavAirQ	varchar(10),
	TempPhone	int,
	TempTherm	numeric,
	BehavType_fk	VARCHAR(20),
	BehavCSV varchar (25),
	TimeStart	time,
	TimeEnd	time,
	FocalPandaID	int NOT NULL,
	FocalPandaPen	varchar(5),
	Panda1ID	int,
	Panda1Pen	varchar(5),
	Panda2ID	int,
	Panda2Pen	varchar(5),
	Notes	varchar(50),
	StaffID_fk	int
	--FOREIGN KEY(FocalPen) REFERENCES Locate_tbl,
	--FOREIGN KEY(FocalPandaID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(N2Pen) REFERENCES Locate_tbl(PenBFX),
	--FOREIGN KEY(N1PandaID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(N1Pen) REFERENCES Locate_tbl(PenBFX),
	--FOREIGN KEY(N2PandaID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(StaffID_fk) REFERENCES Staff_tbl(StaffID)
);
COPY Behav_tbl(BehavID,BehavDate,BehavWeather,BehavAirQ,TempPhone,TempTherm,
		BehavType_fk,BehavCSV,TimeStart,TimeEnd,
		FocalPandaID,FocalPandaPen,Panda1ID,Panda1Pen,Panda2ID,Panda2Pen,
		Notes,StaffID_fk)
FROM './X/Behav_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Rear_tbl CASCADE;
CREATE TABLE  Rear_tbl (
	RearID	serial PRIMARY KEY,
	NewPandaID_fk	int NOT NULL,
	RearDate	date,
	RearNotes	varchar(100)
	--FOREIGN KEY(NewPandaID_fk) REFERENCES Panda_tbl(PandaID)
);
COPY Rear_tbl(RearID,NewPandaID_fk,RearDate,RearNotes)
FROM './X/Rear_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Litter_tbl CASCADE;
CREATE TABLE  Litter_tbl (
	LitterID	serial PRIMARY KEY,
	LitterSize	int,
	LitterDate	date,
	BreedingID_fk	TEXT
	--FOREIGN KEY(BreedingID_fk) REFERENCES BreedingID_tbl(BreedingID)
);
COPY Litter_tbl(LitterID,LitterSize,LitterDate,BreedingID_fk)
FROM './X/Litter_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Mating_tbl CASCADE;
CREATE TABLE  Mating_tbl (
	MatingID int PRIMARY KEY,
	MateDate	date,
	MateTime	time,
	DamPandaID	int,
	DamPandaName	varchar(25),
	SirePandaID	int,
	SirePandaName	varchar(25),
	MatingType	varchar(25),
	IntroTime	time,
	People	int,
	MatingLoc	varchar(10),
	Video	boolean,
	ReproHx	boolean,
	MatingHomeMate	varchar,
	MatingHomeLoc	varchar(10),
	BreedingID_fk	int
	--FOREIGN KEY(BreedingID_fk) REFERENCES BreedingID_tbl(BreedingID),
	--FOREIGN KEY(PandaFemID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(PandaMaleID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(MatingHomeLoc) REFERENCES Locate_tbl(PenBFX)
);
COPY Mating_tbl(MatingID,MateDate,MateTime,
		DamPandaID,SirePandaID,MatingType,IntroTime,
		ReproHx,Video,People)
FROM './X/Mating_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Breed_tbl CASCADE;
CREATE TABLE  Breed_tbl (
	BreedingID	int,
	MatingID_fk	int,
	BreedDate	date,
	BreedDateEst	boolean,
	PRIMARY KEY(BreedingID)
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(MatingID_fk) REFERENCES Mating_tbl(MatingID)
);
COPY Breed_tbl(BreedingID,MatingID_fk,BreedDate,BreedDateEst)
FROM './X/Breed_tbl.csv' DELIMITER ',' CSV HEADER;


DROP TABLE Bio_tbl CASCADE;
CREATE TABLE  Bio_tbl (
	BioID	serial PRIMARY KEY,
	PandaID_fk	int,
	Length	int,
	Height	int,
	Weight	numeric,
	BirthDate date,
	StaffID_fk int
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID)
	--FOREIGN KEY(StaffID_fk) REFERENCES Staff_tbl(StaffID)
);
COPY Bio_tbl(BioID,PandaID_fk,Length, Height, Weight, BirthDate)
FROM './X/Bio_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Hx_tbl CASCADE;
CREATE TABLE  Hx_tbl (
	HxID	int,
	PandaID_fk	INT,
	RearedHx	varchar(3),
	SireCommonHx	varchar(25),
	SirePandaIDHx	varchar(20),
	DamCommonHx	varchar(25),
	DamPandaIDHx	varchar(20),
	AgeDeathHx	numeric
	--FOREIGN KEY(PandaID_fk) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(SirePandaID) REFERENCES Panda_tbl(PandaID),
	--FOREIGN KEY(DamPandaID) REFERENCES Panda_tbl(PandaID)
);
COPY Hx_tbl(HxID,PandaID_fk,RearedHx,SireCommonHx,SirePandaIDHx,DamCommonHx,DamPandaIDHx,AgeDeathHx)
FROM './X/Hx_tbl.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Panda_tbl CASCADE;
CREATE TABLE  Panda_tbl (
	PandaID	serial PRIMARY KEY,
	Name	VARCHAR(25),
	Sex	VARCHAR(5),
	DOB	date NOT NULL,
	DODeath	date,
	Provenance	varchar(25),
	CaptureDate	date,
	BirthLocate	varchar(40)
);
COPY Panda_tbl(PandaID,Name,Sex,DOB,DODeath,Provenance,CaptureDate,BirthLocate)
FROM './X/Panda_tbl.csv' DELIMITER ',' CSV HEADER;

--Populate the roles_db table
INSERT INTO Roles_db (Role, Description)
VALUES
('ReadOnly', 'Can read, but not write to the db'),
('ReadWrite', 'Can read and write to the db')
;

--Populate the roles_app table
INSERT INTO Roles_app (Role, Description)
VALUES
('Researcher', 'All access'),
('Intern', 'labs and behaviors'),
('Keeper','birth / infant / rearing'),
('Lab', 'labs'),
('External Researcher', 'Read Only')
;

--Populate the Staff Table with placeholder data for testing only
INSERT INTO Staff_tbl (StaffFirst, StaffLast, Username, Password)
VALUES
('Much','Access','CanWrite', '1234'),
('Less','Access','CanRead', '1234')
;

--Populate the DB Role Assignments Table with placeholder data for testing only
INSERT INTO RoleApp_Assignments (StaffID_fk, RoleAppId)
VALUES
(1,1),
(2,2)
;

--Populate the DB Role Assignments Table with placeholder data for testing only
INSERT INTO RoleApp_Assignments (StaffID_fk, RoleAppId)
VALUES
(1,1),
(2,4)
;

SELECT * FROM panda_tbl;
