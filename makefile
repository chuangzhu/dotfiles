
.PHONY: help list ls apply select add status commit ci

help:
	@python ./dot.py help

list:
	@python ./dot.py list $(topic)	

ls: list

apply:
	@python ./dot.py apply $(topic)

recover:
	@python ./dot.py recover $(topic)

select:
	@python ./dot.py select $(topic)

add:
ifeq ($(env), true)
	@python ./dot.py add -e $(file)
else
	@python ./dot.py add $(file)
endif

status:
	@python ./dot.py status

st: status

commit:
	@python ./dot.py commit

ci: commit
	