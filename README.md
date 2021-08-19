# A simple docker image for reading Linux manpages locally

A smallish docker image containing most commonly used Linux manpages, for quickly accessing them
when you are not running Linux natively.

## Tags

Currently only `latest` is used, and the image is rebuilt and uploaded from time to time.
The base image is debian:testing-slim.

## Installation

You need a working docker installation, otherwise nothing is required.

To get the image without running it, e.g. to secure it for offline usage, run

    docker image pull petrem/manpages

You may want to add the following script somewhere in your path (e.g. as `~/.local/bin/manpages`):

    #!/usr/bin/env bash
    docker run --rm -it petrem/manpages:latest "$@"

.. and make it executable:

    chmod a+x ~/.local/bin/manpages


## Usage

Running the docker image invokes the `man` command and passes arguments on:

    docker run --rm -it petrem/manpages 2 open

or with the script suggested in the Installation section:

    manpages 3 open

# Contributing

Contributions are welcome.

Please add bug reports and feature requests to the [Github issue tracker](https://github.com/petrem/manpages/issues).
