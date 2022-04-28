import 'dart:io';

import 'package:mason/mason.dart';

const mobilePlatforms = "ios,android";
const desktopPlatforms = "windows,linux,macos";
const webPlatform = "web";

Future<void> run(HookContext context) async {
  // Add an additional question if counterExample false
  if (context.vars["counterExample"] == false) {
    var answer = await context.logger.prompt("? Want to use a different Flutter Sample instead? (Enter ID from https://samples.flutter.de)", defaultValue: null);
    context.logger.info("Sample Number: ${answer}");
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
  context.logger.info('Creating your flutter app...');
  var result = await Process.run('flutter',
      ['create', '--suppress-analytics', '--org', '{{packageName}}', '{{projectName}}', '--platforms', platforms]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  // Optional: Remove Flutter counter example
  if (context.vars["counterExample"] == false) {
    var currentDir = Directory.current;
    await File('${currentDir.path}/${context.vars["projectName"]}/lib/main.dart').delete();

    // Maybe user wants a different sample
    var answer = await context.logger.prompt("\x1b[A\u001B[2K Want to use a Flutter Sample instead?", defaultValue: null);
    context.logger.info("Sample Number: ${answer}");
    context.logger.info('Creating your flutter app...');
  }
}
