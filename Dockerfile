FROM linuxserver/sonarr:preview

RUN \
  apt-get update && \
  apt-get install -y \
  wget \
  git \
  python-pip \
  openssl \
  python-dev \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  zlib1g-dev

RUN \
  pip install --upgrade pip && \
  hash -r pip && \
  pip install requests && \
  pip install requests[security] && \
  pip install requests-cache && \
  pip install babelfish && \
  pip install guessit && \
  pip install subliminal && \
  pip install qtfaststart && \
  pip install tmdbsimple && \
  pip install mutagen && \
  git clone --branch master git://github.com/mdhiggins/sickbeard_mp4_automator.git /sickbeard_mp4_automator/ && \
  touch /sickbeard_mp4_automator/info.log && \
  chmod a+rwx -R /sickbeard_mp4_automator && \
  ln -s /downloads /data && \
  ln -s /config_mp4_automator/autoProcess.ini /sickbeard_mp4_automator/autoProcess.ini && \
  ln -snf /config_mp4_automator/plex_autoscan.py /sickbeard_mp4_automator/post_process/plex_autoscan.py && \
  rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN \
# ffmpeg
  wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
  mkdir /usr/local/bin/ffmpeg && \
  tar -xJf /tmp/ffmpeg.tar.xz -C /usr/local/bin/ffmpeg --strip-components 1 && \
  chgrp -R users /usr/local/bin/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffprobe

VOLUME config_mp4_automator
