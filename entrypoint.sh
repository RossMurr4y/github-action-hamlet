#!/bin/bash

# the entrypoint to the container.
# this Action defines a number of tasks to perform on a Hamlet CMDB
# the entrypoint should only contain sufficient logic so as to invoke applicable tasks
# tasks are maintained in separate scripts in scripts/
# utility definitions are maintained in scripts/utilities.sh

build_schemas="$1"
schemas_output_dir="$2"
properties_file_path="$3"

# read & export properties file into GITHUB_ENV environment file
# if its provided or discoverable
if [[ "$properties_file_path" == "" ]]; then
    # check conventional properties files
    for f in pipelines/properties/*.properties; do
        [ -e "$f" ] && properties_file_path="$f" && break
    done
    [ ! -n "$properties_file_path" ] && echo "::debug::No properties file found."
fi

if [[ -n "$properties_file_path" ]]; then
    if [[ -e "$properties_file_path" ]]; then
        # export unique variables from properties file to GITHUB_ENV
        cat $properties_file_path | xargs -I {} sh -c "grep -qxF {} GITHUB_ENV || echo {} >> GITHUB_ENV | echo Updated GITHUB_ENV: {}"
    else
        echo "::setFailed::Could not locate a properties file at path: ${properties_file_path}"
    fi
fi

[ "$build_schemas" == "true" ] && /scripts/build_schemas "$schemas_output_dir"