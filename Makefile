help:
	grep --extended-regexp '^[a-zA-Z]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-12s\033[0m%s\n", $$1, $$2 }'

setup: # docker pull + create settings.sh
	./setup.sh

init: # install + config
	./init.sh

.SILENT: