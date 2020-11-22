#!/bin/bash

# the entrypoint to the container.
# this Action defines a number of tasks to perform on a Hamlet CMDB
# the entrypoint should only contain sufficient logic so as to invoke applicable tasks
# tasks are maintained in separate scripts in scripts/
# utility definitions are maintained in scripts/utilities.sh

build_schemas="$1"
schemas_output_dir="$2"
properties_file_path="$3"

# Set the environment variables file
# Includes search for properties file
/scripts/set_env "${properties_file_path}" "GITHUB_ENV"

# Run Tasks
[ "$build_schemas" == "true" ] && /scripts/build_schemas "$schemas_output_dir"