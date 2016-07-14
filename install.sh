#!/bin/sh
##
## install.sh: This file is part of the CDSCmp project.
##
## CDSCmp: A compiler suite for software mapping on heterogeneous
## architectures
##
## Copyright (C) 2012,2013 University of California Los Angeles
##
## This program can be redistributed and/or modified under the terms
## of the license specified in the LICENSE.txt file at the root of the
## project.
##
## Contact: Jason Cong <cong@cs.ucla.edu>
##
##
## @file: install.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##

echo "[CDSCmp] Report any install problem to pouchet@cs.ucla.edu";
echo "[CDSCmp] The default GCC and G++ version on the system must be 4.1, 4.2, 4.3";
echo "         or 4.4. The install will fail otherwise.";
echo "[CDSCmp] Continue the installation process? [y/N]";
read n;
if [ "$n" != "Y" ] && [ "$n" != "y" ]; then
    echo "[CDSCmp] exiting...";
    exit 1;
fi;
echo "[CDSCmp] Some packages are required: ps2pdf, doxygen, texinfo, libxml2, ";
echo "         libxml2-dev, make, perl, automake, autoconf, libtool and maybe more";
echo "[CDSCmp] A working version of Sun Java JDK (version 1.6 or 1.7) is required."
echo "         The variable JAVA_HOME must be correctly set.";
echo "[CDSCmp] Continue the installation process? [y/N]";
read n;
if [ "$n" != "Y" ] && [ "$n" != "y" ]; then
    echo "[CDSCmp] exiting...";
    exit 1;
fi;
echo "[CDSCmp] If the installation fails, refer to the manual for troubleshooting.";

## Bootstrap only in developer mode.
if [ -d driver/config/base ]; then
    echo "[CDSCmp] Bootstrapping...";
    ./bootstrap.sh
    ret="$?";
    if [ "$ret" -ne 0 ]; then exit $ret; fi;
fi;
echo "[CDSCmp] Configuring...";
./configure --prefix=`pwd`;
ret="$?";
if [ "$ret" -ne 0 ]; then exit $ret; fi;
echo "[CDSCmp] Build modules...";
touch ./driver/config/env.sh;
## Set up the good configuration files.
if [ $# -eq 0 ]; then
    cp driver/config/dist/driver.cfg driver/config
    cp driver/config/dist/configure.cfg driver/config
else
    if ! [ -d driver/config/base ]; then
	echo "[CDSCmp] Developer mode not accessible in the public release";
	exit 1;
    fi;
    cp driver/config/base/driver.cfg driver/config
    cp driver/config/base/configure.cfg driver/config
fi;
## Checkout all modules.
./driver/scripts/cdscmp-util --checkout;
ret="$?";
if [ "$ret" -ne 0 ]; then exit $ret; fi;
## Build all modules.
./driver/scripts/cdscmp-util --make;
ret="$?";
if [ "$ret" -ne 0 ]; then exit $ret; fi;
echo "[CDSCmp] A variable named CUDA_HOME, pointing to the CUDA main directory";
echo "         should be exported in your environment, if you want to use GPUs";
