FROM ubuntu

MAINTAINER Kazuya Kagawa "kazukgw@gmail.com"

RUN apt-get update && apt-get install -y \
                build-essential curl git zlib1g-dev libssl-dev \
                libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install 2.1.2
RUN echo "install: --no-document \n update: --no-document" >> /root/.gemrc
RUN rbenv global 2.1.2 && /.rbenv/shims/gem install bundler
