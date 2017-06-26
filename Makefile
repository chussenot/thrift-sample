
THRIFT_VER=latest
THRIFT_IMG=thrift:$(THRIFT_VER)
THRIFT=docker run -v "${PWD}:/data" $(THRIFT_IMG) thrift

THRIFT_GEN=-r --gen rb --gen js:node
THRIFT_CMD=$(THRIFT) -o /data $(THRIFT_GEN)

THRIFT_FILES=tutorial.thrift

test_ci: thrift

clean:
	rm -rf gen-* || true

thrift:	thrift-image clean $(THRIFT_FILES)

$(THRIFT_FILES):
	@echo Compiling $@
	$(THRIFT_CMD) /data/thrift/$@

thrift-image:
	docker pull $(THRIFT_IMG)
	$(THRIFT) -version

.PHONY: test_ci clean thrift thrift-image $(THRIFT_FILES)
