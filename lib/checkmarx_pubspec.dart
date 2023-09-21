import 'dart:io';

import 'package:checkmarx_pubspec/checkmarx/checkmarx_client.dart';
import 'package:checkmarx_pubspec/checkmarx/model/model.dart';
import 'package:pubspec_lock_parse/pubspec_lock_parse.dart';

class CheckmarxPubspecAnalyzer {
  final CheckmarxClient _checkmarxClient;
  CheckmarxPubspecAnalyzer({CheckmarxClient? checkmarxClient})
      : _checkmarxClient = checkmarxClient ?? CheckmarxClient(token: checkmarxToken());

  Future<void> analyze(PubspecLock pubspecLock, bool onlyDirectDependencies) async {
    final packages = pubspecLock.packages.entries
        .where((element) => element.value.source == PackageSource.hosted)
        .where((element) => !onlyDirectDependencies || element.value.dependency != 'transitive')
        .map((entry) => PackageInfo(
              name: entry.key,
              type: RepositoryType.pub,
              version: entry.value.version.toString(),
            ))
        .toList();

    final scanResult = await _checkmarxClient.scan(packages);

    final pendingPackages = scanResult.where((element) => element.status == 'PENDING').toList();
    final vulnerablePackages = scanResult.where((element) => element.risks.isNotEmpty).toList();

    _verboseLogInStdout(scanResult, pendingPackages, vulnerablePackages);
    if (vulnerablePackages.isNotEmpty) {
      throw Exception('${vulnerablePackages.length} Vulnerable packages found');
    }
  }

  void _verboseLogInStdout(
    List<ScannedPackageInfo> scannedPackage,
    List<ScannedPackageInfo> pendingPackages,
    List<ScannedPackageInfo> vulnerablePkgs,
  ) {
    print('Total scanned packages (only hosted package): ${scannedPackage.length}');

    print('Scanned packages:');
    for (final package in scannedPackage) {
      print('\t- ${package.name} ${package.version} => Status: ${package.status}');
    }

    if (pendingPackages.isNotEmpty) {
      print('Number of packages with pending status: ${pendingPackages.length}');
      for (final package in pendingPackages) {
        print('\t- ${package.name} ${package.version}');
      }
    }

    if (vulnerablePkgs.isNotEmpty) {
      print('Number of Vulnerable packages: ${vulnerablePkgs.length}');
      print('Vulnerable packages:');
      for (final package in vulnerablePkgs) {
        print('\t- ${package.name} ${package.version}');
        for (final risk in package.risks) {
          print('\t\t- ${risk.title}');
        }
      }
    }
  }

  static String checkmarxToken() {
    final token = Platform.environment['CHECKMARX_TOKEN'];
    if (token == null || token.isEmpty) {
      throw Exception('CHECKMARX_TOKEN environment variable is not set');
    }
    return token;
  }
}
