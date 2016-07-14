#!/bin/sh
##
## compile_sdsl_c_polyhls.sh: This file is part of the CDSCmp project.
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
## @file: compile_sdsl_c_polyhls.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##



CC="$1";
shift 1;
CXXFLAGS="";
CFLAGS="-O3 -fopenmp -std=c99";

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
$ECHO_CMD "\033[36m[Poly-HLS] Compile $@ for FPGA\033[0m";

if [ "$opts" = "--dry-run" ]; then
    echo "=> dry-run: sdslc -b affine-c $1 -o $1.cpu.c";
    echo "=> dry-run: PolyRose $1.cpu.c -rose:C99   POLYHLS   -rose:skipfinalCompileStep -rose:o $1.cpu.opt.c";
    echo "=> dry-run: $CC $CXXFLAGS $CFLAGS $1.cpu.opt.c";
    exit 0;
fi;



if [ $# -lt 1 ]; then echo "Must provide one argument at least"; exit 1; fi;

filtername=`echo "$1" | sed -e 's/\(.*\)\.\(c\|cpp\)$/\1/g'`;
filter=`echo "$1" | cut -d . -f 1 | cut -d '_' -f 1`;
filter_generic=$filter"_sdsl";
filter_cpu=$filter"_cpu";
sed -e "s/$filter_generic/$filter_cpu/1" $1 > $filtername.cpu;
rm -f $filtername.cpu.c;
echo "=> execute: sdslc -b affine-c $1.cpu -o $filtername.cpu.c";
sdslc -b affine-c $filtername.cpu -o $filtername.cpu.c

if ! [ -f "$filtername.cpu.c" ]; then
    echo "[CPU compiler] Error: SDSL translator failed to produce output file";
    exit 1;
fi;

sed -e 's/void sdsl_program_\(.*\) {/__EXTERN__ void sdsl_program_\1 {/g' $filtername.cpu.c > __tmp_f; mv __tmp_f $filtername.cpu.c;




# ## Massage the number of parameters down.
# grep "const int sdsl_.*;" $filtername.cpu.c > __tmp_p;
# while read n; do
#     entry=`echo "$n" | sed -e 's/[ ]*\(.*\);/\1/g'`;
#     base=`echo "$entry" | cut -d '=' -f 1 | cut -d ' ' -f 3 | sed -e 's/ //g'`;
#     rep=`echo "$entry" | cut -d '=' -f 2 | sed -e 's/ //g'`;
#     sed -e "s/$base/$rep/g" $filtername.cpu.c > __tmp_2;
#     sed -e "s/const int $rep = $rep;/const int $base = $rep;/g" __tmp_2 > $filtername.cpu.c;
# done < __tmp_p;
# rm -f __tmp_p;

sed -e 's~// \[SDSL\] Begin array copies~int scop_limit=0;~g' $filtername.cpu.c > __tmp_2;
mv __tmp_2 $filtername.cpu.c;

## Compile reference CPU file.
#$CC $CFLAGS $CXXFLAGS -c $filtername.cpu.c


# PolyRose --polyopt-help;
# exit 1;

## Perform polyhedral optimization.
$ECHO_CMD "\033[36m[FPGA-poly compiler] Compile $filtername.cpu.c with PolyOpt/HLS\033[0m";
echo "=> execute: PolyHLS $filtername.cpu.c"
PolyHLS $filtername.cpu.c

