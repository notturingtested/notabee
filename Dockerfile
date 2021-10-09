FROM ruby:2.6.6

# Install nodejs on the default ruby image
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
      apt-get install -y nodejs build-essential

WORKDIR /app

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
COPY package.json ./package.json
COPY yarn.lock ./yarn.lock
RUN npm install --global yarn
RUN gem install bundler:2.1.4
RUN bundle install
RUN yarn install

COPY . .
RUN ls
RUN chmod +x ./docker-vite.sh
RUN chmod +x ./docker-rails.sh

CMD ["bin/rails", "console"]
