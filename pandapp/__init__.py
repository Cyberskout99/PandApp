from flask import Flask, request, render_template
from .config import Config
from .models import db,Bio

app = Flask(__name__)  ## by default, assumes name of root directory

#db.init_app(app)
app.config.from_object(Config)

@app.route('/') ## Landing Page
def index():
    return render_template('/main/index.html')

### Entry Routes - review delegation to Routes module ##

@app.route('/entry/bio_entry', methods=('GET', 'POST'))  ## Biometrics
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

    return render_template('Bio_Entry.html') ## add form validation

@app.route('/entry/lab_entry')
def lab_entry():
    return render_template('Labs_Entry.html') ## add form validation

@app.route('/entry/behav_entry')
def behav_entry():
    return render_template('Behav_Entry.html') ## add form validatiom 

@app.route('/entry/breed_entry')
def breed_entry():
    return render_template('BreedInf_Entry.html')  ## add form validation

@app.route('/entry/mating_entry')
def mating_entry():
    return render_template('Mating_Entry.html') ## add form validnation

## Update Routes ##

## Original db.create_all() call ##
if __name__ == '__main__':
    app.run(debug=True)

## Experiment 1: Stack OVerflow Q46540664 ##
## This did not work ##
#with app.app_context():
#    db.create_all()
