# invoke global X session script
. /etc/X11/Xsession

# execute during startup
xrdb -merge ~/.Xresources

# Functionial keybindings (volume, brightness etc)
xbindkeys