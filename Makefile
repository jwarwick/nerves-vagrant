
all:
	./rebar get-deps compile

release: all
	./relx

clean:
	./rebar clean
	-rm -fr _rel

.PHONY: clean
