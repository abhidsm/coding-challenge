FROM ruby:3.2.1

RUN apt-get update -qq \
&& apt-get install -y postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash"]