COFFEE=./node_modules/.bin/coffee

BIN=./bin
LIB=./lib
SRC=./src

CLI=./src/cli.coffee
CLI_BIN=./bin/eliza
TEMP_CLI_BIN=./bin/_eliza

compile: generate-cli compile-cs clean-compiled

clean:
	rm $(BIN)/*
	rm $(LIB)/*.coffee

generate-cli: generate-temp-cli
	tail -n +2 $(TEMP_CLI_BIN) > $(CLI_BIN)
	rm $(TEMP_CLI_BIN)

generate-temp-cli:
	cat $(CLI) | $(COFFEE) -sbc > $(TEMP_CLI_BIN)

compile-cs:
	$(COFFEE) -co $(LIB) $(SRC)

clean-compiled:
	rm $(LIB)/cli.js
