FROM ruby:2.5.1-alpine3.7

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  tzdata \
  && rm -rf /var/cache/apk/*

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri --use-system-libraries

ENV RAILS_ENV production

ENV APP_PATH /usr/src

# Different layer for gems installation
WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN bundle install

COPY . $APP_PATH
EXPOSE 3000
CMD /bin/sh -c "rm -f /usr/src/app/tmp/pids/server.pid && ./bin/rails db:migrate && ./bin/rails server"
