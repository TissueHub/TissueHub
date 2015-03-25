.PHONY: build build/tissuehub-$(TISSUEHUB_VERSION) upload test

clean:
	rm -rf .build/*

test:
	JASMINE_CLIENT_INTEGRATION=0 JASMINE_BROWSER=PhantomJS meteor --test

.build/tissuehub-$(TISSUEHUB_VERSION): clean test
	meteor build --directory .build/tissuehub-$(TISSUEHUB_VERSION) --architecture os.linux.x86_64

build: .build/tissuehub-$(TISSUEHUB_VERSION)
	tar -czf .build/tissuehub-$(TISSUEHUB_VERSION).tar.gz .build/tissuehub-$(TISSUEHUB_VERSION)/*
	cp .build/tissuehub-$(TISSUEHUB_VERSION).tar.gz .build/tissuehub.tar.gz

upload: build
	scp .build/tissuehub-$(TISSUEHUB_VERSION).tar.gz tissuehub.org:tissuehub-builds/tissuehub-$(TISSUEHUB_VERSION).tar.gz