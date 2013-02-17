COFFEE=./node_modules/.bin/coffee

BIN=./bin
LIB=./lib
SRC=./src

CLI=./src/cli.coffee
CLI_BIN=./bin/eliza

compile: generate-cli compile-cs clean-compiled

clean:
	rm $(BIN)/*
	rm $(LIB)/*.coffee

generate-cli:
	echo '#!/usr/bin/env node\n' > $(CLI_BIN)
	cat $(CLI) | $(COFFEE) -sbc >> $(CLI_BIN)

compile-cs:
	$(COFFEE) -co $(LIB) $(SRC)

clean-compiled:
	rm $(LIB)/cli.js
