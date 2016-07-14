#!/bin/sh
##
## compile_custom.sh: This file is part of the CDSCmp project.
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
## @file: compile_custom.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


## First argument (optional): the --dry-run options.
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
$ECHO_CMD "\033[36m[CDSCmp] execute $@\033[0m";


if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: $@";
    exit 0;
fi;


echo "=> execute: $@";
$@;

