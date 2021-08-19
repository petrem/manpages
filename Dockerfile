ARG BASE="debian:testing-slim"
FROM $BASE

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -e '/path-exclude \/usr\/share\/man\/\*/s/^/#/' /etc/dpkg/dpkg.cfg.d/docker
RUN adduser --shell /bin/bash --uid 1000 --disabled-password --gecos "" manpages
RUN apt-get update \
    && apt-get install --assume-yes apt-utils \
    && apt-get install --assume-yes \
    less \
    man-db \
    manpages \
    manpages-dev \
    glibc-doc \
    git-man \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/bin/mandb -c

USER manpages

ENTRYPOINT ["man"]
