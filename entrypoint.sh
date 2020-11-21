#!/bin/bash
build_schemas="$1"
schemas_output_dir="$2"

if [[ "$build_schemas" == "true" ]]; then
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u component -o "$schemas_output_dir"
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u reference -o  "$schemas_output_dir"
    hamlet entrance -i mock -p aws -p awstest -p azure -p azuretest invoke-entrance -e schema -u metaparameter -o "$schemas_output_dir"
    # Remove Generated Contracts
    rm ${schemas_output_dir}/schema-*-generation-contract.json
fi