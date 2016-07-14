##
## configure.ac: This file is part of the CDSCmp project.
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
## @file: configure.ac
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##

AC_INIT([cdsc-mapper], [1.1-pre], [pouchet@cs.ucla.edu])
## A common file, which should be required by every action.
AC_CONFIG_SRCDIR([driver/config/compiler.desc])
## Put as most as possible configuration files to an auxialiry
## directory.
AC_CONFIG_AUX_DIR([driver/autoconf])
## Initialize automake. Here, a special tar version that enables
## (very) long filenames.
AM_INIT_AUTOMAKE([1.9 tar-ustar no-define foreign dist-bzip2])
#AM_INIT_AUTOMAKE([1.9 tar-ustar no-define foreign dist-bzip2 -Wall -Werror])


AC_PROG_CC
AC_PROG_CXX
AC_PROG_LIBTOOL
AC_PROG_INSTALL

## Check for some essential headers.
AC_HEADER_STDC
AC_CHECK_HEADERS([errno.h stddef.h stdlib.h string.h strings.h unistd.h])

## Check for some essential C properties.
AC_C_CONST
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_C_VOLATILE

AC_CHECK_PROGS(DOXYGEN, doxygen, doxygen)
AC_CHECK_PROGS(SVN,svn)
AC_CHECK_PROGS(GIT,git)
AC_CHECK_PROGS(AUTOCONF,autoconf)
AC_CHECK_PROGS(AUTOMAKE,automake)

AC_LANG(C++)



dnl Send the install prefix to cdscmp-util
install_prefix=$prefix


## Variable substitutions.
AC_SUBST([install_prefix])
AC_SUBST([ac_aux_dir])
AC_SUBST([ac_aux_dir])
AC_SUBST([abs_top_srcdir])

## Configure files
AC_CONFIG_FILES([driver/scripts/cdscmp-util], [chmod +x driver/scripts/cdscmp-util])
## Configure Makefiles
AC_CONFIG_FILES([
  Makefile
  ],
  [test -z "$CONFIG_HEADERS" || echo timestamp > driver/scripts/stamp-h.in; ])
## Output the result.
AC_OUTPUT
