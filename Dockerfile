FROM python:3.6

ENV FLASK_APP app.py

RUN mkdir -p /enms \
    && git clone https://github.com/afourmy/eNMS.git /enms \
    && cd /enms \
    && pip install -r build/requirements/requirements.txt

WORKDIR "/enms"

EXPOSE 5000

VOLUME ["/enms/files", "/enms/database.db"]

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
