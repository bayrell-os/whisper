#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=`dirname $SCRIPT`
BASE_PATH=`dirname $SCRIPT_PATH`

RETVAL=0
IMAGE="whisper"
VERSION="v20231117"
SUBVERSION=1
TAG=`date '+%Y%m%d_%H%M%S'`

if [ "$APT_MIRROR" = "" ]; then
	APT_MIRROR=""
fi

case "$1" in
	
	test)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION-$TAG \
			--file Dockerfile --progress=plain --build-arg ARCH=amd64
	;;

	test-cuda)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION-$TAG-cuda \
			--file Dockerfile.cuda --progress=plain --build-arg ARCH=amd64
	;;
	
	amd64)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION \
			--file Dockerfile --progress=plain --build-arg ARCH=amd64
		docker push bayrell/$IMAGE:$VERSION-$SUBVERSION
		docker tag bayrell/$IMAGE:$VERSION-$SUBVERSION bayrell/$IMAGE:$VERSION
		docker push bayrell/$IMAGE:$VERSION
	;;
	
	amd64-cuda)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION-cuda \
			--file Dockerfile.cuda --progress=plain --build-arg ARCH=amd64
		docker push bayrell/$IMAGE:$VERSION-$SUBVERSION-cuda
		docker tag bayrell/$IMAGE:$VERSION-$SUBVERSION-cuda bayrell/$IMAGE:$VERSION-cuda
		docker push bayrell/$IMAGE:$VERSION-cuda
	;;

	upload-github)
		docker tag bayrell/$IMAGE:$VERSION-$SUBVERSION \
			ghcr.io/bayrell-os/$IMAGE:$VERSION-$SUBVERSION
		
		docker tag bayrell/$IMAGE:$VERSION-$SUBVERSION-cuda \
			ghcr.io/bayrell-os/$IMAGE:$VERSION-$SUBVERSION-cuda

		docker push ghcr.io/bayrell-os/$IMAGE:$VERSION-$SUBVERSION
		docker push ghcr.io/bayrell-os/$IMAGE:$VERSION-$SUBVERSION-cuda

		docker tag bayrell/$IMAGE:$VERSION \
			ghcr.io/bayrell-os/$IMAGE:$VERSION
		
		docker tag bayrell/$IMAGE:$VERSION-cuda \
			ghcr.io/bayrell-os/$IMAGE:$VERSION-cuda

		docker push ghcr.io/bayrell-os/$IMAGE:$VERSION
		docker push ghcr.io/bayrell-os/$IMAGE:$VERSION-cuda
	;;

	all)
		$0 amd64
		$0 amd64-cuda
	;;
	
	*)
		echo "Usage: $0 {amd64|amd64-cuda|all}"
		RETVAL=1

esac

exit $RETVAL