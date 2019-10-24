from flask import Flask, request, render_template
from .config import app
from .models import db,Bio
from .routes import bio_entry, lab_entry, behav_entry, breed_entry, mating_entry
import os

app.static_folder='static'
app.template_folder='templates'

db.create_all()
## Original db.create_all() call ##
if __name__ == '__main__':
    app.run(debug=True)
