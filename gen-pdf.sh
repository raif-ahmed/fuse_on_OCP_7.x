#!/usr/bin/env bash

set -x

asciidoctor-pdf -r asciidoctor-diagram -a reportdir=$(pwd) \
                -a ej-base-dir=$(git rev-parse --show-toplevel) \
                 *.adoc
