import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePinDatasource {
  SecurePinDatasource(this._storage);

  final FlutterSecureStorage _storage;
  static const _pinHashKey = 'kairo_pin_hash';

  Future<bool> hasPin() async {
    final value = await _storage.read(key: _pinHashKey);
    return value != null;
  }

  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinHashKey, value: _hashPin(pin));
  }

  Future<bool> verifyPin(String pin) async {
    final storedHash = await _storage.read(key: _pinHashKey);
    if (storedHash == null) return false;
    return _hashPin(pin) == storedHash;
  }

  Future<void> clearPin() async {
    await _storage.delete(key: _pinHashKey);
  }

  String _hashPin(String pin) => sha256.convert(utf8.encode(pin)).toString();
}
