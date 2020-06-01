#ifndef __IO2TTY_H_
#define __IO2TTY_H_

#include "timer.h"
#include "file_event.h"
#include "lockqueue.h"


typedef enum emIo2ttyMsg{
	IE_NONE = 0x00,
}emIo2ttyMsg_t;


typedef struct stIo2ttyEnv {
	struct file_event_table *fet;
	struct timer_head *th;
	struct timer step_timer;

	stLockQueue_t msgq;


	char	sdev[64];
	int		sbuad;
	int		sfd;

}stIo2ttyEnv_t;




int		io2tty_init(void *_th, void *_fet, const char *_dev, int _buad);
int		io2tty_push_msg(int eid, void *param, int len);

int		io2tty_step();
void	io2tty_run(struct timer *timer);
void	io2tty_serial_in(void *arg, int fd);
void	io2tty_std_in(void *arg, int fd);
int		io2tty_handler_event(stEvent_t *event);










#endif
