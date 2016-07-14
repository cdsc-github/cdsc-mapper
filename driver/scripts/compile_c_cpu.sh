#!/bin/sh
##
## compile_c_cpu.sh: This file is part of the CDSCmp project.
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
## @file: compile_c_cpu.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##



CC="$1";
shift 1;
CXXFLAGS="";
CFLAGS="-O3 -I. -I$CNCC_HOME/include -I$HC_HOME/include/hc -fopenmp -std=c99";

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
$ECHO_CMD "\033[36m[$CC compiler] Compile $@ to standard CPU code\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: $CC $CXXFLAGS $CFLAGS -c $@";
    exit 0;
fi;

$CC $CXXFLAGS $CFLAGS -c $@;
