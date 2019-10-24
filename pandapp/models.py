import psycopg2
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from .config import app

db = SQLAlchemy(app) ## create instance of SQLAlchemy class

## Added in to allow for "push" a context ##
#db.init_app(app) 
###  Basic Panda Info (PandaID is a dependency for biometrics entry) ##
class Panda(db.Model):
    __tablename__ = 'panda'
    PandaID = db.Column('PandaID', db.Integer, primary_key=True)
    PandaName = db.Column('Name', db.Text) ## not null
    PandaSex = db.Column('Sex', db.Text) ## not null
    DOB = db.Column('DOB', db.DateTime) ## not null
    DODeath = db.Column('DODeath', db.DateTime)
    Provenance = db.Column('Provenance', db.Text)
    CaptureDate = db.Column('Capture_Date', db.Date)
    BirthLoc = db.Column('Birth_Location', db.Text)
#   biometrics = db.relationship('Bio', backref='panda', lazy=True)

##  Data Collection Staff Info (StaffID is a dependency for biometrics entry) ##
class Staff(db.Model):
    __tablename__ = 'staff'
    StaffID = db.Column('StaffID', db.Integer, primary_key=True)
    StaffFirst = db.Column('StaffFirst', db.Text)
    StaffLast = db.Column('StaffLast', db.Text)
    Username = db.Column('Username', db.Text)
    Password = db.Column('Password', db.Text)
 ##   biometrics = db.relationship('Bio', backref='staff', lazy=True)

##  Define data for Flask/SQLAlchemy 'Bio' data object (class) ##
class Bio(db.Model):
    __tablename__ = 'biometrics'
    BioID = db.Column('BioID', db.Integer, primary_key=True)
    PandaID_fk = db.Column('PandaID_fk', db.Integer) ## FK relationship
    BodyLength = db.Column('BodyLength', db.Integer)
    BodyHeight = db.Column('BodyHeight', db.Integer)
    BodyWeight = db.Column('BodyWeight', db.Integer)
    BioDate = db.Column('BioDate', db.Integer) ## MM/DD/YYYY
    BioTime = db.Column('BioTime', db.Integer) ## HH:MM - 24 hour ideally
    StaffID_fk = db.Column('StaffID_fk', db.Integer)

    def __init__(self, BioID, pandaid, length, height, weight, biodate, biotime, staffid): ## Is this correct?
        self.BioID = BioID
        self.PandaID_fk = pandaid
        self.BodyLength = length
        self.BodyHeight = height
        self.BodyWeight = weight
        self.BioDate = biodate
        self.BioTime = biotime
        self.StaffID_fk = staffid
