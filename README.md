# Using docker-compose to build a simple flask api

Today, i waked up with a great idea: **Learn how to build a docker-compose from scratch**.

Actually, on my linux machine, i don't have any development environment prepared to run something, because i've thinking about a big goal, that is run everything on docker. Yeap, i don't even wanna install any package manager. I don't have experience working with python, but i wanna use it to build my first environment.

If you have no idea what docker is, i recommend [watch this video](https://www.youtube.com/watch?v=pGYAg7TMmp0) [and this one](https://www.youtube.com/watch?v=YFl2mCHdv24) that will give an overview of how docker works.

For installing the Docker [follow the instructions](https://docs.docker.com/engine/install/ubuntu/) and [this one to install docker-compose](https://docs.docker.com/compose/install/)

### What's docker compose?
In short, docker-compose works as a manager of docker containers. Let's supose that you are creating a web app where you are going to split it in 3 differents containers (front-end, api, database). This way, you may create a dockerfile for each environment individually.

### What's our challenge?
We're going to create a python api using flask. I'm not used to develop in python, i just study some features of [on my github](https://github.com/alissonzampietro/beginning-python).

### Hands-on
In this section i'm going to explain the structure, and our python application associated files.

Let's create our directory structure:

```
 - api/
    - requirements.txt
    - app.py
    - Dockerfile
 - docker-compose.yml
```

The file *api-nasa/requirements.txt* represents the list of external libraries that is going to be used, in our case we only need the flask library:

```
flask
```

I don't want to dig in details about our *api-nasa/app.py* implementation for now, for that, i'm just creating a basic endpoint and you can see some details in the code's comments:

```python
import os
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
    app.run(host='0.0.0.0', port=os.getenv('PORT'))
```
### Dockerhub
It's an image's repository, where you can register your own image. Let's say that you want to Download a image from Node JS, you only need to run the following command: __*docker pull node*__. And after, to check if image is there only run __*docker images*__.

### Dockerfile

Let's see the Dockerfile as a recipe, where from that, it's going to be built the os image.

```Dockerfile
FROM python:3.6
RUN mkdir /usr/src/app/
COPY . /usr/src/app/
WORKDIR /usr/src/app/
EXPOSE 5000
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```
Let's check each line:

```python
FROM python:3.6
``` 
We set the image that we wanna use, in our case lets
use the python in version 3.6. If the image is not downloaded in your computer (open the terminal and type *docker images*), it's going to search and download on [DockerHub](https://http://hub.docker.com/link). This part is really interesting, because this dockerfile, won't generate a container, but an image, and you can upload to docker hub to use in the future.

```python
RUN mkdir /usr/src/app/
``` 
*Run* is used to run operations inside the container, for sample, if you want to install any additional program, you just use the command *RUN apt-get install whatever -y*. In this case, we're creating the folder where our application will be.

```python
COPY . /usr/src/app/
``` 
It's going to copy everything from *./* local directory and move to */usr/src/app/* host directory.

```python
WORKDIR /usr/src/app/
``` 
It sets the path where the *CMD* and the *RUN* commands will run.

```python
EXPOSE 5000
``` 
Exposes the port 5000 of the container to be external accessed.

```python
RUN pip install -r requirements.txt
``` 
Executes when the image is been generated. It works for when you want to install something in the image.

```python
CMD ["python", "app.py"]
``` 
It sets the command that's going to run when the container starts. We've defined the startup of our application.


### docker-compose
Here where the magic start to happens. And we're going to dig in details about implementation. How you can see in the file, we have identation because we're using YAML files, so, if the instruction have some properties then the bottom line is more indented.

```yaml
version: '3'
services: 
    api-service:
        build: ./api-nasa/
        volumes: 
            - ./api-nasa/:/usr/src/app/
        ports: 
            - 5000:5000
        environment: 
            PORT: 5000
            FLASK_DEBUG: 1
```

Let's check each line:

```python
version: '3'
``` 
here you define the version of docker-compose that you're using. Actually the current is the 3.

```python
    api-service:
``` 
It's our api service. 


```python
        build: ./api-nasa/
```
In this section, we say to docker-compose the path where our Dockerfile is.


```python
        volumes: 
            - ./api-nasa/:/usr/src/app/
```
Volumes are the way that we sync the files in our local computer to our containers. We can define volumes in Dockerfiles but only if you're handling container straight, but,how the handler of our container is docker-compose, we are defining them here. 

```python
        ports: 
            - 5000:5000
```
We've talked about PORTS in Dockerfile, but here we can set a port on our localhost where you can access the container. Really cool, not? Basically we are saying: "Listen the port 5000 in our container and set the port 5000 to your localhost".

```python
        environment: 
            PORT: 5000
            FLASK_DEBUG: 1
```
It's really interesing, you can define environment variables and get them in the language that you're going to use. You can checkout in the python file *api-nasa/app.py* the code snippet **os.getenv('PORT')**.


After everything is ready, let's run our docker-compose file.

```shell
    docker-compose up
```