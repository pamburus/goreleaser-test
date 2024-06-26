.DEFAULT_GOAL := build

# Exported variables
export RUST_BACKTRACE=1

## Print help
help:
	@echo "$$(tput setaf 2)Usage$$(tput sgr0)";sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## /---/;td" -e"s/:.*//;G;s/\\n## /===/;s/\\n//g;p;}" ${MAKEFILE_LIST}|awk -F === -v n=$$(tput cols) -v i=4 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"  '$$(tput setaf 2)make$$(tput sgr0)' %s%s%s\t",a,$$1,z;m=split($$2,w,"---");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;}printf"%*s%s\n",-i," ",w[j];}}' | column -ts $$'\t'
.PHONY: help

## Build debug target
build:
	@cargo build
.PHONY: build

## Build release target
build-release:
	@cargo build --release --locked
.PHONY: build-release

## Install binary
install:
	@cargo install --path . --locked
.PHONY: install

## Run tests
test:
	@cargo test
.PHONY: test

## Clean build artifacts
clean:
	@cargo clean
.PHONY: clean
