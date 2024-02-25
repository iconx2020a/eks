FROM --platform=linux/amd64 mysql:latest
ENV MYSQL_DATABASE testdb
COPY ./scripts/ /docker-entrypoint-initdb.d/
