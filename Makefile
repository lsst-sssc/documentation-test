NOTEBOOKS := $(shell ls notebooks/*/*ipynb)
CONVERTED := $(shell ls notebooks/*/*ipynb| sed 's/ipynb/rst/; s/^/docs\//')

OTHERS_SOURCES := $(wildcard notebooks/*/*png)
OTHERS = $(patsubst %,docs/%,$(OTHERS_SOURCES))

default: $(OTHERS) $(CONVERTED)

docs/%.rst: %.ipynb
	jupyter nbconvert $< --to rst --output-dir=$(shell dirname $@)

docs/%.png: %.png
	mkdir -p $(dir $@)
	cp -f $< $@

clean:
	rm -rf docs/notebooks

.PHONY: convert clean