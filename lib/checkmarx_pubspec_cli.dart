import 'dart:io';

import 'package:args/args.dart';
import 'package:checkmarx_pubspec/checkmarx_pubspec.dart';
import 'package:pubspec_lock_parse/pubspec_lock_parse.dart';

class CheckMarxPubspecCli {
  final CheckmarxPubspecAnalyzer _checkMarxPubspecAnalyzer;

  CheckMarxPubspecCli({CheckmarxPubspecAnalyzer? checkMarxPubspecAnalyzer})
      : _checkMarxPubspecAnalyzer = checkMarxPubspecAnalyzer ?? CheckmarxPubspecAnalyzer();

  void exec(List<String> arguments) async {
    final args = parseArguments(arguments);

    final pubspecLockPath = File(args.path ?? 'pubspec.lock').readAsStringSync();
    final pubspecLock = PubspecLock.parse(pubspecLockPath);
    await _checkMarxPubspecAnalyzer.analyze(pubspecLock, args.onlyDirectDependencies);
  }

  Arguments parseArguments(List<String> arguments) {
    final argParser = ArgParser();
    argParser.addOption('path', abbr: 'p');
    argParser.addFlag('only-direct-deps', abbr: 'd');
    final result = argParser.parse(arguments);
    final (path, onlyDirectDependencies) = ((result['path']), result['only-direct-deps'] ?? false);
    return Arguments(path, onlyDirectDependencies);
  }
}

class Arguments {
  final String? path;
  final bool onlyDirectDependencies;

  Arguments(this.path, this.onlyDirectDependencies);
}
