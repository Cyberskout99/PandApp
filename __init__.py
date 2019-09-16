# import psycopg2
from flask import request, render_template
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
from models import Bio
from config import Config

app = Flask(__name__)  # by default, takes name of root directory
app.config.from_object(Config)

dummyStaff = {'StaffID': 1, 'StaffFirst': 'Jim', 'StaffLast': 'Jones', 'Username': 'UserID123', 'Password': 'TopSecret'}

#  Apply decorator to 'bio_entry()' function #


@app.route('/bio_entry', methods=('GET', 'POST'))
def bio_entry():
    if request.method == 'POST':
        db.PandaID = request.form['PandaID']
        db.Weight = request.form['Weight']
        db.Height = request.form['Height']
        db.Length = request.form['Length']
        db.BioDate = request.form['BioDate']
        db.BioTime = request.form['BioTime']
        db.StaffID = request.form['StaffID']
        db.BioID = request.form['BioID']

    return render_template('Bio_Entry.html') ## add validation for successful form submission prior to render template

# from pandapp import routes # doesn't seem to be working ? #
# Where does the "Class" come into play here?   Re-read tutorial.  Study (1) Classes, (2) Decorators
Bio.BioID = 10

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
