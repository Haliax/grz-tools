FROM python:3.13.7

# uv installieren
COPY --from=ghcr.io/astral-sh/uv:0.9.13 /uv /uvx /bin/

WORKDIR /app

# copy dependencies and install dependencies first
COPY pyproject.toml uv.lock ./
COPY packages/ packages/
RUN uv sync --frozen --no-install-project

# copy other files
COPY . .
RUN uv sync --frozen

# disable docopt syntax warnings
ENV PYTHONWARNINGS="ignore:invalid escape sequence"

ENTRYPOINT ["uv", "run", "grz-cli"]
