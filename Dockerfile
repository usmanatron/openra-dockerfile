FROM fedora:23
MAINTAINER Roland Moriz <roland@moriz.de>

RUN dnf install wget rsync -y

RUN cd /etc/yum.repos.d/ && \
    wget http://download.opensuse.org/repositories/games:openra/Fedora_23/games:openra.repo && \
    dnf install openra -y

RUN useradd -d /home/openra -m -s /sbin/nologin openra
RUN chown -R openra:openra /usr/lib/openra
ADD bin/start.sh /home/openra/start.sh

RUN mkdir /home/openra/.openra && \
    mkdir /home/openra/.openra/Logs && \
    mkdir /home/openra/.openra/maps

RUN chown -R openra:openra /home/openra && chmod 755 /home/openra/start.sh

EXPOSE 1234

VOLUME ["/home/openra", "/usr/lib/openra", "/home/openra/.openra/Logs", "/home/openra/.openra/maps"]

USER openra
CMD [ "/home/openra/start.sh" ]
