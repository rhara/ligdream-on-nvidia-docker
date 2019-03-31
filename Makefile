build_py36:
	docker build -t ligdream_cpu:0.1 -f Dockerfile.cpu .

build_py36_cuda80:
	nvidia-docker build -t ligdream_nvidia/cuda80:0.1 -f Dockerfile.cuda80 .

build_py35_cuda90:
	nvidia-docker build -t ligdream_nvidia/cuda90:0.1 -f Dockerfile.cuda90 .

build_py36_cuda100:
	nvidia-docker build -t ligdream_nvidia/cuda100:0.1 -f Dockerfile.cuda100 .

run_py36:
	docker run -t -i -v $$PWD:/supp -p 8888:8888 ligdream_cpu:0.1 bash

run_py36_cuda80:
	nvidia-docker run -t -i -v $$PWD:/supp -p 8888:8888 ligdream_nvidia/cuda80:0.1 bash

run_py35_cuda90:
	nvidia-docker run -t -i -v $$PWD:/supp -p 8888:8888 ligdream_nvidia/cuda90:0.1 bash

run_py36_cuda100:
	nvidia-docker run -t -i -v $$PWD:/supp -p 8888:8888 ligdream_nvidia/cuda100:0.1 bash

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
