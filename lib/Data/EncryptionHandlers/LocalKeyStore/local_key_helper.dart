import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalKeyStore {
  LocalKeyStore._privateConstructor();

  static final LocalKeyStore _instance = LocalKeyStore._privateConstructor();

  factory LocalKeyStore() {
    return _instance;
  }
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions.biometric(
      enforceBiometrics: true,
      resetOnError: true,
    ),
  );
  String? _cachedKey;

  Future<String> getKey() async {
    if (_cachedKey != null) {
      return _cachedKey!;
    }
    String? key = await _secureStorage.read(key: "key");
    if (key == null) {
      final String newKey = await Isolate.run(() {
        final ikey = List<int>.generate(
          16,
          (_) => Random.secure().nextInt(256),
        );
        return base64.encode(ikey);
      });
      await _secureStorage.write(key: "key", value: newKey);
      key = newKey;
    }
    _cachedKey = key;
    return key;
  }

  void clearKey() {
    _cachedKey = null;
  }
}
