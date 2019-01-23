import psycopg2
from flask_sqlalchemy import SQLAlchemy
from flask import Flask

app = Flask(__name__)

app.config['DEBUG']= True

app.config.update(               ## dictionary of arguments to pass through for config settings
    SECRET_KEY='Battlestar*84',
    SQLALCHEMY_DATABASE_URI='postgresql://postgres:Battlestar*84@localhost/PandaApp_Db',
    SQLALCHEMY_TRACK_MODIFICATIONS=False)

db = SQLAlchemy(app) ## create instance of SQLAlchemy class

##  Basic Panda Info (PandaID is a dependency for biometrics entry) ##
class Panda(db.Model):
    __tablename__ = 'Panda_tbl'
    PandaID = db.Column('PandaID', db.Integer, primary_key=True)
    PandaName = db.Column('Name', db.Unicode) ## not null
    PandaSex = db.Column('Sex', db.Unicode) ## not null
    DOB = db.Column('DOB', db.date) ## not null
    DODeath = db.Column('DODeath', db.Date)
    Provenance = db.Column('Provenance', db.Unicode)
    CaptureDate = db.Column('Capture_Date', db.Date)
    BirthLoc = db.Column('Birth_Location', db.Unicode)
    biometrics = db.relationship('Bio', backref='panda', lazy=True)

##  Mapping Python Biometrics to the Db ##
@app.route('/bio_entry')
class Bio(db.Model):
    __tablename__ = 'Bio_tbl'
    BioID = db.Column('BioID', db.Integer, primary_key=True)
    PandaID_fk = db.Column('PandaID_fk', db.Integer, db.ForeignKey('panda.PandaID'))
    BodyLength = db.Column('BodyLength', db.Integer)
    BodyHeight = db.Column('BodyHeight', db.Integer)
    BodyWeight = db.Column('BodyWeight', db.Integer)
    BioDate = db.Column('BioDate', db.date) ## MM/DD/YYYY
    BioTime = db.Column('BioTime', db.time)## HH:MM - 24 hour ideally

    def __init__(self, BioID, PandaID_fk, BodyLength, BodyHeight, BodyWeight, BioDate, BioTime): ## Is this correct?
        self.BioID = BioID
        self.PandaID_fk = PandaID_fk
        self.BodyLength = BodyLength
        self.BodyHeight = BodyHeight
        self.BodyWeight = BodyWeight
        self.BioDate = BioDate
        self.BioTime = BioTime


if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
