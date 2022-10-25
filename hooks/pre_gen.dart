import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final List<String> defaultPlatforms = ['android', 'ios'];

  // Context Variables
  context.vars['useOurExample']=false;
  final String projectName = context.vars['projectName'].trim();
  final String orgName = context.vars['orgName'].toLowerCase().trim() ?? 'com.example';
  final bool useCounterExample = context.vars['useCounterExample'];
  final List<dynamic> platforms = context.vars['platforms'] ?? defaultPlatforms;

  // Validations
  if (projectName.contains(RegExp(r'[A-Z]'))) {
    return context.logger
        .err('App name must consist of lowercase, numbers or underscore characters (e.g. counter_app1).');
  }

  // Prompt user with an additional question if useCounterExample==false
  String? sampleId;
  if (useCounterExample == false) {
    sampleId = await context.logger.prompt(
        '? Want to use a Flutter Sample instead? (Enter ID from https://samples.flutter.de)',
        defaultValue: 'No');
    
    if (sampleId == 'No') {
      sampleId = null;
    };
  }

  // Generate Flutter project via standard `flutter create`
  List<String> args = ['create', '--suppress-analytics', '--org', '{{orgName}}', '{{projectName}}', '--platforms', platforms.join(',')];
  if (sampleId != null && sampleId.isNotEmpty && !sampleId.startsWith('custom')) {
    args = [...args, '--sample', sampleId];
    context.logger.info('Creating your flutter app with sample (${sampleId})...');
  } else {
    context.logger.info('Creating your flutter app...');
  }
  final result = await Process.run('flutter', args);
  stdout.write(result.stdout);

  // After generation
  // Optionally replace Flutter counter example with our custom main.dart
  final projectPath = '${Directory.current.path}/$projectName';
  if (useCounterExample == false && sampleId == null) {
    await File('$projectPath/lib/main.dart').delete();
    context.vars['useOurExample']=true;
  }

  // After generation
  // Remove comments from pubspec.yaml
  final pubspec = await File('$projectPath/pubspec.yaml');
  List<String> lines = pubspec.readAsLinesSync();
  List<String> newLines = [];
  for (final String line in lines) {
    if (!line.trimLeft().startsWith('#') && line != '\n') {
      newLines.add(line);
    }
  }
  await pubspec.writeAsString(newLines.join('\n'));
}
