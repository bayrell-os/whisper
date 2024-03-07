
if [ ! -d /data/home ]; then
    mkdir -p /data/home
    chown -R user:user /data/home
fi

if [ ! -d /data/home/.cache ]; then
    mkdir -p /data/home/.cache
    chown -R user:user /data/home/.cache
fi

if [ ! -d /data/home/.cache/whisper ]; then
    mkdir -p /data/home/.cache/whisper
    chown -R user:user /data/home/.cache/whisper
fi

if [ `stat -c "%U" /data/home` != "user" ] || [ `stat -c "%G" /data/home` != "user" ]; then
    chown -R user:user /data/home
fi
