import psycopg2
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort  ## this was in the Flaskr tutorial

## from pandapp.auth import login_required
## from pandapp.db import get_db

bp = Blueprint('pandapp', __name__)


## Define the landing page ("index") for the blog #
@bp.route('/')
def index():
#    db = get_db()
#    staff = db.execute(
#        'SELECT staff_id, first, last'
#        ' FROM AppUsers AU JOIN DbUsers DU ON AU.app_id = DU.app_id' ## Display field for Staff ID? ##
#		 ' WHERE ApplUsers.UserID = g.(UserID);
#    ).fetchall()
    return render_template('/index.html')  

## Define a call to create a new "entry" for the each Biometrics record ##
@bp.route('/bio_entry', methods=('GET', 'POST'))
@login_required  #this lives in the auth.py blueprint #
def bio_entry():
    if request.method == 'POST':
        PandaID = request.form['PandaID']
        weight = request.form['Weight']
        height = request.form['Height']
        length = request.form['Length']
        BioDate = request.form['BioDate']
        BioTime = request.form['BioTime']
        error = None

        if not title:
            error = 'PandaID is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO bio_tbl (PandaID, weight, height, length, BioDate, BioTime, StaffID)'
                ' VALUES (?, ?, ?, ?, ?, ?)',
                (PandaID, weight, height, length,BioDate, BioTime, g.user['id'])
            )
            db.commit()
            return redirect(url_for('pandapp.index'))

    return render_template('pandapp/bio_entry.html')