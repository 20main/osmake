# osmake

	git clone git://github.com/20main/osmake.git
	cd osmake

## Dependencies

	aptitude install make sudo mono-complete nant

## Usage:

### At first

Get the the latest sources available and compile them:

	make

Install in the directory of your choice:

	make install dir=/path/to/destination

Multiple install can be done like this:

	make install dir=/home/opensim/sim1
    make install dir=/home/opensim/sim2
    make install dir=/home/opensim/sim3

If you want to build and install in one line:

	make && make install dir=/path/to/destination

### Next

Other options available are 'user' and 'group' to specify the user and group owner of the files, in this case you will need to use sudo.
If user is provided without group, the group will be the same as user.

For example:

	sudo make install dir=/home/opensim/sim1 user=opensim group=staff

If you don't want to compile each time, and just want to see if there is updates available, run

	make update

then if you want to compile sources because they have been updated by the previous command, you can do

	make build
	make install dir=/path/to/destination

### Repository

Sources origin defaults to git://github.com/francogrid/sim.git, you can choose another repo with 'repo' option, i.e.

	make repo=git://opensimulator.org/git/opensim

