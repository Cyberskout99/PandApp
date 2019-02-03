import psycopg2
from flask import request, render_template
from flask_sqlalchemy import SQLAlchemy
from flask import Flask

app = Flask(__name__) # by default, takes name of root directory

app.config['DEBUG']= True

# dictionary of arguments to pass through for config settings
app.config.update(
    SECRET_KEY='Battlestar*84',
    SQLALCHEMY_DATABASE_URI='postgresql://postgres:Battlestar*84@localhost/PandaApp_Db',
    SQLALCHEMY_TRACK_MODIFICATIONS=False)

# create instance of SQLAlchemy class
db = SQLAlchemy(app)

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

    return render_template('Bio_Entry.html')


# from pandapp import routes # doesn't seem to be working ? #

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
