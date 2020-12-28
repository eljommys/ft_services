FROM	alpine

RUN		apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		echo "root:toor" | chpasswd

COPY	./start.sh				/

WORKDIR	/usr/share/grafana

EXPOSE	3000

ENTRYPOINT	sh		/start.sh
