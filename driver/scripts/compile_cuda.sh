#!/bin/sh
##
## compile_cuda.sh: This file is part of the CDSCmp project.
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
## @file: compile_cuda.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


## First argument: the cuda compiler.
NVCC="$1";
shift 1;

NVCC_FLAGS="-gencode arch=compute_10,code=sm_10 -gencode arch=compute_11,code=sm_11 -gencode arch=compute_12,code=sm_12 -gencode arch=compute_13,code=sm_13 -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -w -O3 -Xcompiler -O3";

## Second argument (optional): the --dry-run options.
opts="";
if [ $# -gt 1 ] && [ "$1" = "--dry-run" ]; then
    opts=$1;
    shift;
fi;
## Argument left: anything else.

## Find the echo color command, if any.
ECHO_CMD="echo";
test_echo=`$ECHO_CMD -e "toto"`;
if [ "$test_echo" = "-e toto" ]; then
    ECHO_CMD="$ECHO_CMD";
else
    ECHO_CMD="$ECHO_CMD -e";
fi;
$ECHO_CMD "\033[36m[GPU compiler] Compile $@ to .o with nvcc\033[0m";


if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: $NVCC $NVCC_FLAGS $@";
    exit 0;
fi;


echo "=> execute: $NVCC $NVCC_FLAGS -c $@";
$NVCC $NVCC_FLAGS -c $newname.cu
