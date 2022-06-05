# ************* COMMON BUILD *************
FROM python:3.9.13-slim as base

ARG POETRY_VERSION=1.1.13
ARG HOME_DIR=/home/appuser

RUN useradd -ms /bin/bash appuser
USER appuser

WORKDIR $HOME_DIR

RUN pip install poetry==$POETRY_VERSION
ENV PATH=$HOME_DIR/.local/bin:$PATH
RUN python -m venv venv

# ************* TEST BUILD *************
FROM base as test
COPY poetry.lock pyproject.toml ./

RUN . venv/bin/activate && poetry install
COPY main.py main_test.py ./
RUN . venv/bin/activate && poetry run pytest

# ************* PROD BUILD *************
FROM base as prod
COPY poetry.lock pyproject.toml ./
RUN . venv/bin/activate && poetry install --no-dev

COPY main.py ./
CMD venv/bin/gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app