#!/usr/bin/env bash

set -eu
set -o pipefail

molecule test --scenario-name default
molecule test --scenario-name remote-repo
