
FROM golang:1.19.4-bullseye

RUN set -x; \
    apt-get update -y &&\
    apt-get install -y postgresql-client

RUN go install github.com/volatiletech/sqlboiler/v4@latest &&\
    go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@latest
