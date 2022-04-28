import 'dart:io';
import 'package:mason/mason.dart';

const mobilePlatforms = "ios,android";
const desktopPlatforms = "windows,linux,macos";
const webPlatform = "web";

Future<void> run(HookContext context) async {
  // Add an additional question if counterExample false
  String sampleId = "custom.emptyApp.1";
  if (context.vars["counterExample"] == false) {
    sampleId = await context.logger.prompt(
        "? Want to use a different Flutter Sample instead? (Enter ID from https://samples.flutter.de)",
        defaultValue: "custom.emptyApp.1");
  }

  // Define platforms
  var platforms = mobilePlatforms;
  if (context.vars["webSupport"] == true) {
    platforms += "," + webPlatform;
  }
  if (context.vars["desktopSupport"] == true) {
    platforms += "," + desktopPlatforms;
  }

  // Generate Flutter project via standard `flutter create`
  var args = [
    'create',
    '--suppress-analytics',
    '--org',
    '{{packageName}}',
    '{{projectName}}',
    '--platforms',
    platforms
  ];
  if (sampleId.isNotEmpty && !sampleId.startsWith("custom")) {
    args = [...args, '--sample', sampleId];
    context.logger.info('Creating your flutter app with sample (${sampleId})...');
  } else {
    context.logger.info('Creating your flutter app...');
  }
  final result = await Process.run('flutter', args);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  // Optional: Remove Flutter counter example
  if (context.vars["counterExample"] == false) {
    var currentDir = Directory.current;
    final projectPath = "${currentDir.path}/${context.vars["projectName"]}";
    await File('$projectPath/lib/main.dart').delete();

    if(sampleId == "custom.emptyApp.1") {
      context.vars["useEmptySample"] = true;
    } else {
      
    }
  }
}
