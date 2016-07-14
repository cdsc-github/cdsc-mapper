#!/bin/sh
##
## compile_sdsl_gpu.sh: This file is part of the CDSCmp project.
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
## @file: compile_sdsl_gpu.sh
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##


echo "[CDSC] Run $@ using Convey HC-1EX personality environment setting"

export CNY_PATH=/opt/convey
export CNY_PDK=/curr/diwu/app/convey_pdk
export CNY_PDK_REV=2011_11_22
export PATH=$PATH:$CNY_PATH/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CNY_PATH/lib
export CNY_PERSONALITY_PATH=/curr/diwu/prog/convey/pers
export CNY_PDK_PLATFORM=hc-1ex

$@
