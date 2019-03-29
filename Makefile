IMAGE = h_nvidia/cuda9.1
TAG = 0.1

build:
	nvidia-docker build -t $(IMAGE):$(TAG) .

run:
	nvidia-docker run -ti -v $$PWD:/supp -p 8888:8888 $(IMAGE):$(TAG)

clean:
	docker rm $$(docker ps -aq) || exit 0
	docker rmi $$(docker images | grep none | awk '{print $$3}')
