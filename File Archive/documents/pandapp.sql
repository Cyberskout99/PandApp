/* Primary Panda Table (AKA: studbook log) */

CREATE TABLE Panda_tbl (
PandaID int primary key,
Name VARCHAR (25),
Sex VARCHAR (5),
DOB date NOT NULL,
DeathDate date,
SireCommon varchar (25),
SirePandaID int ref PandaID,
DamCommon varchar (25),
DamPandaID int ref PandaID,
Provenance varchar (25), /* Limit GUI to list: Captive, Wild */
CaptureDate date,
BirthLocate varchar (40), 
MotherReared boolean /* PandaID exists In PandaLitRear_tbl */
)
;

/* BIOMETRICS */
CREATE TABLE PandaBio_tbl (
PandaBio_ID int primary key,
PandaID_fk int foreign key references Panda_tbl (PandaID),
BodyLength int,
BodyHeight int,
BodyWeight int,
BioDate date)
;


/* BREEDING */
CREATE TABLE PandaBreed_tbl (
BreedingID int primary key, /*all have breeding date*/
PandaID_fk int foreign key references Panda_tbl (PandaID),
MatingID_fk int foreign key references Mating_tbl (MatingID),
BreedingDate varchar (1), /* Reference to MatingDate table */
BreedDateEst boolean, /*True/False*/
BreedNatSuc varchar (1), /*Yes, No, Unknown */
ParityDate date) /*Column AB*/
;

/* MATING */
CREATE TABLE Mating_tbl (
MatingID int primary key,
MatingDate date,
MatingTime time,
PandaFemID int foreign key references Panda_tbl (PandaID), /* Limit GUI input to Female Sex Only */
PandaFemName varchar (25), /* References Panda_tbl (Name) */
PandaMaleID int foreign key references Panda_tbl (PandaID), /* Limit GUI input to Male Sex Only */
PandaFemName varchar (25), /* References Panda_tbl (Name) */
MatingType varchar (25), /* Limit GUI input to list:  AI, SemenOnly, Electro, Natural  */
MatingIntTime time, /* HH:MM:SS input */
MatingPeopleN int,
MatingLoc varchar (10), /* Limit GUI input to list:  Inside, Outside */
MatingVideo boolean,
MatingSuccess boolean,
MatingHomeMate varchar, /* Limit GUI input to list: Male, Female */
MatingHomeLoc varchar (10) foreign key references Locate_tbl (PenBFX),
BreedingID_fk int foreign key references BreedingID_tbl (BreedingID)
)
;

/* LITTER PRODUCED */
CREATE TABLE PandaLitter_tbl (
LitterID int primary key,
LitterSize int,
LitterSire varchar (3), /* yes/no/unk/S */
LitterDate date,
BreedingID_fk foreign key references BreedingID_tbl (BreedingID))
;

/* LITTER INFANTS */
CREATE TABLE PandaLitInf_tbl (
LitInfID int primary key,
LitterID_fk int foreign key references PandaLitter_tbl (LitterID),
LitInfDOB date NOT NULL, /* reconcile with Panda_tbl log */
LitInfCommName varchar (25),
LitInfSex varchar (1), /*M, F, U - reconcile with Panda_tbl log */
PandaID_fk int foreign key references Panda_tbl (PandaID)) /* reconcile with Panda_tbl log */
;

/* INFANTS REARED */
CREATE TABLE PandaLitRear_tbl (
LitRearID int unique primary key,
PandaID_fk int NOT NULL foreign key references Panda_tbl (PandaID), /* must already be entered in Panda_tbl log */
LitRear11 varchar (4), /*M/H/Unk/Supp*/
LitRearDate date)
;

/* BEHAVIOR TABLE */
CREATE TABLE Behav_tbl (
BehavID int primary key,
BehavDate date,
BehavWeather varchar (25),
BehavAirQ int,
BehavTempPhone int, /* Farenheit - normalize at GUI? */
BehavTempTherm numeric, /*Celcius - normalize at GUI? */
BehavType VARCHAR(20), /* Limit GUI input to list: Premate, PreMvCtl, FemCtl, PostMvCtl, PreMvExp, MMCExp, PostMvExp, Mate */
BehavStart time, /* */
BehavEnd time,
FocalPandaID int NOT NULL foreign key references Panda_tbl (PandaID),
FocalPen varchar (5) foreign key references Locate_tbl,
N1PandaID int foreign key references Panda_tbl (PandaID),
N1Pen varchar (5) foreign key references Locate_tbl (PenBFX),
N2PandaID int foreign key references Panda_tbl (PandaID),
N2Pen varchar (5) foreign key references Locate_tbl (PenBFX),
Notes varchar (50),
StaffID_fk int foreign key references Staff_tbl (StaffID))
; 

