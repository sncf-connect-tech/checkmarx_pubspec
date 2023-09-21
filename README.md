A Dart script to make checkmarx analyss on libraries referenced in a given pubspec.lock.
## Quick Start 🚀

### Installing 🧑‍💻

```sh
dart pub global activate checkmarx_pubspec
```

### Commands ✨

The command requires to define env variable CHECKMARX_TOKEN thats represents token to make request on checkmarx api. 
### `checkmarx_pubspec`


#### Usage

```sh
# scan pubspec.lock in the current directory
checkmarx_pubspec 

# scan the given file with path argment
checkmarx_pubspec --path 'path-to-pubspec.lock'


# scan only direct dependencies and skip the transitive ones
checkmarx_pubspec --only-direct-spec

```