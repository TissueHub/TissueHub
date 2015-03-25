.PHONY: build build/tissuehub-$(version) upload test

version := "1.0.1"

clean:
	rm -rf .build/*

test:
	JASMINE_CLIENT_INTEGRATION=0 JASMINE_BROWSER=PhantomJS meteor --test

.build/tissuehub-$(version): clean test
	meteor build --directory .build/tissuehub-$(version) --architecture os.linux.x86_64

build: .build/tissuehub-$(version)
	tar -czf .build/tissuehub-$(version).tar.gz .build/tissuehub-$(version)/*

upload: build
	scp .build/tissuehub-$(version).tar.gz tissuehub.org:tissuehub-builds/tissuehub-$(version).tar.gz