FROM ruby:latest
RUN apt-get update && apt-get install -y vim
RUN mkdir /usr/src/artifacts_scrapper
WORKDIR /usr/src/artifacts_scrapper/
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY . .
