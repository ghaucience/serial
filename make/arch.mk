#/opt/au/qca/qsdk/staging_dir/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/
#CROSSTOOLDIR :=/opt/au/qca/qsdk
#/opt/ysy/openwrt/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_glibc-2.21/bin/mipsel-openwrt-linux-
#CROSSTOOLDIR :=/opt/au/openwrt_7620/
#CROSSTOOLDIR 				:= /opt/dyx/openwrt

#CROSSTOOLDIR :=/opt/ysy/openwrt/
#export	STAGING_DIR	:= $(CROSSTOOLDIR)/staging_dir
#export	PATH :=$(PATH):$(STAGING_DIR)/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin/
#export	PATH :=$(PATH):$(STAGING_DIR)/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_glibc-2.21/bin
export  STAGING_DIR := $(CROSSTOOLDIR)/staging_dir
export  PATH 				:=$(PATH):$(STAGING_DIR)/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_glibc-2.21/bin

#ARCH								:= ARM
ARCH								:= MT7620

ifeq ($(ARCH),MT7620)
CROSSTOOLDIR 				:= /home/au/all/gwork/openwrt
CROSS   						:= mipsel-openwrt-linux-
export  STAGING_DIR := $(CROSSTOOLDIR)/staging_dir
export  PATH 				:= $(PATH):$(STAGING_DIR)/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin
CROSS_CFLAGS				:= -I$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/usr/include
CROSS_CFLAGS				+= -I$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/usr/include
CROSS_LDFLAGHS			:= -L$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/usr/lib
CROSS_LDFLAGHS			+= -L$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/usr/lib/ 

#CROSSTOOLDIR 				:= /home/au/all/gwork/MT7688/openwrt
#export  STAGING_DIR := $(CROSSTOOLDIR)/staging_dir
#export  PATH 				:=$(PATH):$(STAGING_DIR)/toolchain-mipsel_24kc_gcc-7.4.0_musl/bin
#CROSS_CFLAGS				:= -I$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kc_gcc-7.4.0_musl/usr/include
#CROSS_CFLAGS				+= -I$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kc_musl/usr/include
#CROSS_LDFLAGHS			:= -L$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kc_gcc-7.4.0_musl/usr/lib
#CROSS_LDFLAGHS			+= -L$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kc_musl/usr/lib

endif

ifeq ($(ARCH),ARM)
#CROSSTOOLDIR 				:=/opt/au/tmp/ember_for_arm
CROSSTOOLDIR 				:=/home/au/all/gwork/tmp/ember_for_arm
export  STAGING_DIR := $(CROSSTOOLDIR)/4.9.3/staging_dir
export  PATH 				:=$(PATH):$(CROSSTOOLDIR)/4.9.3/bin

#CROSS_CFLAGS			:= -I$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/usr/include
#CROSS_CFLAGS			+= -I$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kec+dsp_glibc-2.21/usr/include
#CROSS_LDFLAGHS		:= -L$(CROSSTOOLDIR)/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/usr/lib
#CROSS_LDFLAGHS		+= -L$(CROSSTOOLDIR)/staging_dir/target-mipsel_24kec+dsp_glibc-2.21/usr/lib
CROSS_CFLAGS			:= -I$(CROSSTOOLDIR)/root-arm/usr/local/include
CROSS_LDFLAGHS		:= -L$(CROSSTOOLDIR)/root-arm/usr/local/lib

MAKE	:= make
endif





CROSS 	?= mipsel-openwrt-linux-
#CROSS   ?= arm-cortexa9-linux-gnueabihf-

#CROSS 	?= mipsel-openwrt-linux-
#ARCH		?= mips

GCC 		?= $(CROSS)gcc
CXX			?= $(CROSS)g++
AR			?= $(CROSS)ar
AS			?= $(CROSS)gcc
RANLIB	?= $(CROSS)ranlib
STRIP 	?= $(CROSS)strip
OBJCOPY	?= $(CROSS)objcopy
OBJDUMP ?= $(CROSS)objdump
SIZE		?= $(CROSS)size
LD			?= $(CROSS)ld
MKDIR		?= mkdir -p


TARGET_CFLAGS 		+= -Wall -g -O2 -I$(ROOTDIR)/inc -I$(ROOTDIR)/inc/ayla -I$(ROOTDIR)/platform -I$(ROOTDIR)/product/serial/inc 

TARGET_CXXFLAGS 	+= $(TARGET_CFLAGS) -std=c++0x

#TARGET_LDFLAGS 		+= -L$(ROOTDIR)/lib -lm -lrt -ldl -lpthread -lubus -lblobmsg_json -lubox
TARGET_LDFLAGS 		+= -L$(ROOTDIR)/lib -lm -lrt -ldl -lpthread
#TARGET_LDFLAGS 	+= -L/usr/lib/ -ljansson
#TARGET_LDFLAGS		+= -lstdc++

