FROM	alpine

RUN		apk add mariadb mariadb-client

COPY	./my.cnf			/etc/
COPY	./wordpress.sql		/
COPY	./start.sh			/

EXPOSE 3306

ENTRYPOINT	sh start.sh
