# Library imports
from flask import Flask

# local imports
from config import get_config, get_config_map

app = Flask(__name__)
app.config.from_object(get_config_map())

@app.route('/')
def hello_world():
    return 'Hello, World! Debug mode is ' + str(get_config('debug'))


app.run(
    host=get_config('hostname'),
    port=get_config('port')
)
