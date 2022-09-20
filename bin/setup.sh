#!/bin/bash

#Basic setup script for the snakemake pipeline
#
# @zgr2788

clear
printf -- "Please enter the ABSOLUTE PATH to your conda profile.\n\nShould look something like this:\n/cta/users/oybeker/mambaforge/etc/profile.d/conda.sh"

while true
do

  printf -- "\n\nYour path: "
  read path
  printf -- "\n\nPath for conda.sh will be:\n\n$path\n\nAre you sure?(Y/n): "
  read c

  if [[ $c == "n" || $c == "N" ]]; then printf -- "\n***********\nEnter path again." ;
  else
    #Write to files
    printf -- "\nWriting to files...\n\n"
    sed -E -i 's@condaDir="(.*)"@condaDir="'$path'"@g' "pip.sh"
    sed -E -i 's@condaDir="(.*)"@condaDir="'$path'"@g' "dag.sh"
    break
  fi
done
