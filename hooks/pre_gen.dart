import 'dart:io';
import 'package:mason/mason.dart';

const mobilePlatforms = ["ios", "android"];
const desktopPlatforms = ["windows","linux","macos"];
const webPlatform = ["web"];

Future<void> run(HookContext context) async {
  context.vars["useEmptySample"] = false;

  // Validation app name
  if (context.vars["projectName"].contains(RegExp(r'[A-Z]'))) {
    return context.logger
        .err("App name must consist of lowercase, numbers or underscore characters (e.g. counter_app1).");
  }

  // Add an additional question if counterExample false
  String? sampleId;
  if (context.vars["counterExample"] == false) {
    sampleId = await context.logger.prompt(
        "? Want to use a Flutter Sample instead? (Enter ID from https://samples.flutter.de)",
        defaultValue: "No");
    if (sampleId == "No") {
      sampleId = null;
    };
  }

  // Define platforms
  var platforms = [];
  if (context.vars["mobileSupport"] == true) {
    platforms.addAll(mobilePlatforms);
  }
  if (context.vars["webSupport"] == true) {
    platforms.addAll(webPlatform);
  }
  if (context.vars["desktopSupport"] == true) {
    platforms.addAll(desktopPlatforms);
  }

  // Validation platforms
  if (platforms.length==0) {
    return context.logger.err("At least one platform must be selected.");
  }

  // Generate Flutter project via standard `flutter create`
  var args = ['create', '--suppress-analytics', '--org', '{{orgaName}}', '{{projectName}}', '--platforms', platforms.join(",")];
  print(args);
  if (sampleId != null && sampleId.isNotEmpty && !sampleId.startsWith("custom")) {
    args = [...args, '--sample', sampleId];
    context.logger.info('Creating your flutter app with sample (${sampleId})...');
  } else {
    context.logger.info('Creating your flutter app...');
  }
  final result = await Process.run('flutter', args);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  // Optional: Remove Flutter counter example & use our default
  final currentDir = Directory.current;
  final projectPath = "${currentDir.path}/${context.vars["projectName"]}";
  if (context.vars["counterExample"] == false && sampleId == null) {
    await File('$projectPath/lib/main.dart').delete();
    context.vars["useEmptySample"] = true;
  }

  // Remove comments from pubspec.yaml
  final pubspec = await File('$projectPath/pubspec.yaml');
  List<String> lines = pubspec.readAsLinesSync();
  List<String> newLines = [];
  for (final String line in lines) {
    if (!line.trimLeft().startsWith("#") && line !="\n") {
      newLines.add(line);
    }
  }
  await pubspec.writeAsString(newLines.join('\n'));
}
