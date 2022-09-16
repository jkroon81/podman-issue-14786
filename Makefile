need-relabel := $(if $(wildcard .relabeled),,1)
volume-args := $(if $(need-relabel),:z)

all : test

test :
	strace -f --trace=lsetxattr --silence=attach,exit --signal=!SIGURG,SIGCHLD \
	  podman run --rm -v $(CURDIR)/dir:/dir/$(volume-args) registry.fedoraproject.org/fedora:35 /bin/bash -c "ls -alR /dir"
	if [ -n "$(need-relabel)" ]; then \
		touch .relabeled; \
	fi

.PHONY : test
