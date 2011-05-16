repo   ?= git://github.com/francogrid/sim.git
dir    ?= opensim
bindir := $(dir)/bin
etcdir := $(dir)/etc
user   ?= $(shell id -nu)
group  ?= $(user)
NANT    = $(strip $(shell which nant 2>/dev/null))

build: prebuild
	@cd sources; ${NANT}
	@cd sources; find OpenSim -name \*.mdb -exec cp {} bin \;

all: build install

prebuild:
	@if ! test -d "sources"; then echo "### osmake initialization ###"; \
		git remote add -f opensim $(repo); \
		git merge -s ours --no-commit opensim/master; \
		git read-tree --prefix=sources -u opensim/master; \
		git commit -m "Merge branch 'master' of $(repo) in sources/ directory."; \
	fi
	@cd sources; ./runprebuild.sh

clean:
	@cd sources; ${NANT} clean

install:
	@if ! test -d "$(dir)"; then mkdir -p $(dir); fi
	@if ! test -w "$(dir)"; then \
		echo "ERROR: can't write in $(dir), permission denied."; exit 1; \
	fi
	@if ! test -d "$(etcdir)"; then mkdir $(etcdir); fi
	@cd sources; tar cf - bin | tar xf - -C $(dir)
	@tar cf - etc | tar xf - -C $(dir)
ifneq ("$(user)", "$(shell id -nu)")
	@chown -R $(user):$(group) $(dir)/*
endif
	@echo "####### Installation complete #######"
	@echo "# installation path: $(dir)"
	@echo "#              user: $(user)"
	@echo "#             group: $(group)"

update: clean
	@git pull -s subtree opensim master

upgrade: update build install

