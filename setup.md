# Setup

First off, thanks for contributing! This document outlines how to setup a local development environment as well as logging into the "dev" server.

## Local Environment Setup

This document uses the following open source technology, a simple search will show you how to install this on your system:

1. Python 3.x.x
2. SQLLite (latest version)
3. Git

### Setting up the codebase

Now that you have the prerequiste programs installed, download the codebase from GitHub.  Open up a command line window and enter the following to download:

`cd "path/to/your/preferred/directory"`

`git clone https://github.com/Cyberskout99/CodeAndLearn.git`

You'll now have a folder called CodeAndLearn that contains the entirety of the project.

### Setting up Tools

#### Python Tooling

If you do not already have a preferred Python code editor, the PyCharm IDE is a fantastic option.  Download it and open the CodeAndLearn directory, it will help you write Python considerably over time.

#### Library Dependencies

Using Python's PIP package manager, install the project's libraries with the following commands:

```pip install flask```

(On some machines, ```pip``` is called ```pip3```)

TODO: Put instructions for how to run a Flask/Django app locally here

#### Running the Project

First make sure you've installed all the Python requirements above, then navigate to the project in your command line and enter:

```python server.py```

(This might be ```python3 server.py``` on some machines)

After you're up and running, go to [http://localhost:8080](http://localhost:8080) to see the homepage!

#### SQL Tooling

(TODO: I've never used SQL Lite, but you'll need to be running it whenever you start your web app)

## Dev Remote Environment Setup

This will give you access to the current server actually running the web app.

Server Info:

`Username: root`

`IP Address (Host): 165.227.30.142`

`Private Key password: sasspass`

If you've physically attended Code n Learn, you have a private key to log into and control the dev server.

### Mac Users

Mac command's line (or terminal) has SSH support built-in that allows you to remotely control the dev server by command line.

`ssh -i path/to/private/key/cnl root@165.227.30.142`

When prompted for a password, enter `sasspass`

### Windows Users

MobaXTerm is a great Windows utility for establishing SSH connections to a remote server.  After installing:

1. Right click on the left panel and select "New Session"
2. Select the "SSH" tab at the very top
3. Use the IP address and username listed above
4. Click "Advanced" and point to your private key file "cnl"
5. Save and double click, you should connect to a remote terminal

What now?

Check out the [Dev Workflow](workflow.md) document for how contributing works.