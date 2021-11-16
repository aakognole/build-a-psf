#!/bin/bash

> setenv

cwd=`pwd`
if [ ! -e toppar_drude ]; then tar -xzf toppar_drude.tgz; fi
if [ ! -e toppar_c36 ]; then tar -xzf toppar_c36.tgz; fi

charmm=`which charmm`
if [ $charmm ]; then
    printf "Found path to charmm binary CHARMMDIR = ${charmm:0:-7}\n"
    printf "Press ENTER to continue or specify path \n>>> "
else
    printf "Enter path to charmm binary i.e. \${CHARMMDIR}/charmm\n>>> "
fi
read rep; if [ $rep ]; then charmmdir=${rep}; else charmmdir=${charmm:0:-7}; fi
echo -e "* temp\n*\n\nstop" > tempi; $charmmdir/charmm < tempi > tempo; C=`grep CHARMM tempo | wc -l`
if [ $C == 3 ]; then
    export CHARMMDIR=${charmmdir}; echo -e "export CHARMMDIR=${charmmdir}" >> setenv
else
    echo "Incorrect path!!! please try again"; exit
fi; rm tempi tempo

exit
