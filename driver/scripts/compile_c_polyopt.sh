#!/bin/sh
##
## compile_c_polyopt.sh: This file is part of the CDSCmp project.
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
## @file: compile_c_polyopt.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##



CC="$1";
shift;
CXXFLAGS="";
CFLAGS="-O3 -fopenmp -std=c99";

opts="";
if [ $# -gt 1 ] && [ "$1" = "--dry-run" ]; then
    opts=$1;
    shift;
fi;
## Find the echo color command, if any.
ECHO_CMD="echo";
test_echo=`$ECHO_CMD -e "toto"`;
if [ "$test_echo" = "-e toto" ]; then
    ECHO_CMD="$ECHO_CMD";
else
    ECHO_CMD="$ECHO_CMD -e";
fi;
$ECHO_CMD "\033[36m[SDSL-CPU compiler] Compile $@ to optimized CPU code\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: PolyRose $CDSCMP_SDSL_C_POLYOPT_USER_OPTIONS $1.cpu.c -rose:C99 --polyopt-pocc-verbose --polyopt-scalar-privatization --polyopt-safe-math-func  --polyopt-fixed-tiling   -rose:skipfinalCompileStep -rose:o $1.cpu.opt.c";
    echo "=> dry-run: $CC $CXXFLAGS $CFLAGS $1.cpu.opt.c";
    exit 0;
fi;


## Perform polyhedral optimization.
$ECHO_CMD "\033[36m[CPU-poly compiler] Compile $@ with PolyOpt/C\033[0m";
echo "=> execute: PolyRose $1 -rose:C99 $CDSCMP_SDSL_C_POLYOPT_USER_OPTIONS --polyopt-pocc-verbose --polyopt-scalar-privatization --polyopt-safe-math-func  --polyopt-parallel-only -rose:skipfinalCompileStep -rose:o $1.polyopt.c";
PolyRose $1 -rose:C99 $CDSCMP_SDSL_C_POLYOPT_USER_OPTIONS --polyopt-pocc-verbose --polyopt-scalar-privatization --polyopt-safe-math-func  --polyopt-parallel-only -rose:skipfinalCompileStep -rose:o $1.polyopt.c;

if [ -f "$1.polyopt.c" ]; then
    ## Compile the optimized file.
    echo "=> execute: $CC $CXXFLAGS $CFLAGS $1.polyopt.c";
    $CC $CFLAGS $CXXFLAGS -c $1.polyopt.c;
else
    echo "[CPU-only compiler] Error: PolyOpt/C failed to produce optimized output";
    exit 1;
fi;
