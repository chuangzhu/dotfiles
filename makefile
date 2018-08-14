
.PHONY: help list ls apply

help:
	@python ./dot.py help

list:
	@python ./dot.py list $(topic)	

ls: list

apply:
	@python ./dot.py apply $(topic)

