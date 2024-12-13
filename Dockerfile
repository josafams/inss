FROM ruby:2.6.5
ARG github_key

RUN apt-get update -yqq 
RUN apt-get install -yqq --no-install-recommends \
  libpq-dev \
  postgresql-client \
  nodejs \
  && apt-get clean 

# SE PRECISAR DE REPO PRIVADO
# RUN bundle config GITHUB__COM ${github_key}

RUN mkdir -p /app 
COPY . /app
WORKDIR /app

RUN mkdir -p tmp/pids
