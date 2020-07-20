FROM ruby:2.7.1-alpine AS builder

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

RUN apk add --no-cache \
    #
    # required
    build-base libffi-dev \
    nodejs-dev yarn tzdata \
    zlib-dev libxml2-dev libxslt-dev readline-dev bash \
    # Nice to haves
    git vim \
    #
    # Fixes watch file issues with things like HMR
    libnotify-dev

FROM builder as development

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV PATH /usr/src/app/bin:$PATH

# Install latest bundler
RUN bundle config --global silence_root_warning 1

CMD ["rspec"]

FROM development AS production

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle check || bundle install --jobs=$(nproc)

# Copy the rest of the app
COPY . /usr/src/app
