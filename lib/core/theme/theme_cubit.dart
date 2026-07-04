import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _storageKey = 'theme_mode';
  final FlutterSecureStorage _storage;

  ThemeCubit(this._storage) : super(ThemeMode.system);

  Future<void> loadTheme() async {
    final value = await _storage.read(key: _storageKey);
    switch (value) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    await _storage.write(
      key: _storageKey,
      value: mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.dark
              ? 'dark'
              : 'system',
    );
  }
}