import 'dart:convert';
import 'dart:io';

import 'package:checkmarx_pubspec/checkmarx/model/model.dart';
import 'package:http/http.dart';

class CheckmarxClient {
  final String token;
  final Client _httpClient;
  final Uri url = Uri.parse('https://api.dusti.co/v1/packages');

  CheckmarxClient({required this.token, Client? httpClient}) : _httpClient = httpClient ?? Client();

  Future<List<ScannedPackageInfo>> scan(List<PackageInfo> packages) => _post(packages);

  Future<List<ScannedPackageInfo>> _post(List<PackageInfo> packages) async {
    final requestBody = jsonEncode(packages);
    final response = await _httpClient.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'token $token',
      },
      body: requestBody,
    );
    _ioLog(requestBody, response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<ScannedPackageInfo> scannedPackages = data.map((json) => ScannedPackageInfo.fromJson(json)).toList();
      return scannedPackages;
    } else {
      throw Exception('Failed to scan packages (http code: ${response.statusCode} - response body: ${response.body}}');
    }
  }

  Future<void> _ioLog(String requestBody, String responseBody) async {
    final directory = Directory("output");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    await File("output/checkmarx-request.json").writeAsString(requestBody, mode: FileMode.writeOnly);
    await File("output/checkmarx-response.json").writeAsString(responseBody, mode: FileMode.writeOnly);
  }
}
