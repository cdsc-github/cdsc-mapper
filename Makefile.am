##
## Makefile.am: This file is part of the CDSCmp project.
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
## @file: Makefile.am
## @author: Louis-Noel Pouchet <pouchet@cs.ucla.edu>
##

#############################################################################
SUBDIRS			=



#############################################################################
ACLOCAL_AMFLAGS		= -I config

CONFIGURE_DEPENDENCIES	=

# 	$(srcdir)/config/ax_boost.m4
# 	$(srcdir)/config/ax_boost_base.m4
# 	$(srcdir)/config/ax_pocc.m4

m4datadir		= $(datadir)/aclocal

AUX_DIST								= \
	$(ac_aux_dir)/config.guess					  \
	$(ac_aux_dir)/config.sub					  \
	$(ac_aux_dir)/install-sh					  \
	$(ac_aux_dir)/ltmain.sh						  \
	$(ac_aux_dir)/missing


EXTRA_DIST		=				\
	README						\
	install.sh					\
	driver/config/dist/driver.cfg			\
	driver/config/dist/configure.cfg		\
	driver/config/compiler.desc			\
	driver/scripts/cdscmp-alternate    		\
	driver/scripts/cdscmp-checkout     		\
	driver/scripts/cdscmp-compileproj  		\
	driver/scripts/cdscmp-make	    		\
	driver/scripts/cdscmp-util.in	    		\
	driver/scripts/compile_clean.sh	  		\
	driver/scripts/compile_polyhls.sh		\
	driver/scripts/compile_cncc.sh	  		\
	driver/scripts/compile_polyopt.sh		\
	driver/scripts/compile_c_polyopt.sh  		\
	driver/scripts/compile_sdsl_c_polyhls.sh	\
	driver/scripts/compile_cpp_cpu.sh	  	\
	driver/scripts/compile_sdsl_c_polyopt.sh	\
	driver/scripts/compile_cuda.sh	  		\
	driver/scripts/compile_sdsl_c.sh		\
	driver/scripts/compile_custom.sh	  	\
	driver/scripts/compile_sdsl_gpu.sh		\
	driver/scripts/compile_c_cpu.sh    		\
	driver/scripts/compile_hc_c.sh	  		\
	driver/scripts/run_program.sh			\
	driver/scripts/compile_c_fpga.sh   		\
	driver/scripts/compile_link.sh


MAINTAINERCLEANFILES	=			\
	Makefile.in				\
	aclocal.m4				\
	configure				\
	$(AUX_DIST)

dist-hook:
	(cd $(distdir) && mkdir -p $(ac_aux_dir))
	for file in $(AUX_DIST); do \
		cp $$file $(distdir)/$$file; \
	done


#############################################################################
