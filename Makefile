# ****************************************************************************
# ****************************************************************************
# Copyright SoC Design Research Group, All rights reserved.
# Electronics and Telecommunications Research Institute (ETRI)
# 
# THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
# WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
# TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
# REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
# SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
# IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
# COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
# ****************************************************************************
# 2020-10-29
# Kyuseung Han (han@etri.re.kr)
# ****************************************************************************
# ****************************************************************************

-include ./rvx_each.mh
include ./rvx_init.mh
-include ./rvx_install/rvx_install.mh

RVX_DEVKIT_HOME?= ./rvx_devkit
-include ${RVX_DEVKIT_HOME}/makefile/rvx_home.mh

RVX_INSTALL_MODULE_LIST ?= rvx_util rvx_binary rvx_synthesizer rvx_devkit rvx_ssw rvx_hwlib_basic rvx_platform_example rvx_imp_class xarvis
export RVX_INSTALL_MODULE_LIST
