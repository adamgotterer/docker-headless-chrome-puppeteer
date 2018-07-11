FROM debian:stretch-slim
LABEL name="headless-chrome-puppeteer" maintainer="agotterer[at]gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ARG CHROMIUM_REVISION

RUN apt-get update -qqy && apt-get -qqy install wget gnupg2 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y \
      fonts-ipafont-gothic \
      fonts-wqy-zenhei \
      fonts-thai-tlwg \
      fonts-kacst \
      ttf-freefont \
      fonts-liberation \
      unzip \
      curl \
      wget \
      ca-certificates \
      apt-transport-https \
      jq \
      libasound2 \
      libatk1.0-0 \
      libc6 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libexpat1 \
      libfontconfig1 \
      libgcc1 \
      libgconf-2-4 \
      libgdk-pixbuf2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxss1 \
      libxtst6 \
      libnss3 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

RUN useradd headless --shell /bin/bash --create-home \
    && usermod -a -G sudo headless \
    && echo 'ALL ALL = NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'headless:nopassword' | chpasswd

RUN mkdir /data \
    && chown -R headless:headless /data

RUN \
  wget -P /tmp/ https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/$CHROMIUM_REVISION/chrome-linux.zip \
  && unzip /tmp/chrome-linux.zip -d /tmp \
  && mv /tmp/chrome-linux /etc/alternatives/ \
  && ln -s /etc/alternatives/chrome-linux/chrome /bin/google-chrome \
  && chown -R headless:headless /etc/alternatives/chrome-linux \
  && chown headless:headless /bin/google-chrome \
  && chmod 4775 /bin/google-chrome

RUN apt-get purge --auto-remove -y curl jq wget unzip gnupg2 \
    && apt-get clean

USER headless

EXPOSE 9222
CMD [ \
    "google-chrome", \
    "--remote-debugging-port=9222", \
    "--remote-debugging-address=0.0.0.0", \
    "--headless", \
    "--no-sandbox", \
    "--mute-audio", \
    "--incognito", \
    "--disable-background-timer-throttling", \
    "--disable-breakpad", \
    "--disable-client-side-phishing-detection", \
    "--disable-default-apps", \
    "--disable-dev-shm-usage", \
    "--disable-extensions", \
    "--disable-features=site-per-process", \
    "--disable-hang-monitor", \
    "--disable-popup-blocking", \
    "--disable-prompt-on-repost", \
    "--disable-sync", \
    "--disable-translate", \
    "--metrics-recording-only", \
    "--no-first-run", \
    "--safebrowsing-disable-auto-update" \
]
