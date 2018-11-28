import os
import json

# Private to this file
# Obtain the runtime environment setting, or default to dev
def __get_environment():
    environment = os.getenv('FLASK_ENV')
    if environment is None:
        environment = 'dev'
    return environment

# Get all configs for the current environment
def get_config_map():
    environment = __get_environment()
    with open('config.json', 'r') as f:
        as_json = json.load(f)
    return as_json[environment]

# Load any config value in real time from config.json
def get_config(config_name):
    config_json = get_config_map()
    return config_json[config_name]
