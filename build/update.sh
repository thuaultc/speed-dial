#!/bin/bash

set -e

kubectl patch deployment/speed-dial -n website -p \
    "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
