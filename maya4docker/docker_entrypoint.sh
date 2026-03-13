#!/bin/sh

# Licensing registration (runs as root)
cd /install/Packages
/opt/Autodesk/AdskLicensing/Current/AdskLicensingService/AdskLicensingService --run &
./unix_installer.sh
/opt/Autodesk/AdskLicensing/Current/helper/AdskLicensingInstHelper register -pk 657R1 -pv 2026.0.0.F -el EN_US -cf /var/opt/Autodesk/Adlm/Maya2026/MayaConfig.pit
/opt/Autodesk/AdskLicensing/Current/helper/AdskLicensingInstHelper list

# Run Maya as user — container exits when Maya closes
su user -c maya
