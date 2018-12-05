#!/bin/bash -xe

mkdir ./contracts/relayContracts/
mkdir app/scripts/relayclient/
cp ../relay/contracts/* ./contracts/relayContracts/
cp ../relay/src/js/relayclient/* app/scripts/relayclient/

