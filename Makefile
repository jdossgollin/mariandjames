# build and serve the website using docker:
#   * does not require a ruby installation (!!!)
#   * a bit slower than running ruby natively, but worth the savings in hassle
#   * gems are downloaded locally to "veendor"
# on importance of ":cached": see https://docs.docker.com/docker-for-mac/osxfs-caching/

JEKYLL_VERSION = 3.8
PWD = $(shell pwd)
LOCALHOST = 4000

build:
	$(info Make: building web site)
	@docker run \
    --rm \
    --volume="$(PWD):/srv/jekyll:cached" \
    --volume="$(PWD)/vendor/bundle:/usr/local/bundle:cached" \
    -it jekyll/jekyll:$(JEKYLL_VERSION) \
    jekyll build

devserver:
	$(info Make: building web site and serving to localhost:$(LOCALHOST))
	@docker run \
    --rm \
    --volume="$(PWD):/srv/jekyll:cached" \
    --volume="$(PWD)/vendor/bundle:/usr/local/bundle:cached" \
    -p $(LOCALHOST):4000 \
    -it jekyll/jekyll:$(JEKYLL_VERSION) \
    jekyll serve -w
