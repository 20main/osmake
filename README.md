# osmake

	git clone git://github.com/20main/osmake.git
	cd osmake

## Dependencies

	aptitude install make sudo mono-complete nant

## Usage:

### At first

You can do

	make build

This will sync with the latest sources and compile them.

Then, to install

	make install dir=/path/to/destination

Multiple install can be done, for example

	make install dir=/home/opensim/sim1
    make install dir=/home/opensim/sim2
    make install dir=/home/opensim/sim3

The actions of building and installing can be run in one command

	make build install dir=/path/to/destination

Other options available are 'user' and 'group' to specify the user and group owner of the files, in this case you will need to use sudo.
If user is provided without group, the group will be the same as user.

For example:

	make build
	sudo make install dir=/home/opensim/sim1 user=opensim group=staff

Sources origin defaults to git://github.com/francogrid/sim.git, you can choose another repo with 'repo' option, i.e.

	make build repo=git://opensimulator.org/git/opensim

### Other actions available

Clean the source tree

	make clean

Clean and update the source tree

	make update

Update, build and install

	make upgrade dir=/path/to/destination

