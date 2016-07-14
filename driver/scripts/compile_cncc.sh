#!/bin/sh
##
## compile_cncc.sh: This file is part of the CDSCmp project.
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
## @file: compile_cncc.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##



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
$ECHO_CMD "\033[36m[CnC-to-HC] Compiling $1\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: cncc_t -full-auto $1";
    exit 0;
fi;

if [ "$opts" = "--fake-cncc" ]; then
    echo "=> fake-execute: cncc_t -full-auto $1";
    exit 0;
fi;


## Default behavior
echo "=> execute: cncc_t -full-auto $1";
rm -f Context.c Main.hc Common.hc Dispatch.hc Dispatch.h Common.h Context.h
cncc_t -full-auto $1;
