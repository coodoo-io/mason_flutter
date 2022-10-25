# 🧱 The Flutter Brick

Intended to ease the creation of new Flutter apps.  
Hope I can delete it some day!

## Idea 💡

* Allow creation of empty flutter projects (e.g. no more deleting of counter app)
* No more refactoring `com.example` (orgName is required during setup)
* No more removing the debug banner
* Not more removing all comments from pubspec.yaml
* Choose your platforms interactively (e.g. desktop, web) during setup
* Picking one of the many Flutter sample projects (e.g. no more `--list-samples=examples.json`)
* Nothing too fancy. Uses your flutter-cli under the hood

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
