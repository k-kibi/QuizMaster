FROM ruby:2.5.1

RUN sed -i.bak -e "s%http://deb.debian.org/debian%http://ftp.jp.debian.org/debian%g" /etc/apt/sources.list && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update -qq && \
    apt-get install -y apt-transport-https build-essential fonts-takao mysql-client nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y --no-install-recommends yarn && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem install bundler

ENV APP_ROOT /webapp
RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

EXPOSE 3000

ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

ENV BUNDLE_GEMFILE=$APP_ROOT/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install
