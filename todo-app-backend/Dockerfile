# Using an official python runtime as the base image
FROM python:alpine

# Setting the working directory in the container 
WORKDIR /app

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# This is copying requirement.txt to the working directory
COPY requirement.txt .

# This is the installation of the dependencies
RUN pip install --no-cache-dir --trusted-host pypi.python.org --use-pep517 -r requirement.txt

# Copying the rest of the application code
COPY . .

RUN chmod +x entrypoint.sh

EXPOSE 5000

CMD ["flask", "run"]
