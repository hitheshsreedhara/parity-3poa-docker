# parity-3poa-docker
This repository is for setting up 3 nodes PoA Parity network using docker-compose

## Objective:

Build Parity from scratch to set up a 3-authority PoA network, the nodes should have some sort of monitoring solution in place.

## Solution:

This was quite challenging task for me since, I have not had much experience in dealing with the blockchain technologies. Nevertheless, it was a great learning opportunity for me.


### Directory Structure

```
├── Dockerfile      # Creates parity docker container
├── Makefile        # Commands to create the setup and to interact
├── README.md
├── config
│   ├── base_node0  # node0 base path storing keys and transaction data
│   ├── base_node1  # node1 base path storing keys and transaction data
│   ├── base_node2  # node2 base path storing keys and transaction data
│   ├── demo-spec.json # Chain Specification with user account added 
│   ├── node.pwds   # Node password file
│   └── node.toml   # Node config file
├── dashboard
│   └── ws_secret.json # dashboard ws_secret
├── docker-compose.yml # Docker compose file to create the 3PoA setup with monitoring in place
└── monitor
    └── app.json # Monitoring json file
``` 

### Steps to Build the 3PoA parity setup :
1. Checkout this source repository
```
git clone repo
```
2. Build the docker-compose using Makefile
```
make build
```
3. Docker-compose up with the help of Makefile
```
make up / make-up-daemon
```
4. View the node status and blocks created with the help of dashboard running in port 3001
```
localhost:3001
```

### Make Transactions:
1. A user is already created with rich account. Check the balance of user account :
```
make balance-user
```
```
curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x004ec07d2329997267ec62b4166639513386f32e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545
{"jsonrpc":"2.0","result":"0x21d2013f118ed380000","id":1}
```
2. Check the authority account balance Example - node0:
```
make balance-node0
```
```
curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00bd138abd70e2f00903268f3db08f2d25677c9e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545
{"jsonrpc":"2.0","result":"0xb469471f80140000","id":1}
```
3. Trigger a transaction from user to node0 :
```
make transaction-node0
```
```
curl --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x004ec07d2329997267ec62b4166639513386f32e","to":"0x00bd138abd70e2f00903268f3db08f2d25677c9e","value":"0xde0b6b3a7640000"}, "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8545
{"jsonrpc":"2.0","result":"0xb8ade46a336f5a732ba519eae044cc2b97dd2168eb8657266bd590ee748890fe","id":0}
```
4. Check the balance of user and node0 again to see the changes
```
make balance-node0
make balance-user
```
```
curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00bd138abd70e2f00903268f3db08f2d25677c9e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545
{"jsonrpc":"2.0","result":"0xc249fdd327780000","id":1}

curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x004ec07d2329997267ec62b4166639513386f32e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545
{"jsonrpc":"2.0","result":"0x21d12333a6545d40000","id":1}

```

### My Learnings:

1. As a first step I started understanding bit more about the blockchain technology, ethereum and parity, PoA.
2. I started to build Parity from source - https://github.com/paritytech/parity. After a long building time parity was finally installed in my local machine.
3. I found a very good documentation about a demo PoA - https://wiki.parity.io/Demo-PoA-tutorial.html
4. I followed the steps in the above document and built my first PoA with two Authorities and a User and also made a successful transaction.
5. Next step was to dockerize the setup with 3 nodes.
6. I used parity binary instead of source code to build parity image because it takes longtime to build image using source code. 
7. Ofcourse I faced some problems like - “consensus signer not found” and with the help of few blogs and gitter channel of parity, I was able to troubleshoot it. Finally, built my PoA network on the containers and added monitoring to the nodes with the help of ethstats image.
8. I added a simple Makefile to execute the commands easily and make transactions.


### PS - I faced some scenarios while building the setup and I would like to understand how it works :
1. When I git clone the source of parity - https://github.com/paritytech/parity  and build the executable using "cargo build --release" and start the parity. This starts me the unstable-parity version always. Even though I checkout the stable branch.

2. ethstats dashboard sometimes makes the node offline and also the "Last transaction miners" dashboard section is not updated instantly. Not sure why.
