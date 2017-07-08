
THRIFT_VER=latest
THRIFT_IMG=thrift:$(THRIFT_VER)
THRIFT=docker run -v "${PWD}:/data" $(THRIFT_IMG) thrift

THRIFT_GEN=-r --gen rb \
	--gen erl \
	--gen cpp \
	--gen go \
	--gen dart \
	--gen gv \
	--gen dart \
  --gen hs \
	--gen py \
	--gen ocaml \
	--gen lua \
	--gen js \
  --gen json

THRIFT_CMD=$(THRIFT) -o /data/build $(THRIFT_GEN)

THRIFT_FILES=multiplication.thrift baseservice.thrift

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
