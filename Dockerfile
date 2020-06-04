FROM ubuntu:18.04
MAINTAINER math0ne@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    xz-utils \
    openssl \
    gnupg2 \
    bash \
    ruby \
    ruby-dev \
    build-essential \
    git \
    libpng-dev

# Install Basics
RUN apt-get update \
  && apt-get upgrade -y

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update
RUN apt install -y yarn

RUN gem install bundler

RUN node -v
RUN npm -v
RUN yarn -v
RUN ruby -v

COPY Gemfile ./

RUN bundle install

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
