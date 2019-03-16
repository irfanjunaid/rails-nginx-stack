FROM ruby:latest
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV RAILS_ROOT /var/www/railsapp
ENV RAILS_ENV='production'
ENV RACK_ENV='production'
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5
COPY . .
RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
