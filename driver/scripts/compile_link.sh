#!/bin/sh
##
## compile_link.sh: This file is part of the CDSCmp project.
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
## @file: compile_link.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


CXX=$1;
shift 1;
opts="";
if [ $# -gt 1 ] && [ "$1" = "--dry-run" ]; then
    opts=$1;
    shift;
fi;
## Find the echo color command, if any.
#if test -f "/bin/echo"; then ECHO_CMD="/bin/echo"; else ECHO_CMD="echo"; fi;
ECHO_CMD="echo";
test_echo=`$ECHO_CMD -e "toto"`;
if [ "$test_echo" = "-e toto" ]; then
    ECHO_CMD="$ECHO_CMD";
else
    ECHO_CMD="$ECHO_CMD -e";
fi;
$ECHO_CMD "\033[36m[CDSCmp Linker] Link *.o files into $1\033[0m";



#CXX=cnycc
#CXX=gcc
CFLAGS="-O3 -I$CNCC_HOME/include -I$HC_HOME/include/hc -I. -fopenmp";

if [ -z  "$CUDA_HOME" ]; then
    $ECHO_CMD "\033[36m[CDSCmp Linker] CUDA_HOME not set. Defaulting to /usr/local/cuda.\033[0m";
    CUDA_HOME="/usr/local/cuda";
fi;

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: $CXX $CFLAGS -L$HC_HOME/lib -L$CUDA_HOME/lib64 $CNCC_HOME/lib/DataDriven.o -lhc -lxml2 -lpthread *.o -o $1 -lcuda -lcudart -Xlinker -z -Xlinker muldefs";
    exit 0;
fi;

export CNY_PATH=/opt/convey
export CNY_PDK=/curr/diwu/app/convey_pdk
export CNY_PDK_REV=2011_11_22
export PATH=$PATH:$CNY_PATH/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CNY_PATH/lib
export CNY_PERSONALITY_PATH=/curr/diwu/prog/convey/pers
export CNY_PDK_PLATFORM=hc-1ex

$CXX $CFLAGS -L"$HC_HOME/lib" -L$CUDA_HOME/lib64 $CNCC_HOME/lib/DataDriven.o -lhc -lxml2 -lpthread *.o -o $1 -lcuda -lcudart -Xlinker -z -Xlinker muldefs    -L/usr/lib/gcc/x86_64-redhat-linux/4.1.2 -lgomp;
if [ $? -ne 0 ]; then
    echo "[CDSCmp Linker] Trying without CUDA...";
    val=`$CXX $CFLAGS -L"$HC_HOME/lib" -L$CUDA_HOME/lib64 $CNCC_HOME/lib/DataDriven.o -lhc -lxml2 -lpthread *.o -o $1  -Xlinker -z -Xlinker muldefs    -L/usr/lib/gcc/x86_64-redhat-linux/4.1.2 -lgomp`;
fi;
