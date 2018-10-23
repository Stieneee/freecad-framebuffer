FROM ubuntu:latest

ENV DISPLAY :99

RUN apt-get update \
  && apt-get install -y software-properties-common apt-transport-https wget unzip build-essential \
  && apt-add-repository -y ppa:freecad-maintainers/freecad-stable \
  && add-apt-repository -y ppa:freecad-community/ppa \
  && apt-get update \
  && apt-get install -y freecad gmsh git python-numpy python-pyside xvfb \
  && apt-get autoremove \
  && apt-get clean

RUN adduser --disabled-password --quiet --gecos '' user

ENV LIBGL_DRI3_DISABLE=true

RUN usermod -aG video user

RUN mkdir /tmp/.X11-unix \
  && chmod 1777 /tmp/.X11-unix \
  && chown root /tmp/.X11-unix/

RUN ln -s /usr/lib/freecad/bin/FreeCADCmd /usr/bin/FreeCADCmd

USER user

ENV USER user

RUN cd /opt
COPY ./ ./

ENTRYPOINT /opt/entrypoint.sh
