include tool/make/init.mk

TEST_FILES := $(wildcard test/test-*)

default:

docker-build-all docker-push-all docker-pull-all:
	$(MAKE) -C tool/docker $@

build html site serve publish publish-fork force diff:
	$(MAKE) -C www $@

test: test-spec $(TEST_FILES)

test-spec:
	$(MAKE) -C spec test

$(TEST_FILES): force
	bash $@

force:

_:
	git worktree prune
	git worktree add $@ $@
	$(MAKE) -C $@ all

clean:
	git worktree prune
	$(MAKE) -C spec/2009 $@
	$(MAKE) -C www $@
	$(MAKE) -C tool/docker clean-all
