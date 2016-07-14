#!/bin/sh
##
## compile_c_fpga.sh: This file is part of the CDSCmp project.
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
## @file: compile_c_fpga.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##




echo "[PolyOpt/HLS] Compiling  $1 for FPGA optimization..."

which PolyRose;

echo "[ERROR] NOT SUPPORTED NOW. Use sdsl-fpga instead";
exit 1;

PolyRose -I/usr/lib/gcc/x86_64-linux-gnu/4.6/include -I. -Ihls_ap_test_suite/api --polyopt-HLS-enable --polyopt-HLS-lmp --polyopt-HLS-autopilot --polyopt-HLS-autopilot-fifo --polyopt-HLS-autopilot-fifo-simu -DLNP_TEST --polyopt-safe-math-func --polyopt-pluto-tile --polyopt-HLS-max-buff-size-per-array=200000 $1 --polyopt-pluto-prevectorsd --polyopt-pluto-fuse-maxfusesd --polyopt-pocc-verbose --polyopt-scop-extractor-verbose=5 -DLNP_HACK_ROSE;



## 0. prepare file for polyopt

## 1. run polyopt/hls on the file

## 2. run AP

## 3. Generate bitstream

## 4. Generate CPU driver code.

## 5. Compile and link.
