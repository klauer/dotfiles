anaconda config --set url https://api.anaconda.org
echo "channels:
- klauer
- defaults
always_yes: true
binstar_upload: true
anaconda_upload: yes" > ~/.condarc

