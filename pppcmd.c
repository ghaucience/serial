#include <stdio.h>
#include <string.h>

const char *ctrlport = "/dev/ttyUSB0";

static int write_ctrl_cmd(char *_cmd, int timeout) {
	//printf("%s\n", ctrlport);
	int fd = serial_open(ctrlport, 115200);
	if (fd < 0) {
		//printf("open ctrl port %s failed\n", ctrlport);
		return -1;
	}

	char cmd[512];
	sprintf(cmd, "%s\r\n", _cmd);
	int ret = serial_write(fd, cmd, strlen(cmd), 80);
	if (ret < 0) {
		//printf("write ctrl cmd %s failed\n", cmd);
		serial_close(fd);
		return -2;
	}
	//printf("write [%s] ok!\n", cmd);

	char buf[512];
	ret = serial_read(fd, buf, sizeof(buf), 4080);
	serial_close(fd);
	if (ret < 0) {
		//printf("wait ctrl ret failed!\n");
		return -3;
	}
	buf[ret] = 0;

	//printf("[RECV]: <%s>\n", buf);
	printf("%s\n", buf);
	
	return 0;
}

int main(int argc, char *argv[]) {

	ctrlport = (char *)argv[1];

	char *cmd = argv[2];

	int timeout = 4080;
	if (argc >= 4) {
		timeout = atoi(argv[3]);
	}

	//return write_ctrl_cmd((char *)argv[2], );
	return write_ctrl_cmd(cmd, timeout);
}
