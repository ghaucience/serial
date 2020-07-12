ROOTDIR=$(shell pwd)
WORKDIR=$(ROOTDIR)/build

targets	 += serial pppcmd
#targets	 += pppcmd

.PHONY: targets

all : $(targets)


srcs							:= $(ROOTDIR)/main.c

srcs							+= $(ROOTDIR)/src/ayla/log.c
srcs							+= $(ROOTDIR)/src/ayla/lookup_by_name.c
srcs							+= $(ROOTDIR)/src/ayla/timer.c
srcs							+= $(ROOTDIR)/src/ayla/time_utils.c
srcs							+= $(ROOTDIR)/src/ayla/assert.c
srcs							+= $(ROOTDIR)/src/ayla/file_event.c
srcs							+= $(ROOTDIR)/src/ayla/file_io.c
srcs							+= $(ROOTDIR)/src/ayla/hashmap.c
srcs							+= $(ROOTDIR)/src/ayla/parse_argv.c
srcs							+= $(ROOTDIR)/src/ayla/hex.c

srcs							+= $(ROOTDIR)/product/serial/src/io2tty.c
srcs							+= $(ROOTDIR)/product/serial/src/serial.c

srcs							+= $(ROOTDIR)/src/lockqueue.c
srcs							+= $(ROOTDIR)/src/mutex.c
srcs							+= $(ROOTDIR)/src/cond.c
srcs							+= $(ROOTDIR)/src/list.c

objs = $(subst $(ROOTDIR),$(WORKDIR), $(subst .c,.o,$(srcs)))

pppcmdsrcs	:= $(ROOTDIR)/product/serial/src/serial.c
pppcmdsrcs  += $(ROOTDIR)/pppcmd.c
pppcmdsrcs  += $(ROOTDIR)/src/ayla/log.c
pppcmdsrcs	+= $(ROOTDIR)/src/ayla/lookup_by_name.c
pppcmdobjs 	:= $(subst $(ROOTDIR),$(WORKDIR), $(subst .c,.o,$(pppcmdsrcs)))

-include $(ROOTDIR)/make/arch.mk
-include $(ROOTDIR)/make/rules.mk

$(eval $(call LinkApp,serial,$(objs)))
$(eval $(call LinkApp,pppcmd,$(pppcmdobjs)))


scp:
	scp -P 2205 ./build/serial root@192.168.0.230:/root
