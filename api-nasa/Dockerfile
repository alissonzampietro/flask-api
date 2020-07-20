FROM python:3.6
RUN mkdir /usr/src/app/
COPY . /usr/src/app/
WORKDIR /usr/src/app/
EXPOSE 5000
RUN touch requirements.txt
RUN pip freeze > requirements.txt
CMD ["python", "app.py"]

