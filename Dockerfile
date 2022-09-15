FROM python:3.10-alpine3.16 AS compile-image
RUN apk add --update --no-cache \
		build-base \
		git \
		gmp-dev \
		libffi-dev \
		libressl-dev \
		libsodium \
		libsodium-dev \
    && mkdir -p /opt/pytezos_core/src/pytezos_core \
    && touch /opt/pytezos_core/src/pytezos_core/__init__.py
WORKDIR /opt/pytezos_core
ENV PATH="/opt/pytezos_core/bin:$PATH"
ENV PYTHON_PATH="/opt/pytezos_core/src:$PATH"

COPY pyproject.toml requirements.txt README.md /opt/pytezos_core/

RUN /usr/local/bin/pip install \
		--prefix /opt/pytezos_core \
		--no-cache-dir \
		--disable-pip-version-check \
		--no-deps \
		-r /opt/pytezos_core/requirements.txt -e .

FROM python:3.10-alpine3.16 AS build-image
RUN apk --no-cache add \
		binutils \
		gmp-dev \
		gmp \
		libsodium-dev \
	&& adduser -D pytezos

USER pytezos
ENV PATH="/opt/pytezos_core/bin:$PATH"
ENV PYTHONPATH="/home/pytezos:/home/pytezos/src:/opt/pytezos_core/src:/opt/pytezos_core/lib/python3.10/site-packages:$PYTHONPATH"
WORKDIR /home/pytezos/

COPY --chown=pytezos --from=compile-image /opt/pytezos_core /opt/pytezos_core
COPY --chown=pytezos . /opt/pytezos_core
