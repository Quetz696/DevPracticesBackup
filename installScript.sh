#!/bin/bash

sudo apt-get install -y software-properties-common

sudo add-apt-repository ppa:tsl0922/ttyd-dev
sudo add-apt-repository ppa:webupd8team/atom -y
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

sudo apt-get update
sudo apt-get upgrade -y 
sudo apt-get install git atom openssh-server htop vlc snapd gscan2pdf build-essential cmake  gparted filezilla nmap haskell-platform synaptic gdebi-core pidgin r-base r-base-dev ttyd -y
