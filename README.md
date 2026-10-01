# concourse-build-metadata-resource

Simple Concourse build metadata resource that works in newer Concourse versions and prevents issues 

## Usage

```yaml

resource_types:
- name: build-metadata
  type: registry-image
  source:
    repository: ghcr.io/mreiche/concourse-build-metadata-resource
    tag: 1.0.0

resources:
  - name: build-metadata
    type: build-metadata
    icon: format-list-bulleted

jobs:
  - name: my-job
    plan:
      - get: build-metadata
```

After you got the resource `build-metadata`, either load it directly as build vars:

```yaml
- load_var: build
  file: build-metadata/metadata.json
- task: my-task
  vars:
    build_id: ((.:build.id))
```

or read them from files:

```yaml
- task: my-task
  config:
    platform: linux
    image_resource:
      type: registry-image
      source:
        repository: bash
        tag: 5

    inputs:
    - name: build-metadata
    
    run:
    path: sh
    args:
      - -ceu
      - |
        BUILD_ID=$(cat ./build-metadata/id)
        echo ${BUILD_ID}
```

Passing the structure won't work:
```yaml
- load_var: build
  file: build-metadata/metadata.json
- task: my-task
  vars:
    build: ((.:build))  # Doesn't work
```
