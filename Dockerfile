FROM ruby:2.6.8

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

# Install node
RUN curl https://deb.nodesource.com/setup_12.x | bash
# Install GPG
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# Get the latest version of yarn
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update
RUN sudo apt-get install yarn