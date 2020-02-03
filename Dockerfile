FROM ruby:latest
RUN apt-get update && apt-get install -y vim
RUN mkdir /usr/src/artifacts_scrapper
ADD . /usr/src/artifacts_scrapper/
WORKDIR /usr/src/artifacts_scrapper/
COPY Gemfile /usr/artifacts_scrapper/
COPY Gemfile.lock /usr/artifacts_scrapper/
RUN bundle install
