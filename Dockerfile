FROM ruby:2.6.6-alpine AS development

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

# Install the Essentials
ENV BUILD_DEPS="curl tar wget linux-headers bash" \
    DEV_DEPS="ruby-dev build-base postgresql-dev zlib-dev libxml2-dev libxslt-dev readline-dev tzdata git nodejs vim sqlite-dev"

RUN apk add --update --upgrade $BUILD_DEPS $DEV_DEPS

# Install Yarn
RUN apk add --update yarn

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install any extra dependencies via Aptfile
COPY Aptfile /usr/src/app/Aptfile
RUN apk add --update $(cat /usr/src/app/Aptfile | xargs)

# Set up environment
ENV PATH /usr/src/app/bin:$PATH

# Add some helpers to reduce typing when inside the containers
RUN echo 'alias bx="bundle exec"' >> ~/.bashrc

# Set ruby version
COPY .ruby-version /usr/src/app

# Install latest bundler
RUN gem update --system && gem install bundler:2.0.2
RUN bundle config --global silence_root_warning 1 && echo -e 'gem: --no-document' >> /etc/gemrc

RUN mkdir -p /usr/src/bundler
RUN bundle config path /usr/src/bundler

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

FROM development AS production

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle check || bundle install --jobs=$(nproc)

# Install Yarn Libraries
COPY package.json /user/src/app
COPY yarn.lock /user/src/app
RUN yarn install --check-files

# Copy the rest of the app
COPY . /usr/src/app

# Copy DB Sample
RUN cp -u /usr/src/app/config/database.yml.sample /usr/src/app/config/database.yml

# Compile the assets
RUN SECRET_KEY_BASE=secret-key-base RAILS_ENV=production RACK_ENV=production NODE_ENV=production bundle exec rake assets:precompile
