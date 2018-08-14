RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

.PHONY: help list apply

help:
	@python ./dot.py help $(RUN_ARGS)

list:
	@python ./dot.py list $(RUN_ARGS)

apply:
	@python ./dot.py apply $(RUN_ARGS)

