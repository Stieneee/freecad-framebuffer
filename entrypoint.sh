#! /bin/sh

Xvfb :99 -screen 0 1600x1200x24 -nolisten tcp & sleep 1; freecad "$@"