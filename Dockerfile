FROM elixir

RUN mkdir -p /run/elixir
WORKDIR /run/elixir

COPY . /run/elixir
RUN mix local.hex --force
RUN mix deps.get
RUN mix compile

CMD mix phoenix.server
EXPOSE 4000