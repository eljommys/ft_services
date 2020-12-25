FROM	alpine

RUN		apk add nginx openssh openssl&& \
		mkdir -p /run/nginx && \
		echo "root:toor" | chpasswd && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && \
		openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

RUN		ssh-keygen -A

COPY	./index.html			/var/www/
COPY	./nginx.conf			/etc/nginx/
COPY	./ssl_params.conf		/etc/nginx/
COPY	./start.sh				/

EXPOSE	80 443 22

ENTRYPOINT	sh start.sh
