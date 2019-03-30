IMAGE = libdream_nvidia/cuda
TAG = 0.1

build_py36_cuda80:
	nvidia-docker build -t $(IMAGE)80:$(TAG) -f Dockerfile.cuda80 .

run_py36_cuda80:
	nvidia-docker run -ti -v $$PWD:/supp -p 8888:8888 $(IMAGE)80:$(TAG)

clean:
	@running="$$(docker ps -aq)" ; \
	if [ -n "$$running" ] ; then \
	    echo Removing instances $$running ; \
		docker rm $$running ; \
	fi ; \
	nones="$$(docker images | grep none | awk '{print $$3}')" ; \
	if [ -n "$$nones" ] ; then \
		echo Removing images $$nones ; \
		docker rmi $$nones ; \
	fi ;
