
FROM phusion/passenger-ruby22:0.9.15
MAINTAINER supercoder@gmail.com

ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Run Bundle in a cache efficient way
WORKDIR /tmp
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN bundle install
#
# Setup NginX
#
RUN rm -f /etc/service/nginx/down
ADD deploy/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD deploy/gzip_max.conf /etc/nginx/conf.d/gzip_max.conf
RUN rm /etc/nginx/sites-enabled/default
ADD deploy/web_app.conf /etc/nginx/sites-enabled/web_app.conf

# Install app here:
RUN mkdir /home/app/web_app
ADD . /home/app/web_app

# Remove the .bundle directory if it exists, use what we installed above
RUN rm -rf /home/app/web_app/.bundle

# Compile Assets
WORKDIR /home/app/web_app
RUN rake assets:precompile

RUN chown -R app:app /home/app/web_app

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

