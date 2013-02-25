PWD=$(shell pwd)

ELIZA=$(PWD)/bin/eliza
COFFEE=$(PWD)/node_modules/.bin/coffee
TEST_ROOT=$(PWD)/test
TEST_APPLICATION=$(TEST_ROOT)/application

.PHONY: test

test: test-setup test-runner test-teardown

test-runner:
	eliza=$(ELIZA) TEST_APPLICATION=$(TEST_APPLICATION) $(COFFEE) $(TEST_ROOT)/runner

test-setup:
	@echo ''
	@echo 'Creating test application...'
	@echo ''

	$(ELIZA) --include-readme new $(TEST_APPLICATION)

	rm -rf $(TEST_APPLICATION)/node_modules/elizajs
	rm $(TEST_APPLICATION)/node_modules/.bin/eliza
	ln -s $(PWD) $(TEST_APPLICATION)/node_modules/eliza
	ln -s $(ELIZA) $(TEST_APPLICATION)/node_modules/.bin/eliza

	(cd $(TEST_APPLICATION) && \
		$(ELIZA) cmpt users && \
		$(ELIZA) --no-route cmpt todos)

	@clear
	@echo ''
	@echo 'Test application created at $(TEST_ROOT)/application'
	@echo 'Run `make test-teardown` to clean up'
	@echo ''

test-teardown:
	@echo ''
	@echo 'Removing test application...'
	@echo ''
	rm -rf $(TEST_ROOT)/application
