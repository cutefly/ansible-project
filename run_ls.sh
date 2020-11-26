#!/bin/bash

# awx_task 서버에 업로드(/var/lib/aws/projects/run_ls.sh)
pwd
echo "> system information" >  result.txt
lsb_release -a >> result.txt

echo "" >>  result.txt

echo "> file list" >> result.txt
ls -al >> result.txt
