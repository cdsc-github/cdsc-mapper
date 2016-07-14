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
$ECHO_CMD "\033[36m[CDSCmp] clean generated files\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: clean files for steps $@";
    exit 0;
fi;

step="_step";
## Clean all possibly generated files.
for i in $@; do
    rm -f $i.hc;
    rm -f $i.o;
    rm -f $i$step.c.cu;
    rm -f $i$step.c.gpu.o;
    rm -f $i$step.c.gpu.cpp;
    rm -f $i$step.cpu;
    rm -f $i$step.cpu.c;
    rm -f $i$step.cpu.opt.c;
    rm -f $i$step.cpu.opt.o;
    rm -f rose_$i.c;
done;
## Clean CnC-related files.
rm -f Common.h Common.o Common.hc
rm -f Context.h Context.o Context.hc
rm -f Dispatch.h Dispatch.o Dispatch.hc
rm -f Main.hc Main.o
## Clean polyopt-related files.
rm -f .pragmas .vectorize .unroll .fst


