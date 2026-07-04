abstract interface class AuthLockRepository {
  Future<bool> hasPinConfigured();
  Future<void> setPin(String pin);
  Future<bool> verifyPin(String pin);
  Future<void> clearPin();
}
