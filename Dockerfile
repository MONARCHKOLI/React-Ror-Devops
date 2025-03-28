# Use official Ruby image (Change Ruby version as needed)
FROM ruby:2.7.7

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libpq-dev \
  yarn

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
