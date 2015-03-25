.PHONY: build build/tissuehub-$(version) upload

version := "1.0.1"

.build/tissuehub-$(version): clean
	meteor build --directory .build/tissuehub-$(version) --architecture os.linux.x86_64

build: .build/tissuehub-$(version)
	tar -czf .build/tissuehub-$(version).tar.gz .build/tissuehub-$(version)/*

upload: build
	scp .build/tissuehub-$(version).tar.gz tissuehub.org:tissuehub-builds/tissuehub-$(version).tar.gz

clean:
	rm -rf .build/*