
all:
	mix compile

release: all
	./relx --config config/relx.config

target:
	MIX_ENV=prod mix compile
	relx --config config/vagrant-relx.config -l $(NERVES_SDK_ROOT)/usr/lib/elixir/lib
	/home/vagrant/nerves-sdk/scripts/rel2fw.sh _rel

clean:
	mix clean
	-rm -fr _rel _images

.PHONY: clean

