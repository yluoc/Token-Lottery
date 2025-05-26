-include .env

.PHONY: all help test deploy build clean

build: ## compile the smart contracts
	forge build

test: ## test all functions
	forge test 
mt: ## test only the function with the name passed as argument
	forge test --match-test $(m)
mt-with-reason: ## check the reason of the failure
	forge test --match-test $(m) -vvvv
forktest-sepolia: ## run tests on Sepolia fork
	forge test --fork-url $(SEPOLIA_RPC_URL)
forktest-mainnet: ## run tests on Mainnet fork
	forge test --fork-url $(MAINNET_RPC_URL)

coverage: ## generate coverage report in terminal
	forge coverage
coverage-report: ## generate coverage report in json format
	forge coverage --report debug > coverage.json

deploy-sepolia: ## deploy contracts to Sepolia
	forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv