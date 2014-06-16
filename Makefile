
all:
	./rebar get-deps compile

release: all
	./relx

# designed to be run from the Vagrant environment
# source ~/nerves-sdk/nerves-env.sh before executing
target: all
	relx --config relx-vagrant.config --system_libs $$NERVES_SDK_SYSROOT/usr/lib/erlang/lib
	/home/vagrant/nerves-sdk/scripts/rel2fw.sh _rel

clean:
	./rebar clean
	-rm -fr _rel _images

.PHONY: clean
