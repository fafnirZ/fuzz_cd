#!/bin/bash

##
# The MIT License (MIT)
# 
# Copyright (c) 2024 Jacky Xie
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
##

FAIL='\033[91m'
CLEAR='\033[0m'
GREEN='\033[92m'
WARNING='\033[0;33m'

install_fzf_dep() {
  if ! [ -d /tmp/fzf_install ]; then
    mkdir /tmp/fzf_install
  fi
  wget https://github.com/junegunn/fzf/releases/download/v0.56.0/fzf-0.56.0-linux_amd64.tar.gz \
    -O /tmp/fzf_install/fzf.tar.gz \
    -q
  if [ $? -ne 0 ]; then
    echo "$ERROR failed to install fzf $CLEAR"
    exit 1
  fi 

  cd /tmp/fzf_install

  # untar and cp to usr/bin
  tar -xvf fzf.tar.gz
  sudo cp fzf /usr/local/bin/fzf
  if [ $? -ne 0 ]; then
    echo "$ERROR failed to copy fzf to /usr/local/bin $CLEAR"
    exit 1
  fi 
  
  # cleanup
  cd /tmp/fzf_install
  rm -r /tmp/fzf_install
  echo "cleaned up /tmp/fzf_install"

  # done
  echo -e "$GREEN DONE $CLEAR"
}

check_fzf_dep() {
  echo "Checking for existance of fzf in /usr/local/bin/"
  if ! [ -f "/usr/local/bin/fzf" ]; then
    echo -e "$WARNING fzf not found, installing... $CLEAR"
    # installing dep
    install_fzf_dep
    return
  fi

  echo -e "$GREEN found in /usr/local/bin/fzf $CLEAR"
}



install_fcd() {
  if ! [ -d /tmp/fcd_install ]; then
    mkdir /tmp/fcd_install
  fi

  wget https://raw.githubusercontent.com/fafnirZ/fuzz_cd/refs/heads/main/fcd \
     -O /tmp/fcd_install/fcd \
     -q
  if [ $? -ne 0 ]; then
    echo "$ERROR failed to install fcd $CLEAR"
    exit 1
  fi 

  # check bin checksum
  original_checksum=$(curl https://raw.githubusercontent.com/fafnirZ/fuzz_cd/refs/heads/main/checksum)
  new_checksum=$(cat /tmp/fcd_install/fcd | md5sum | cut -d' ' -f1)
  diff <(echo $original_checksum) <(echo $new_checksum)
  if [ $? -ne 0 ];then
    echo "$ERROR ERROR CHECKSUMS DONT MATCH $CLEAR" 
    exit 1
  fi

  # move to /usr/local/bin
  chmod +x /tmp/fcd_install/fcd
  sudo cp /tmp/fcd_install/fcd /usr/local/bin
  if [ $? -ne 0 ]; then
    echo "$ERROR failed to copy fcd to /usr/local/bin $CLEAR"
    exit 1
  fi 
  

  # cleanup
  cd /tmp/fcd_install
  rm -r /tmp/fcd_install
  echo "cleaned up /tmp/fcd_install"

}

check_fzf_dep
install_fcd
