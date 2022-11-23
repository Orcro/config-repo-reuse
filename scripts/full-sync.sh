#!/bin/bash

# SPDX-FileCopyrightText: 2022 Snyk Limited <opensource@snyk.io>
# 
# SPDX-License-Identifier: Apache-2.0

GROUP_NAME=$1

docker run --rm -it -e GITHUB_TOKEN -e SNYK_TOKEN -v "${PWD}":/runtime \
ghcr.io/snyk-playground/snyk-sync:latest --sync targets --save

export SNYK_LOG_PATH="cache/logs"

docker run --rm -it -e SNYK_LOG_PATH -e SNYK_TOKEN -v "${PWD}":/runtime \
--entrypoint '/usr/local/bin/entrypoint-api-import.sh' \
ghcr.io/snyk-playground/snyk-sync:latest import --file targets/$GROUP_NAME.json

docker run --rm -it -e GITHUB_TOKEN -e SNYK_TOKEN -v "${PWD}":/runtime \
ghcr.io/snyk-playground/snyk-sync:latest --sync tags --update
