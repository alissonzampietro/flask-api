FROM python:latest
COPY . /usr/src/app
CMD [ "python", "api.py" ]
EXPOSE 80