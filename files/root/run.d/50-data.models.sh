
if [ ! -f /data/home/.cache/whisper/base.pt ]; then
	cp /src/whisper/base.pt /data/home/.cache/whisper
    chown user:user /data/home/.cache/whisper/base.pt
fi

if [ ! -f /data/home/.cache/whisper/small.pt ]; then
	cp /src/whisper/small.pt /data/home/.cache/whisper
    chown user:user /data/home/.cache/whisper/small.pt
fi
