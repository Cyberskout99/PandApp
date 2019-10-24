from flask import render_template, request
from .config import app
from .models import db


app.config.from_pyfile('config.py')

@app.route('/') ## Landing Page
def index():
    return render_template('main/index.html')

### Entry Routes - review delegation to Routes module ##

@app.route('/bio_entry', methods=('GET', 'POST'))  ## Biometrics
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
    return render_template('entry/bio_entry.html') ## add form validation

@app.route('/lab_entry', methods=('GET', 'POST'))
def lab_entry():
    return render_template('entry/lab_entry.html') ## add form validation

@app.route('/behav_entry')
def behav_entry():
    return render_template('entry/behav_entry.html') ## add form validatiom 

@app.route('/breed_entry')
def breed_entry():
    return render_template('entry/breed_entry.html')  ## add form validation

@app.route('/mating_entry')
def mating_entry():
    return render_template('entry/mating_entry.html') ## add form validnation
