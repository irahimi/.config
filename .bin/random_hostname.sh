#!/bin/bash
HOSTNAME=`openssl rand -hex 8`
scutil --set HostName      $HOSTNAME
scutil --set ComputerName  $HOSTNAME
scutil --set LocalHostName $HOSTNAME
