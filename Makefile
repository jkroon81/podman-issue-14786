all : test

test :
	strace -f --trace=lsetxattr --silence=attach,exit --signal=!SIGURG,SIGCHLD \
	  podman run --rm -v $(CURDIR)/dir:/dir/:z registry.fedoraproject.org/fedora:35 /bin/bash -c "ls -alR /dir"

.PHONY : test
