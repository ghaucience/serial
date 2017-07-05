
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>

#include "common.h"
#include "log.h"

#include "io2tty.h"
#include "serial.h"



static  stIo2ttyEnv_t env = {
	.sdev = "/dev/ttyS1", 
	.sbuad = 115200,
	.sfd = -1,
};


int		io2tty_init(void *_th, void *_fet, const char *_dev, int _buad) {
	env.th = _th;
	env.fet = _fet;
	
	timer_init(&env.step_timer, io2tty_run);

	lockqueue_init(&env.msgq);


	/* serial */
	strcpy(env.sdev, _dev);
	env.sbuad = _buad;
	int ret =  serial_open(env.sdev, env.sbuad);
	if (ret < 0) {
		log_err("[%d] open serial %s(%d) error: %d", __LINE__, env.sdev, env.sbuad, ret);
		return -1;
	}
	env.sfd = ret;
  file_event_reg(env.fet, env.sfd, io2tty_serial_in, NULL, NULL);

	/* io */
  file_event_reg(env.fet, 0, io2tty_std_in, NULL, NULL);
	return 0;
}

int		io2tty_step() {
	timer_cancel(env.th, &env.step_timer);
	timer_set(env.th, &env.step_timer, 10);
	return 0;
}

int		io2tty_push_msg(int eid, void *param, int len) {
	if (eid == eid) {
		stEvent_t *e = MALLOC(sizeof(stEvent_t));
		if (e == NULL) {
			 return -1;
		}
		e->eid = eid;
		e->param = param;
		lockqueue_push(&env.msgq, e);
		io2tty_step();
	}
	return 0;
}

void	io2tty_run(struct timer *timer) {
	stEvent_t *e = NULL;
	if (lockqueue_pop(&env.msgq, (void **)&e) && e != NULL) {
		io2tty_handler_event(e);
		FREE(e);
		io2tty_step();
	}
}

int io2tty_handler_event(stEvent_t *event) {
	log_info("[%d] io2tty module now not support event handler, only free the event!!!", __LINE__);
	return 0;
}



void	io2tty_std_in(void *arg, int fd) {
	char buf[1024];

	int ret = read(0, buf, sizeof(buf));
	if (ret <= 0) {
		log_warn("what happend?");
		return;
	}

	int size = ret;
	buf[size] = 0;

	serial_write(env.sfd, buf, size, 80);

	log_debug(">$");
}

void	io2tty_serial_in(void *arg, int fd) {
	char buf[1024];
	int ret = serial_read(env.sfd, buf, sizeof(buf), 80);
	if (ret <= 0) {
		log_warn("[%d] can't recv any bytes from serial : %d", __LINE__, ret);
		return;
	}

	buf[ret] = 0;
	log_info("%s", buf);
	return;
}







