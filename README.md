# Transcription video

## CPU

Download docker container:
```
docker pull bayrell/whisper:v20231117
```

Run docker:
```
docker run -it --rm ./:/shared bayrell/whisper:v20231117 bash
```

## Nvidia CUDA

Download docker container:
```
docker pull bayrell/whisper:v20231117-cuda
```

Run docker:
```
docker run -it --rm ./:/shared bayrell/whisper:v20231117-cuda bash
```

## Usage

Transcription video:
```
cd /shared
whisper video.mp4 --model base
```
