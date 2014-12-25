FROM ubuntu

MAINTAINER Kazuya Kagawa "kazukgw@gmail.com"

RUN apt-get update && apt-get install -y \
                build-essential curl git zlib1g-dev libssl-dev \
                libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV RBENV_ROOT /root/.rbenv

RUN rbenv install 2.1.5
RUN echo "install: --no-document\nupdate: --no-document" >> /root/.gemrc
RUN rbenv global 2.1.5 && /root/.rbenv/shims/gem install bundler && rbenv rehash
