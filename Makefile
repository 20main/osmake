PREFIX ?= /opt/opensim
BINDIR := $(PREFIX)/bin
OWNER  ?= $(shell id -nu)
NANT    = $(strip $(shell which nant 2>/dev/null))

build: prebuild
	@cd sim; ${NANT}
	@cd sim; find OpenSim -name \*.mdb -exec cp {} bin \;

prebuild:
	@if ! test -d "sim"; then echo "### osmake initialization ###"; \
		git remote add -f sim git://github.com/francogrid/sim.git; \
		git merge -s ours --no-commit sim/master; \
		git read-tree --prefix=sim -u sim/master; \
		git commit -m "Merge francogrid's sim repo in sim/ directory."; \
	fi
	@cd sim; ./runprebuild.sh

clean:
	@cd sim; ${NANT} clean

install: 
	@if ! test -d "$(BINDIR)"; then mkdir -p $(BINDIR); fi
	@cd sim; tar cf - bin | tar xf - -C $(PREFIX)
	@tar cf - etc | tar xf - -C $(PREFIX)
	#chown -R ${OWNER}:${OWNER} $(PREFIX)/bin
	@echo "Installation path: ${PREFIX}"
	@echo "Owner: ${OWNER}"

update: clean
	@git pull -s subtree sim master
