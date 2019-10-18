from flask import Flask
import os

app = Flask(__name__)  ## by default, assumes name of root directory

class Config(object):
    SECRET_KEY = os.environ.get('cupcake'),
    SQLALCHEMY_DATABASE_URI = 'postgresql+psycopg2://postgres:cupcake@localhost/panda_db',
    SQLALCHEMY_TRACK_MODIFICATIONS = False

def __get_environment():  ## sets default environment to DEV
    environment = os.getenv('FLASK_ENV')
    if environment is None:
        environment = 'dev'
    return environment
