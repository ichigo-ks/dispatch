JUPYTER_PORT=4444
WEBSERVER_PORT=9000

build_docker_image:
	docker build -t dispatcher .

run_jupyter_notebook: build_docker_image
	docker run --rm -it \
		-p ${JUPYTER_PORT}:${JUPYTER_PORT} \
		-v $(shell pwd)/notebooks:/home \
		--workdir="/home" \
		dispatcher jupyter notebook --ip=0.0.0.0 --port=$(JUPYTER_PORT) --no-browser --allow-root

run_webserver: build_docker_image
	docker run --rm -it \
		-p ${WEBSERVER_PORT}:${WEBSERVER_PORT} \
		-v $(shell pwd)/webserver:/go/src/webserver \
		--workdir="/go/src/webserver" \
		dispatcher go run main.go