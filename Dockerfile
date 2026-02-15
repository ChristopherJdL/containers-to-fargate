# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7


# About the below:
# PYTHONUNBUFFERED Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.

# PYTHONDONTWRITEBYTECODE Prevents Python from writing pyc files.

ARG PYTHON_VERSION=3.13.9
FROM python:${PYTHON_VERSION}-slim as base

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

WORKDIR .

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Switch to the non-privileged user to run the application.
USER appuser

# My env vars
ENV FLASK_APP=hello

# Had to configure those two ones to ensure network binding
ENV FLASK_RUN_PORT=8080
ENV FLASK_RUN_HOST=0.0.0.0


# Copy the source code into the container.
COPY . .

# Expose the port that the application listens on.
EXPOSE 8080

# Run the application.
CMD flask run
