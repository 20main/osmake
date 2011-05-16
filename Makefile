repo ?= git://github.com/francogrid/sim.git
dir ?= 
user ?= $(shell id -nu)
group ?= $(user)

dirpath := $(shell echo $(dir) | grep -E '^/.*' || echo $(PWD)/$(dir))
bindir := $(dirpath)/bin
etcdir := $(dirpath)/etc
NANT = $(strip $(shell which nant 2>/dev/null))

build: prebuild
	@cd sources; ${NANT}
	@cd sources; find OpenSim -name \*.mdb -exec cp {} bin \;

prebuild: init
	@cd sources; ./runprebuild.sh

clean:
	@cd sources; ${NANT} clean

install: test-param-dir
	@if ! test -d "$(dirpath)"; then mkdir -p $(dirpath); fi
	@if ! test -w "$(dirpath)"; then \
		echo "Can't write to $(dirpath), permission denied."; exit 1; \
	fi
	@if ! test -d "$(etcdir)"; then mkdir $(etcdir); fi
	@cd sources; tar cf - bin | tar xf - -C $(dirpath)
	@tar cf - etc | tar xf - -C $(dirpath)
ifneq ("$(user)", "$(shell id -nu)")
	@chown -R $(user):$(group) $(dirpath)/*
endif
	@echo "### INSTALLATION COMPLETE ###"
	@echo "# installation path: $(dirpath)"
	@echo "#              user: $(user)"
	@echo "#             group: $(group)"

update: init clean
	@git pull -s subtree opensim master

init:
	@if ! test -d "sources"; then echo "### osmake initialization ###"; \
		git remote add -f opensim $(repo); \
		git merge -s ours --no-commit opensim/master; \
		git read-tree --prefix=sources -u opensim/master; \
		git commit -m "Merge branch 'master' of $(repo) in sources/ directory."; \
	fi

test-param-dir:
ifeq ($(dir),)
	@echo "You must provide a destination: dir=<path>"
	@exit 1
endif

all: update build

upgrade: test-param-dir update build install

