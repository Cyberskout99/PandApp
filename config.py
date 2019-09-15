import os


class Config(object):

    DEBUG = True,
    SECRET_KEY = os.environ.get('***DbPassword***'),
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:***DbPassword***@localhost/PandaApp_Db',
    SQLALCHEMY_TRACK_MODIFICATIONS = False


