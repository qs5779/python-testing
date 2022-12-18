DTAG ?= qs5779/python-testing:rocky8-3.10.9

DISTRO ?= $(shell echo \$(DTAG) | cut -f 2  -d: | cut -f 1 -d '-')
PYVERS ?= $(shell echo \$(DTAG) | cut -f 2  -d: | cut -f 2 -d '-')
BTAG ?= $(shell echo \$(DTAG) | sed 's/qs5779/jim/')

.PHONY: vars
vars:
	@echo DTAG IS $(DTAG)
	@echo DISTRO IS $(DISTRO)
	@echo PYVERS IS $(PYVERS)

# .PHONY: clean
# clean:
# 	rm -fr dist build wtftools.egg-info

.PHONY: build
build:
	docker build --tag poetry-$(DISTRO)-$(PYVERS) --build-arg PY_VERSION=$(PYVERS) -f ./src/Dockerfile.$(DISTRO) ./src

# .PHONY: install
# install:
# 	pip install dist/wtftools-$(VERSION)-py3-none-any.whl

# .PHONY: uninstall
# uninstall:
# 	pip uninstall -y wtftools

# .PHONY: reinstall
# reinstall: uninstall clean build install

.PHONY: test
test:
	@echo DTAG=$(DTAG)
	for tag in $(DTAG) ; do \
		docker pull $$tag ; \
		docker run --rm --tty \
  	--volume $(shell git rev-parse --show-toplevel):/project/ \
  	$$tag  python --version ; \
	done
