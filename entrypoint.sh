#!/bin/bash
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
        cat $properties_file_path | xargs -I {} sh -c "grep -qxF {} GITHUB_ENV || echo {} >> GITHUB_ENV"
    else
        echo "::setFailed::Could not locate a properties file at path: ${properties_file_path}"
    fi
fi

if [[ "$build_schemas" == "true" ]]; then
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u component -o "$schemas_output_dir"
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u reference -o  "$schemas_output_dir"
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u metaparameter -o "$schemas_output_dir"
    # Remove Generated Contracts
    rm ${schemas_output_dir}/schema-*-generation-contract.json
fi