#!/bin/sh
##
## compile_hc_c.sh: This file is part of the CDSCmp project.
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
## @file: compile_hc_c.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


## Some globals...
context=Contex
dispatch=Dispatch
main=Main
common=Common

HCC=hcc
GCC=gcc

## Get the mode (cnc or cdscgl)
MODE="$1";
shift 1;
if [ "$MODE" = "cnc" ]; then
    CFLAGS="-O3 -I$CNCC_HOME/include -I$HC_HOME/include/hc -I.";
else 
    if [ "$MODE" = "cdscgl" ]; then
	CFLAGS="-O3 -I$CDSCGLTOHC_HOME/include -I$HC_HOME/include/hc -I.";
    fi;
fi;
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
$ECHO_CMD "\033[36m[Habanero-C] Compiling $@ (mode=$MODE)\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: $GCC $CFLAGS -c Context.c";
    echo "=> dry-run: $GCC $CFLAGS -c Context.c";
    echo "=> dry-run: $HCC $CFLAGS -c $main.hc $common.hc $@";
    exit 0;
fi;


## Default behavior
## 1. Pre-compile context/main
echo "=> execute: $GCC $CFLAGS -c Context.c";
$GCC $CFLAGS -c Context.c
echo "=> execute: $GCC $CFLAGS -c Context.c";
$HCC $CFLAGS -c Dispatch.hc

## 2. Compile all hc files into .o
echo "=> execute: $HCC $CFLAGS -c $main.hc $common.hc $@";
$HCC $CFLAGS -c $main.hc $common.hc $@

