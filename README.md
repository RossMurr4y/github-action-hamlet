# hamlet-go Docker Action

This action allows you to easily run Hamlet Tasks.

# Supported Tasks

Currently supported tasks are:

* Generate Hamlet Schemas


## Inputs

### `task_build_schemas`

**Description** Generates Hamlet schemas such as the Component, ReferenceData and Metaparameter schemas
**Type** boolean
**Default** false

### `task_build_schemas_output`

**Description** Directory within the container to output the schemas. Defaults to the workspace root mounted inside the container
**Type** string
**Default** /github/workspace

## Example Usage

```yaml
uses: hamlet-io/hamlet-github-action@v1
with:
  task_build_schemas: true
  task_build_schemas_output: /github/workspace/path/to/project/schema/directory
```