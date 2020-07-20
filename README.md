# Challenge of building a docker-compose

Today, i waked up with a great idea: **Learn how to build a docker-compose from scratch**.

Actually, on my linux machine, i don't have any development environment prepared to run something, because i've thinking about a big goal, that is run everything on docker. Yeap, i don't even wanna install any package manager. I don't have experience working with python, but i wanna use it to build my first environment.

If you have no idea what docker is, i recommend [watch this video](https://www.youtube.com/watch?v=pGYAg7TMmp0) [and this one](https://www.youtube.com/watch?v=YFl2mCHdv24) that will give an overview of how docker works.

### What's docker compose?
In short, docker-compose works as a manager of containers. Let's supose that you are creating a web app where you are going to split it in 3 differents containers (front-end, api, database). This way, you may create a dockerfile for each environment individually.

### What's our challenge?
We're going to create a python api using flask. I'm not used to develop in python, i just study some features of [on my github](https://github.com/alissonzampietro/beginning-python).

### Beginning
In this section i'm going to explain the structure, and our python application associated files.

Let's create our directory structure:

```
 - api/
    - requirements.txt
    - app.py
    - Dockerfile
 - docker-compose.yml
```

The file *app/requirements.txt* represents the list of external libraries that is going to be used, in our case we only need the flask library:

```
flask
```

I don't want to dig in details about our *app/app.py* implementation for now, for that, i'm just creating a basic endpoint and you can see some details in the code's comments:

```python
from flask import Flask, jsonify
app = Flask(__name__)

#we define the route /
@app.route('/')
def welcome():
    # return a json
    return jsonify({'status': 'api working'})

if __name__ == '__main__':
    #define the localhost ip and the port that is going to be used
    # in some future article, we are going to use an env variable instead a hardcoded port 
    app.run(host='0.0.0.0', port='5000')
```

### Dockerfile

Let's see the Dockerfile as a recipe, where we give some instructions to the cooker, 

```Dockerfile
FROM python:3.6
RUN mkdir /usr/src/app/
COPY . /usr/src/app/
WORKDIR /usr/src/app/
EXPOSE 5000
RUN pip install requirements.txt
CMD ["python", "app.py"]
```

Let's check each line:

```python
FROM python:3.6
``` 
We set the image that we wanna use, in our case lets
use the python in version 3.6. If the image is not listed in your computer (open the terminal and type *docker images*), it's going to search and download on [Docker Hub](https://http://hub.docker.com/link).

```python
RUN mkdir /usr/src/app/
``` 
*Run* is used to run operations inside the container, for sample, if you want to install any program additional, you just use the command *RUN apt-get install whatever -y*. In this case, we're creating the folder where our application will be.
