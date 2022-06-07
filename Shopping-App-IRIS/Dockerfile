FROM ruby:2.5.1-stretch
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-server
RUN mkdir /Shopping-App-IRIS
WORKDIR /Shopping-App-IRIS
ADD Gemfile /Shopping-App-IRIS/Gemfile
ADD Gemfile.lock /Shopping-App-IRIS/Gemfile.lock
ADD . /Shopping-App-IRIS

EXPOSE 3000
RUN bundle install


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD [ "rails", "server", "-b", "0.0.0.0" ]