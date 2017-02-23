#!/bin/bash
set -e

echo
echo -e "\033[1;34m** We'll need your Bintray credentials. If you don't remember them go to https://bintray.com/profile/edit\033[0m"

echo -e "\033[1;34m** [1/3] Please enter your Bintray username (probably not your email address): \033[0m"
read -r BINTRAY_USER
echo -e "\033[1;34m** [2/3] Please enter your Bintray API key: \033[0m"
read -r BINTRAY_KEY
echo -e "\033[1;34m** [3/3] Please enter your GPG passphrase: \033[0m"
read -r GPG_PASS

uploadcmd="gradle clean build bintrayUpload --info -PbintrayUsername='$BINTRAY_USER' -PbintrayApiKey='$BINTRAY_KEY' -PbintrayGpgPassword='$GPG_PASS'"

echo
echo -e "\033[1;34m** Dry run\033[0m"
(cd java; eval "$uploadcmd -PdryRun=true")

echo
echo -e "\033[1;34m** Are you happy to conintue?: [yN]\033[0m"
read -p "" -n 1 yn
  case $yn in
    [Yy]* ) ;;
    * ) echo -e "\n\033[1;34m** Run $0 when you're ready to try again\033[0m" && exit;;
  esac

echo
echo -e "\033[1;34m** Publishing\033[0m"
eval "$uploadcmd"