# Makefile — Pandoc flat-output build for the old-school academic site.
SRC_DIR := src
OUT_DIR := docs
TEMPLATE := templates/template.html

# All .md sources (any subdir), sorted for stable builds.
SOURCES := $(shell find $(SRC_DIR) -name '*.md' | sort)

.PHONY: build clean test serve

build:
	@mkdir -p $(OUT_DIR)
	@for src in $(SOURCES); do \
		base=$$(basename "$$src" .md); \
		echo "build $$src -> $(OUT_DIR)/$$base.html"; \
		pandoc "$$src" -o "$(OUT_DIR)/$$base.html" --template=$(TEMPLATE) -s; \
	done
	@cp style.css $(OUT_DIR)/
	@find $(SRC_DIR) -name '*.pdf' -exec cp {} $(OUT_DIR)/ \;
	@touch $(OUT_DIR)/.nojekyll

serve:
	@cd $(OUT_DIR) && python3 -m http.server 8000

clean:
	rm -rf $(OUT_DIR)

test:
	bash tests/test_build.sh