.PHONY: lint clean dev

build: src static
	npm run build

lint:
	npm run lint

clean:
	-rm -rf .svelte-kit build

dev:
	-npm run dev
