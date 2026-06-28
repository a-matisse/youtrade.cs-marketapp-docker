FROM justarchi/archisteamfarm:main

ARG APP_VERSION=4.3.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgbm1 libasound2t64 libatk-bridge2.0-0t64 libcups2t64 \
    libdrm2 libexpat1 libgcc-s1 libglib2.0-0t64 \
    libgtk-3-0t64 libnspr4 libnss3 libpango-1.0-0 \
    libstdc++6 libx11-6 libxcb1 libxcomposite1 \
    libxdamage1 libxext6 libxfixes3 libxrandr2 \
    libxtst6 \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Установка конфигурации IPC
COPY IPC.config /app/config/
COPY ASF.json /app/config/

# Установка .deb
COPY market-app_${APP_VERSION}_amd64.deb /tmp/
RUN dpkg -i --force-depends /tmp/market-app_${APP_VERSION}_amd64.deb && \
    rm /tmp/*.deb

# Supervisor — главный процесс
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Выводим порты: marketapp(3000), asf(1242)
EXPOSE 3000 1242

# ENTRYPOINT — нельзя переопределить без --entrypoint флага
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]