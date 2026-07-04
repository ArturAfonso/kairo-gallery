import 'package:kairo_gallery/features/auth_lock/data/datasources/secure_pin_datasource.dart';
import 'package:kairo_gallery/features/auth_lock/domain/repositories/auth_lock_repository.dart';

class AuthLockRepositoryImpl implements AuthLockRepository {
  AuthLockRepositoryImpl(this._datasource);
  final SecurePinDatasource _datasource;

  @override
  Future<bool> hasPinConfigured() => _datasource.hasPin();

  @override
  Future<void> setPin(String pin) => _datasource.savePin(pin);

  @override
  Future<bool> verifyPin(String pin) => _datasource.verifyPin(pin);

  @override
  Future<void> clearPin() => _datasource.clearPin();
}
