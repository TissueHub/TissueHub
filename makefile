architectures := os.osx.x86_64 os.linux.x86_64 os.linux.x86_32

archives := $(addprefix .build/tissuehub-$(TISSUEHUB_VERSION), $(addsuffix .tar.gz, $(architectures)))

.PHONY: build upload test clean

clean:
	rm -rf .build/*

test:
	JASMINE_CLIENT_INTEGRATION=0 JASMINE_BROWSER=PhantomJS meteor --test

upload: build
	scp .build/tissuehub-$(TISSUEHUB_VERSION).tar.gz tissuehub.org:tissuehub-builds/tissuehub-$(TISSUEHUB_VERSION).tar.gz

build: clean test $(architectures)

os.%:
	@echo "\n\nMaking TissueHub $(TISSUEHUB_VERSION) for $@"
	meteor build --directory .build/tissuehub-$(TISSUEHUB_VERSION)-$@ --architecture $@
	cd .build/tissuehub-$(TISSUEHUB_VERSION)-$@ && tar -czf ../tissuehub-$(TISSUEHUB_VERSION)-$@.tar.gz .