THEMIS_DIR = test/vim-themis
THEMIS = $(THEMIS_DIR)/bin/themis

all: test

$(THEMIS): $(THEMIS_DIR)

$(THEMIS_DIR):
	@git clone https://github.com/thinca/vim-themis $(THEMIS_DIR)

.PHONY: test clean
test: $(THEMIS)
	@$(THEMIS) --reporter spec --runtimepath .

clean:
	rm -rf $(THEMIS_DIR)
