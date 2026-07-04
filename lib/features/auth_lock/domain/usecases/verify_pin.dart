// verify_pin.dart
import 'package:kairo_gallery/features/auth_lock/domain/repositories/auth_lock_repository.dart';

class VerifyPin {
  VerifyPin(this._repository);
  final AuthLockRepository _repository;
  Future<bool> call(String pin) => _repository.verifyPin(pin);
}

// set_pin.dart
class SetPin {
  SetPin(this._repository);
  final AuthLockRepository _repository;
  Future<void> call(String pin) => _repository.setPin(pin);
}

// has_pin_configured.dart
class HasPinConfigured {
  HasPinConfigured(this._repository);
  final AuthLockRepository _repository;
  Future<bool> call() => _repository.hasPinConfigured();
}
