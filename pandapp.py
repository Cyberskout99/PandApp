import psycopg2
from flask_sqlalchemy import SQLAlchemy
from flask import Flask

pandapp = Flask(__name__)

pandapp.config['DEBUG']= True

pandapp.config.update(               ## dictionary of arguments to pass through for config settings
    SECRET_KEY='Battlestar*84',
    SQLALCHEMY_DATABASE_URI='postgresql://postgres:Battlestar*84@localhost/PandaApp_Db',
    SQLALCHEMY_TRACK_MODIFICATIONS=False)

db = SQLAlchemy(pandapp) ## create instance of SQLAlchemy class

##  Basic Panda Info (PandaID is a dependency for biometrics entry) ##
class Panda(db.Model):
    __tablename__ = 'Panda_tbl'
    PandaID = db.Column('PandaID', db.Integer, primary_key=True)
    PandaName = db.Column('Name', db.Unicode) ## not null
    PandaSex = db.Column('Sex', db.Unicode) ## not null
    DOB = db.Column('DOB', db.DateTime) ## not null
    DODeath = db.Column('DODeath', db.DateTime)
    Provenance = db.Column('Provenance', db.Unicode)
    CaptureDate = db.Column('Capture_Date', db.Date)
    BirthLoc = db.Column('Birth_Location', db.Unicode)
    biometrics = db.relationship('Bio', backref='panda', lazy=True)

##  Data Collection Staff Info (StaffID is a dependency for biometrics entry) ##
class Staff(db.Model):
    __tablename__ = 'Staff_tbl'
    StaffID = db.Column('StaffID', db.Integer, primary_key=True)
    StaffFirst = db.Column('StaffFirst', db.Unicode)
    StaffLast = db.Column('StaffLast', db.Unicode)
    Username = db.Column('Username', db.Unicode)
    Password = db.Column('Password', db.Unicode)
    biometrics = db.relationship('Bio', backref='staff', lazy=True)


##  Define a "bio_entry" API (point) for the app ##
@pandapp.route('/bio_entry', methods=('GET', 'POST'))

##  Define data for Flask/SQLAlchemy 'Bio' data object (class) ##
class Bio(db.Model):
    __tablename__ = 'Bio_tbl'
    BioID = db.Column('BioID', db.Integer, primary_key=True)
    PandaID_fk = db.Column('PandaID_fk', db.Integer) ## FK relationship
    BodyLength = db.Column('BodyLength', db.Integer)
    BodyHeight = db.Column('BodyHeight', db.Integer)
    BodyWeight = db.Column('BodyWeight', db.Integer)
    BioDate = db.Column('BioDate', db.DateTime) ## MM/DD/YYYY
    BioTime = db.Column('BioTime', db.DateTime) ## HH:MM - 24 hour ideally
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

##  Define request of form data for 'bio_entry()' function ##
def bio_entry():
    if request.method == 'POST':
        pandaid = request.form['PandaID']
        weight = request.form['Weight']
        height = request.form['Height']
        length = request.form['Length']
        biodate = request.form['BioDate']
        biotime = request.form['BioTime']
        staffid = request.form['StaffID']
        error = None

        if not title:
            error = 'PandaID is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO bio_tbl (PandaID_fk, BodyWeight, BodyHeight, BodyLength, BioDate, BioTime, StaffID_fk)'
                'VALUES (?, ?, ?, ?, ?, ?, ?)',
                (pandaid, weight, height, length,biodate, biotime, staffid)
            )
            db.commit()
            return redirect(url_for('pandapp.index'))

    return render_template('pandapp/Template/Bio_Entry.html')

if __name__ == '__main__':
    db.create_all()
    pandapp.run(debug=True)