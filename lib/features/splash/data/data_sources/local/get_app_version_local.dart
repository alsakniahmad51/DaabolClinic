import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;

Future<String> getAppVersion() async {
  try {
    final pubspecContent = await rootBundle.loadString('pubspec.yaml');

    final versionLine = pubspecContent.split('\n').firstWhere(
          (line) => line.startsWith('version:'),
        );

    final version = versionLine.split(':').last.trim();
    log(version);
    return version;
  } catch (e) {
    // ignore: avoid_print
    print('Failed to load app version: $e');
    log(e.toString());
    return e.toString();
  }
}
