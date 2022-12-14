.ONESHELL:
.PHONY: $(MAKECMDGOALS)
##
##    🚧 Developer tools
##
##  DEV=1               Whether to install dev dependencies
DEV=1
##  TAG=latest          Tag for the `image` command
TAG=latest

##

help:              ## Show this help (default)
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

all:               ## Run a whole CI pipeline: lint, run tests, build docs
	make install lint test docs

install:           ## Install project dependencies
	poetry install \
	`if [ "${DEV}" = "0" ]; then echo "--no-dev"; fi`

lint:              ## Lint with all tools
	make isort black flake mypy

test:              ## Run test suite
	poetry run pytest --cov-report=term-missing --cov=pytezos_core --cov-report=xml -n auto -s -v tests

##

isort:             ## Format with isort
	poetry run isort src tests

black:             ## Format with black
	poetry run black src tests

flake:             ## Lint with flake8
	poetry run flakeheaven lint src tests

mypy:              ## Lint with mypy
	poetry run mypy src tests

cover:             ## Print coverage for the current branch
	poetry run diff-cover --compare-branch `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'` coverage.xml

build:             ## Build Python wheel package
	poetry build

image:             ## Build Docker image
	docker buildx build . --progress plain -t pytezos_core:${TAG}
	docker run --rm pytezos_core:${TAG} python -c "from pytezos_core.key import is_installed; assert is_installed(); import secp256k1; secp256k1.PrivateKey(); print('OK')"

release-patch:     ## Release patch version
	bumpversion patch
	git push --tags
	git push

release-minor:     ## Release minor version
	bumpversion minor
	git push --tags
	git push

release-major:     ## Release major version
	bumpversion major
	git push --tags
	git push

clean:             ## Remove all files from .gitignore except for `.venv`
	git clean -xdf --exclude=".venv"

##

update:            ## Update dependencies, export requirements.txt (wait an eternity)
	make install
	poetry update
	poetry export --without-hashes -o requirements.txt
