import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hashlib/hashlib.dart';

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
  Future<String?> getBackupKey() async {
    String? key = await _secureStorage.read(key: "backupKey");
    if (key == null) {
      return null;
    } else {
      return key;
    }
  }

  Future<void> setBackupKey({required String backupPassword}) async {
    final salt = List.generate(16, (i) => Random.secure().nextInt(256));
    final pass = utf8.encode(backupPassword);
    final argon2 = Argon2(
      version: Argon2Version.v13,
      type: Argon2Type.argon2id,
      hashLength: 32,
      iterations: 2,
      parallelism: 8,
      memorySizeKB: 1 << 18,
      salt: salt,
    );
    final digest = argon2.convert(pass);
    final keyValue = "${base64Encode(salt)}\$${digest.base64()}";
    await _secureStorage.write(key: "backupKey", value: keyValue);
  }

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
