
.PHONY: help list ls apply add status save commit ci

help:
	@python ./dfs help

list:
	@python ./dfs list $(topic)	

ls: list

apply:
	@python ./dfs apply $(topic)

recover:
	@python ./dfs recover $(topic)

add:
	@python ./dfs add '$(file)'

status:
	@python ./dfs status

save:
	@python ./dfs save

st: status

commit:
	@python ./dfs commit

ci: commit
	