#!/usr/bin/env bash
ssh -L 9000:192.168.75.169:9091 -L 5900:192.168.75.169:5900 home -nNT &
