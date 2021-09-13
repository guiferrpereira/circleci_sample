# to build pass a github access token and build version args like so
# docker build -t circleci_sample \
#    --build-arg VERSION=1.0 \
#    --build-arg BRANCH=staging \
#    --build-arg SHA=7d2206bfd1e9756cbd841384ceaa903f4bf80de7 \
#     .

FROM ruby:3.0.2
RUN apt-get update -qq && apt-get install -y build-essential postgresql-client
RUN mkdir /circleci_sample
WORKDIR /circleci_sample
COPY Gemfile /circleci_sample/Gemfile

ARG VERSION=VERSION
ARG BRANCH=BRANCH
ARG SHA=SHA
ENV BUILD_VERSION="{ \"version\": \"${VERSION}\", \"service\": \"circleci_sample\", \"branch\": \"${BRANCH}\", \"sha\": \"${SHA}\" }"
RUN touch .build-version && echo ${BUILD_VERSION} > .build-version

RUN bundle config set without 'development test'
RUN bundle install
COPY . /circleci_sample
