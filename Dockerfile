FROM ubuntu:latest

RUN sed -i -e '/\/usr\/share\/man/s/^/#/' /etc/dpkg/dpkg.cfg.d/excludes
RUN apt-get update &&\
    apt-get install --assume-yes apt-utils &&\
    apt-get install --assume-yes less man-db manpages manpages-dev manpages-posix manpages-posix-dev glibc-doc
RUN /usr/bin/mandb -c
