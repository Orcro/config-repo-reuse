#!/bin/bash

# SPDX-FileCopyrightText: 2022 Snyk Limited <opensource@snyk.io>
# 
# SPDX-License-Identifier: Apache-2.0

docker run --rm -it -e GITHUB_TOKEN -e SNYK_TOKEN -v "${PWD}":/runtime \
ghcr.io/snyk-playground/snyk-sync:latest --sync targets --save
