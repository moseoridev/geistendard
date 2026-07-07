.PHONY: dev lint format test build download ensure-upstream run run-all run-minimal run-nerd nerd clean

dev:
	uv sync --all-groups

lint:
	uv run ruff format --check .
	uv run ruff check .

format:
	uv run ruff format .

test:
	uv run pytest

build:
	uv build

download:
	uv run python download_upstream.py

ensure-upstream:
	@if [ ! -d "upstream/geistmono" ] || [ ! -d "upstream/pretendard" ]; then \
		echo "Upstream font resources not found. Downloading..."; \
		$(MAKE) download; \
	fi

run: ensure-upstream
	uv run jetendard --all

run-all: ensure-upstream
	uv run jetendard --all

run-minimal: ensure-upstream
	uv run jetendard --variants Regular Light Bold

run-nerd: run nerd

nerd:
	./scripts/build-nerd-fonts.sh

clean:
	rm -rf fonts/ttf fonts/otf fonts/webfont fonts/nerd-font fonts/specimens
