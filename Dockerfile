# Use official Ruby image (Change Ruby version as needed)
# FROM ruby:2.7.7
FROM --platform=linux/amd64 ruby:2.7.7-buster

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libpq-dev \
  yarn

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y yarn

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (only for production)
RUN bundle exec rake assets:precompile

# Expose port 3000 for Rails server
EXPOSE 3000

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
