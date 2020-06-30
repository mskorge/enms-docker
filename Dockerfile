FROM python:3-alpine

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.0.0.1/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

ENV FLASK_APP app.py

# Alpine dependencies
RUN apk add --no-cache git gcc make bash \
    && apk add --no-cache musl-dev libffi-dev libxml2-dev libxslt-dev openssl-dev 

RUN mkdir -p /enms \
    && git clone https://github.com/afourmy/eNMS.git /enms \
    && cd /enms \
    && pip install -r build/requirements/requirements.txt 

COPY etc /etc

EXPOSE 5000

VOLUME ["/enms"]

WORKDIR "/enms"

ENTRYPOINT ["/init"]