# Empty ubuntu with a cehtest user that can sudo w/o password
FROM ubuntu:14.04
MAINTAINER Gergely Risko <errge@nilcons.com>
RUN apt-get -y install wget git sudo adduser
RUN useradd -m -g users cehtest ; groupadd -r wheel ; adduser cehtest wheel
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers

# Install ceh
RUN mkdir /opt/ceh /nix && chown cehtest. /opt/ceh /nix ; chmod 0700 /opt/ceh /nix
USER cehtest
ENV HOME=/home/cehtest \
    USER=cehtest \
    CEH_BUILD_MAX_JOBS=40
RUN cd /opt/ceh && git clone git://github.com/nilcons/ceh.git . && ln -s $HOME home
RUN /opt/ceh/scripts/ceh-init.sh 2>&1 | tee /home/cehtest/ceh-init.log

# Load ceh
RUN echo source /opt/ceh/scripts/ceh-profile.sh >>/home/cehtest/.bashrc

# Shell in homedir
WORKDIR /home/cehtest
CMD /bin/bash
