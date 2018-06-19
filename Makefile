# Makefile.

build:
	docker-compose build

up-daemon:
	docker-compose up -d

up:
	docker-compose up

down:
	docker-compose down

status:
	docker ps

transaction-node0:
	curl --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x004ec07d2329997267ec62b4166639513386f32e","to":"0x00bd138abd70e2f00903268f3db08f2d25677c9e","value":"0xde0b6b3a7640000"}, "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8545

transaction-node1:
	curl --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x004ec07d2329997267ec62b4166639513386f32e","to":"0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2","value":"0xde0b6b3a7640000"}, "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8545

transaction-node2:
	curl --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x004ec07d2329997267ec62b4166639513386f32e","to":"0x002e28950558fbede1a9675cb113f0bd20912019","value":"0xde0b6b3a7640000"}, "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8545


balance-node0:
	curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00bd138abd70e2f00903268f3db08f2d25677c9e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545

balance-node1:
	curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545

balance-node2:
	curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x002e28950558fbede1a9675cb113f0bd20912019", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545

balance-user:
	curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x004ec07d2329997267ec62b4166639513386f32e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545

cleanup:
	docker rm $$(docker ps -a -q)

cleanup-images:
	docker rmi $$(docker images | grep "^<none>" | awk "{print $$3}")
