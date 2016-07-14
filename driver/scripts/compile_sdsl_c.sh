#!/bin/sh
##
## compile_sdsl_c.sh: This file is part of the CDSCmp project.
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
## @file: compile_sdsl_c.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


CXX="$1";
shift 1;

opts="";
if [ $# -gt 1 ] && [ "$1" = "--dry-run" ]; then
    opts=$1;
    shift;
fi;

echo "[SDSL-CPU compiler] Compile $@ to CPU code using $CXX"

CXXFLAGS="";
CFLAGS="-O3 -lm";


if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: sdslc -b affine-c $1.cpu -o $1.cpu.cpp";
    echo "=> dry-run: $CXX $CFLAGS $CXXFLAGS -c $1.cpu.cpp";
    exit 0;
fi;


filter=`echo "$1" | cut -d . -f 1 | cut -d '_' -f 1`;
filter_generic=$filter"_sdsl";
filter_cpu=$filter"_cpu";
sed -e "s/$filter_generic/$filter_cpu/1" $1 > $1.cpu;
echo "=> execute: sdslc -b affine-c $1.cpu -o $1.cpu.cpp";
sdslc -b affine-c $1.cpu -o $1.cpu.cpp
sed -e 's/void sdsl_program_\(.*\) {/__EXTERN__ void sdsl_program_\1 {/g' $1.cpu.cpp > __tmp_f; mv __tmp_f $1.cpu.cpp;
echo "=> execute: $CXX $CFLAGS $CXXFLAGS -c $1.cpu.cpp";
$CXX $CFLAGS $CXXFLAGS -c $1.cpu.cpp
