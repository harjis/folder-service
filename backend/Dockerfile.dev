FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.rebar --force
RUN mix local.hex --force

RUN mix do compile

CMD ["mix", "phx.server"]
