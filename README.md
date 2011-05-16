# osmake

	git clone git://github.com/20main/osmake.git
	cd osmake

## Usage:

### At first

You can do

	make build

This will sync with the latest sources and compile them.

Then, to install

	make install dir=/path/to/destination

Those 2 actions can be run directly like this

	make build install dir=/path/to/destination

Other options available are 'user' and 'group' to specify the user and group owner of the files, then you will need to use sudo.

For example:

	make build
	sudo make install dir=/home/opensim/sim1 user=opensim group=staff

### Other actions available

Clean the source tree

	make clean

Clean and update the source tree

	make update

Update, build and install

	make upgrade dir=/path/to/destination

