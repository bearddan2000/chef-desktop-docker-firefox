FROM ubuntu:latest

WORKDIR /usr/local

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y chef git \
    && git clone https://github.com/bearddan2000/chef-lib-recipes.git \
    && chmod -R +x chef-lib-recipes \
    && mkdir -p cookbooks/op/recipes \
    && mv chef-lib-recipes/apps/firefox.rb cookbooks/op/recipes/default.rb \
    && chef-solo -c chef-lib-recipes/solo.rb -o 'recipe[op]'

RUN useradd -d /home/developer -m developer -s /bin/bash

ENV HOME /home/developer

USER developer

CMD /usr/bin/firefox
