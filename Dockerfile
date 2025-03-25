# Use the official Ruby image as the base image
FROM ruby:3.1

# Set environment variables
ENV JEKYLL_ENV=production

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  npm

# Create a directory for the app
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

RUN gem install bundler

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the rest of the application code
COPY . .

# Build the site
RUN bundle exec jekyll build

# Expose the port that Jekyll will run on
EXPOSE 4000

# Command to run the Jekyll server
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
