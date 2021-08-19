# config
BASE_REPO := "debian"
BASE_TAG := "testing-slim"

LOCAL_NAME := "manpages"
REPO := "petrem/manpages"
# config ends

BASE := BASE_REPO + ":" + BASE_TAG


# By default, list available recipes
_default:
    @just --list

# Build local manpages:latest image
build:
    docker build --pull --build-arg BASE={{BASE}} -t {{LOCAL_NAME}}:latest .

# Check for vulnerabilities
snyk:
    snyk container test --file={{justfile_directory()}}/Dockerfile --exclude-base-image-vulns {{LOCAL_NAME}}

# Build, tag and publish
publish: build
    docker image tag {{LOCAL_NAME}}:latest {{REPO}}:latest
    docker push {{REPO}}

# Build locally, and install a helper script
@install: build
    #!/usr/bin/env bash
    set -euxo pipefail
    cat > ~/.local/bin/manpages << 'EOT'
    #!/usr/bin/env bash
    docker run --rm -it manpages:latest "$@"
    EOT
    chmod a+rx ~/.local/bin/manpages
