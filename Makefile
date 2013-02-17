COFFEE=./node_modules/.bin/coffee

CLI=./src/cli.coffee
CLI_BIN=./bin/eliza

generate-cli:
	echo '#!/usr/bin/env node\n' > $(CLI_BIN)
	cat $(CLI) | $(COFFEE) -sbc >> $(CLI_BIN)
