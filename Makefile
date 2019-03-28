IMAGE = h_nvidia/cuda9.1
TAG = 0.1

build:
	nvidia-docker build -t $(IMAGE):$(TAG) .

run:
	nvidia-docker run -ti -v $$PWD:/supp -p 8888:8888 $(IMAGE):$(TAG)
