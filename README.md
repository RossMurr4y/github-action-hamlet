# hamlet-go Docker Action

This action allows you to easily run Hamlet Tasks.

# Supported Tasks

Currently supported tasks are:

* Read project.properties file into GITHUB_ENV persistent env file
* Generate Hamlet Schemas


## Inputs

### `task_build_schemas`

**Description** Generates Hamlet schemas such as the Component, ReferenceData and Metaparameter schemas
**Type** boolean
**Default** false

### `task_build_schemas_output`

**Description** Directory within the container to output the schemas. Defaults to the workspace root mounted inside the container at `/home/hamlet/src`
**Type** string
**Default** /github/workspace

## Example Usage

```yaml
uses: hamlet-io/hamlet-github-action@v1
with:
  task_build_schemas: true
  task_build_schemas_output: /home/hamlet/src/path/to/project/schema/directory
```

### `properties_file_path`

**Description** Path to a properties file containing environment variables. Only required to be specified if this Action is running against a Hamlet CMDB repository and the properties file path is not in the conventional location (pipelines/properties/<project>.properties).
**Type** string
**Default** ""

**Note:** A properties file will always be loaded into GITHUB_ENV if found. If you require persistence across Jobs of these settings, ensure the properties file is executed under a standalone job first, as below.

## Example Usage

```yaml
# with properties file in conventional location
uses: hamlet-io/hamlet-github-action@v1

# OR

# with properties file elsewhere
uses: hamlet-io/hamlet-github-action@v1
with:
  properties_file_path: ${{ github.workspace }}/path/project.properties
```