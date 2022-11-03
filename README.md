# 🧱 The Flutter Brick

Intended to ease the creation of new Flutter apps.

If you're like me and keep forgetting all the flutter command line arguments while creating a new project, this interactive mason shell might help you. Hopefully the Flutter-CLI gets more interactive overtime, so I can delete this some day!

## Idea 💡

* Allow creation of empty flutter projects (e.g. no more deleting of counter app)
* No more refactoring `com.example` (orgName is required during setup)
* No more removing the debug banner
* No more removing all comments from pubspec.yaml
* Choose your platforms interactively (e.g. desktop, web) during setup
* Picking one of the many Flutter sample projects (e.g. no more `--list-samples=examples.json`)
* Nothing too fancy. Uses your Flutter-CLI under the hood

## Getting Started 🚀

**Install:**

```sh
# 🎯 Activate mason from https://pub.dev
dart pub global activate mason_cli

# Add Flutter brick from registry (global)
mason add -g flutter --git-url https://github.com/coodoo-io/mason_flutter
# mason add -g flutter (not possible, since flutter is a reserved word in brickhub.dev)
```

**Create a project:**

```sh
# Start the wizard
mason make flutter
```
