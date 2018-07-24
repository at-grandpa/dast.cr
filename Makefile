CRYSTAL_BIN ?= $(shell which crystal)
DAST_BIN ?= $(shell which dast)
PREFIX ?= /usr/local
OUTPUT_BIN ?= bin/dast
TAR_DIR ?= bin/dast
VERSION ?= 0.2.0
TAR_GZ_FILE_NAME ?= dast-$(VERSION)-darwin-x86_64.tar.gz

build:
	rm -rf ./bin/*
	shards update
	$(CRYSTAL_BIN) build --release -o $(OUTPUT_BIN) src/cli.cr $(CRFLAGS)

clean:
	rm -f ./bin/dast

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/dast $(PREFIX)/bin

tar:
	rm -rf ./bin/*
	$(MAKE) build
	mv $(OUTPUT_BIN) $(OUTPUT_BIN)_bin
	mkdir -p $(TAR_DIR)
	cp $(OUTPUT_BIN)_bin $(TAR_DIR)/dast
	cp README.md $(TAR_DIR)
	cp LICENSE $(TAR_DIR)
	cd bin && tar zcvf $(TAR_GZ_FILE_NAME) dast
	openssl dgst -sha256 bin/$(TAR_GZ_FILE_NAME)
