FROM python:3.9.13-slim as base

ARG POETRY_VERSION=1.1.13
ARG HOME_DIR=/home/appuser

RUN useradd -ms /bin/bash appuser
USER appuser

WORKDIR $HOME_DIR

RUN pip install poetry==$POETRY_VERSION
ENV PATH=$HOME_DIR/.local/bin:$PATH
ENV PYTHONPATH=$HOME_DIR

FROM base as build
COPY helloapp helloapp
COPY tests poetry.lock pyproject.toml ./
RUN poetry install
RUN poetry run pytest

FROM base as prod
COPY helloapp helloapp
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev