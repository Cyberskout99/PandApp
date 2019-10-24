from config import app,Config


app.config.from_object(Config)

@app.route('/') ## Landing Page
def index():
    return render_template('index.html')

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

    return render_template('Bio_Entry.html') ## add form validation

@app.route('/lab_entry')
def lab_entry():
    return render_template('Labs_Entry.html') ## add form validation

@app.route('/behav_entry')
def behav_entry():
    return render_template('Behav_Entry.html') ## add form validatiom 

@app.route('/breed_entry')
def breed_entry():
    return render_template('BreedInf_Entry.html')  ## add form validation

@app.route('/mating_entry')
def mating_entry():
    return render_template('Mating_Entry.html') ## add form validnation


