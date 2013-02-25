PWD=$(shell pwd)

FEE=$(PWD)/bin/fee
COFFEE=$(PWD)/node_modules/.bin/coffee
TEST_ROOT=$(PWD)/test
TEST_APPLICATION=$(TEST_ROOT)/application

.PHONY: test

test: test-setup test-runner test-teardown

test-runner:
	FEE=$(FEE) TEST_APPLICATION=$(TEST_APPLICATION) $(COFFEE) $(TEST_ROOT)/runner

test-setup:
	@echo ''
	@echo 'Creating test application...'
	@echo ''

	$(FEE) --include-readme new $(TEST_APPLICATION)

	rm -rf $(TEST_APPLICATION)/node_modules/feejs
	rm $(TEST_APPLICATION)/node_modules/.bin/fee
	ln -s $(PWD) $(TEST_APPLICATION)/node_modules/fee
	ln -s $(FEE) $(TEST_APPLICATION)/node_modules/.bin/fee

	(cd $(TEST_APPLICATION) && \
		$(FEE) cmpt users && \
		$(FEE) --no-route cmpt todos)

	@clear
	@echo ''
	@echo 'Test application created at $(TEST_APPLICATION)'
	@echo 'Run `make test-teardown` to clean up'
	@echo ''

test-teardown:
	@echo ''
	@echo 'Removing test application...'
	@echo ''
	rm -rf $(TEST_APPLICATION)
