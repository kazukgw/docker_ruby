FROM ubuntu

MAINTAINER Kazuya Kagawa "kazukgw@gmail.com"

ENV HOME /root
ENV RUBY_VERSION 2.2.0

RUN apt-get update && \
      apt-get install -y \
        build-essential curl git zlib1g-dev libssl-dev \
        libffi-dev libreadline-dev libyaml-dev \
        libxml2-dev libxslt-dev && \
      apt-get clean

# install rbenv & ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV RBENV_ROOT /root/.rbenv

# install ruby
RUN rbenv install $RUBY_VERSION
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"
RUN rbenv global $RUBY_VERSION && /root/.rbenv/shims/gem install bundler && rbenv rehash

