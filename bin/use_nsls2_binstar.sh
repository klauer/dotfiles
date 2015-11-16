anaconda config --set url https://conda.nsls2.bnl.gov/api
echo "channels:
- klauer
- latest
- anaconda
always_yes: true
binstar_upload: true
anaconda_upload: yes" > ~/.condarc