/* BEHAVIOR MMC TABLE (iPad file, 30 minute slots) - may be difficult to automate integration into app */
/* 125 Behaviors to summarize. Suggested: DISTINCT(Behavior), COUNT(Behavior) FROM SourceFile WHERE Event_Type IN (StateStart, Point) */
CREATE TABLE BehavMMC_tbl (
BehavMMCID int primary key,
MMCactor int foreign key references Panda_tbl (PandaID),
MMCrecip int foreign key references Panda_tbl (PandaID),
MMC1 int,
...
MMC125 int),
StaffID_fk int foreign key references Staff_tbl (StaffID))
;

/* LOCATION TABLE */
CREATE TABLE Locate_tbl (
PenBFX varchar (5),
LocatArea varchar (25),
LocatDate date,
PandaID_fk int foreign key references Panda_tbl(PandaID))
;

/* LAB TABLE */
CREATE TABLE Labs_tbl (
LabID int primary key,
PandaID_fk int foreign key references Panda_tbl (PandaID),
LabDateStamp date,
LabTimeStamp time,
LabDateCollect date,
LabTimeCollect time,
StaffEntry int foreign key references Staff_tbl (StaffID), /* ID of Staff doing the Data Entry */
StaffCollect int foreign key references Staff_tbl (StaffID)) /* ID of Staff that did the sample Collection */
;

/* STOOL LABS (for DNA analysis - no chemistries ) */
CREATE TABLE Stools_tbl (
StoolID int primary key,
LabID_fk int foreign key references Labs_tbl (LabID),
StoolTime varchar (10), /* Limit GUI Input to List : Baseline, Breeding */
StoolLoc varchar (25), /* Obtain list of relevant locations - Default: Bifengxia */
StoolFzStart date,
StoolFzEnd date,
StoolTubesNo int,
StoolCheckDate date,
StoolCheckNotes varchar (100))
;

/* LEAD LABS */
CREATE TABLE Lead_tbl (
StoolID int primary key,
LabID_fk int foreign key references Labs_tbl (LabID),
LeadRefrig boolean, /* Check in GUI to indicate specimen refrigerated */
LeadFrozen boolean, /* Check in GUI to indicate specimen frozen */
LeadBelowLimit boolean NOT NULL, /* Check in GUI to indicate result below detectable limit */
LeadResult numeric,
LeadComments varchar (50))
;

/* ESTROUS LABS */
CREATE TABLE Estrous_tbl (
EstrID int primary key,
LabID_fk int foreign key references Labs_tbl (LabID),
EstrMonitor boolean, /* Check in GUI to indicate "Monitoring", suppress result field */
EstrPeak boolean, /* Check in GUI to indicate "Peak", suppress result field */
EstrLevel numeric)
;

CREATE TABLE Staff_tbl (
StaffID int primary key
StaffFirst varchar (45),
StaffLast varchar (45),
-- AB: Adding login fields
Username varchar(25) unique not null,
Password text not null 
)
;
-- AB: Removed StaffObs, StaffLab, StaffKeeper, StaffView to use role tables instead.
    -- StaffObs boolean, /* Staff allowed to make behavior observations */
    -- StaffLab boolean, /* Staff allowed to record labs */
    -- StaffKeeper boolean, /* Staff allowed to record birth/infant/rear observations */
    -- StaffView boolean) /* Staff allowed ViewOnly access)

/* Database Roles */
CREATE TABLE Roles_db (
RoleDbID int primary key,
Role varchar(30),
Description varchar(30)
)
;

/* Application Roles */

CREATE TABLE Roles_app (
RoleAppID int primary key,
Role varchar(30),
Description varchar(30)
)
;

/* Staff Database Role Assignments */
CREATE TABLE RoleDB_Assignments (
StaffRoleID int primary key,
StaffID_fk int foreign key references Staff_tbl (StaffID),
RoleDbId_fk int foreign key references Roles_db (RoleDbID)
)
;

/* Staff App Role Assignments */
CREATE TABLE RoleApp_Assignments (
StaffRoleID int primary key,
StaffID_fk int foreign key references Staff_tbl (StaffID),
RoleAppID_fk int foreign key references Roles_app (RoleAppID)
)
;


