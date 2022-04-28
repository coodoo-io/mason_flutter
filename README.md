# 🧱 Flutter Brick

Intended to ease the creation of new Flutter apps.

## Idea 💡

* Allow creation of empty flutter projects (e.g. no more deleting of counter app)
* No more refactoring com.example. Package name is required when creating projects
* Let users decide if they want web or desktop support
* No more removing the debug banner
* Remove all Comments from pubspec.yaml
* Easy way to use a Flutter sample. No more --list-samples=examples.json

## Getting Started 🚀

**Install:**

```sh
# 🎯 Activate mason from https://pub.dev
dart pub global activate mason_cli

# Add Flutter brick from registry (global)
mason add -g flutter
```

**Create a project:**

```sh
# Start the wizard
mason make flutter
```
