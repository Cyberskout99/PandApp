import sqlite3
from pandas import read_sql_query
import pandasql
import pysqldf
import numpy
import time
import datetime

conn = sqlite3.connect('PDX Wildlife.db')
c = conn.cursor()

# put all these create tables in a function?
def create_table():
    c.execute(CREATE TABLE `Lab Test` (
  `CollectionDateTime` timestamp,
  `CollectionType` varchar(50),
  `SpecType` set,
  `Results` varchar(50),
  `Studbook_ID` int,
  `Common_Name` varchar(50),
  `Observer_ID` int,
  KEY `PK, FK` (`Studbook_ID`, `Common_Name`),
  KEY `FK` (`Observer_ID`)
);

CREATE TABLE `Reproductive` (
  `Studbook_ID` int,
  `Common_Name` varchar(50),
  `Observer_ID` int,
  KEY `PK, FK` (`Studbook_ID`, `Common_Name`),
  KEY `FK` (`Observer_ID`)
);

CREATE TABLE `Observers` (
  `Staff` int,
  `Interns` int,
  `Doctors` int,
  `Observer_ID` Type,
  PRIMARY KEY (`Observer_ID`),
  KEY `Key` (`Staff`, `Interns`, `Doctors`)
);

CREATE TABLE `Panda Master` (
  `Studbook_ID` int,
  `Common_Name` varchar(50),
  `DOB` date,
  `BirthLocation` varchar(50),
  `DOD` date,
  `AgeAtDeath` int,
  `Sex` Type,
  `SireStudbookID` int,
  `SireCommonName` varchar(50),
  `DamStudbookID` int,
  `DamCommonName` varchar(50),
  `Provenance (Location)` varchar(50),
  `CaptureDate` date,
  `Facility` varchar(50),
  `RearedByMother` Type,
  `InseminationType` Type,
  PRIMARY KEY (`Studbook_ID`, `Common_Name`)
);

CREATE TABLE `Behavioral` (
  `Studbook_ID` int,
  `Common_Name` varchar(50),
  `Observer_ID` int,
  KEY `PK, FK` (`Studbook_ID`, `Common_Name`),
  KEY `FK` (`Observer_ID`)
);

CREATE TABLE `Environmental` (
  `Studbook_ID` int,
  `Common_Name` varchar(50),
  `WeatherCondition` varchar(50),
  `AirQualityCode` int,
  `Temp_F` int,
  `Temp_C` int,
  `Humidity` int,
  `Observer_ID` int,
  KEY `PK, FK` (`Studbook_ID`, `Common_Name`),
  KEY `FK` (`Observer_ID`)
);

