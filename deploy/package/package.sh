#!/bin/bash
mkdir output

rm -rf output
export API_HOST=scan.eight-art.com
export API_PORT=443
export API_PROTOCOL=https
export STATS_API_HOST=
export VISUALIZE_API_HOST=
export APP_HOST=scan.eight-art.com
export APP_PORT=3000
export APP_INSTANCE=localhost
export APP_ENV=UAT
export NETWORK_NAME="POTOS Testnet"
export NETWORK_ID=20200
export AD_BANNER_PROVIDER=none
export AD_TEXT_PROVIDER=none
export NETWORK_CURRENCY_DECIMALS=18
export NETWORK_CURRENCY_NAME="Eightart Token"
export NETWORK_CURRENCY_SYMBOL=
export HOMEPAGE_CHARTS=[\"daily_txs\"]
export HOMEPAGE_STATS=[\"total_blocks\",\"total_txs\",\"wallet_addresses\"]
export NAVIGATION_HIDDEN_LINKS=[\"eth_rpc_api\",\"rpc_api\"]
export API_SPEC_URL=none
export GRAPHIQL_TRANSACTION=none
export WEB3_WALLETS=none
export HIDE_INDEXING_ALERT_BLOCKS=true
export HIDE_INDEXING_ALERT_INT_TXS=true
export VERIFIED_CONTRACTS_ENABLED=false
export TOKENS_ENABLED=false
export TOKEN_TRANSFERS_ENABLED=false
export CONTRACT_VERIFICATION_ENABLED=false
export GAS_TRACKER_ENABLED=false
export HIDE_FOOTER=true
export VIEWS_TX_HIDDEN_FIELDS=[\"value\",\"fee_currency\",\"gas_price\",\"tx_fee\",\"transactions_fees\",\"avg_transaction_fee\"]
export VIEWS_BLOCK_HIDDEN_FIELDS=[\"burnt_fees\",\"total_reward\",\"base_fee\"]
envsubst < .env.template > ./output/.env

export IMAGE_NAME=blockscout-frontend
export VERSION=1.0.0
DOCKER_BUILDKIT=1 docker build --platform linux/amd64 --build-arg GIT_COMMIT_SHA=$(git rev-parse --short HEAD) --build-arg GIT_TAG=$(git describe --tags --abbrev=0) -t "$IMAGE_NAME:$VERSION" ../../
docker save -o ./output/"${IMAGE_NAME}".tar "$IMAGE_NAME"

envsubst < start.sh.template > ./output/start.sh
envsubst < stop.sh.template > ./output/stop.sh
chmod +x ./output/stop.sh

tar -czf output.tar.gz -C ./output .
