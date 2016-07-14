#!/bin/sh
##
## compile_polyopt.sh: This file is part of the CDSCmp project.
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
## @file: compile_polyopt.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##



## Find the echo color command, if any.
ECHO_CMD="echo";
test_echo=`$ECHO_CMD -e "toto"`;
if [ "$test_echo" = "-e toto" ]; then
    ECHO_CMD="$ECHO_CMD";
else
    ECHO_CMD="$ECHO_CMD -e";
fi;

## Perform polyhedral optimization.
$ECHO_CMD "\033[36m[PolyOpt] Compile PolyOpt/C $@\033[0m";
echo "=> execute: PolyRose  -rose:C99 $CDSCMP_SDSL_C_POLYOPT_USER_OPTIONS $@ ";
PolyRose  -rose:C99 $CDSCMP_SDSL_C_POLYOPT_USER_OPTIONS $@;
if [ $? -ne 0 ]; then
    $ECHO_CMD "\033[36m[PolyOpt] Error with Compile PolyOpt/C $@\033[0m";
    exit 1;
fi;

