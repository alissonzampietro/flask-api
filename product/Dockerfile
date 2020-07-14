FROM python:3.5
RUN mkdir /usr/src/app/
COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
CMD ["python", "/usr/src/app/api.py"]