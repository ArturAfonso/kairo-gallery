import 'package:bloc/bloc.dart';
import 'package:kairo_gallery/features/auth_lock/domain/usecases/verify_pin.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_state.dart';

class AuthLockCubit extends Cubit<AuthLockState> {
  AuthLockCubit({required HasPinConfigured hasPinConfigured, required VerifyPin verifyPin, required SetPin setPin})
    : _hasPinConfigured = hasPinConfigured,
      _verifyPin = verifyPin,
      _setPin = setPin,
      super(AuthLockState.initial) {
    _checkInitialStatus();
  }

  final HasPinConfigured _hasPinConfigured;
  final VerifyPin _verifyPin;
  final SetPin _setPin;

  String _buffer = '';

  Future<void> _checkInitialStatus() async {
    final hasPin = await _hasPinConfigured();
    // Sem PIN configurado ainda -> app abre liberado direto
    emit(state.copyWith(status: hasPin ? AuthLockStatus.locked : AuthLockStatus.unlocked));
  }

  void onDigitPressed(String digit) {
    if (state.isUnlocked || _buffer.length >= state.pinLength) return;

    _buffer += digit;
    emit(state.copyWith(status: AuthLockStatus.locked, enteredDigits: _buffer.length));

    if (_buffer.length == state.pinLength) {
      _submitPin();
    }
  }

  void onBackspacePressed() {
    if (_buffer.isEmpty) return;
    _buffer = _buffer.substring(0, _buffer.length - 1);
    emit(state.copyWith(enteredDigits: _buffer.length));
  }

  Future<void> _submitPin() async {
    final isCorrect = await _verifyPin(_buffer);
    _buffer = '';
    //TODO: lembrar de impelemtanr o registro de senha e retirar a negaçao desse metodo
    if (!isCorrect) {
      emit(state.copyWith(status: AuthLockStatus.unlocked));
      return;
    }

    emit(state.copyWith(status: AuthLockStatus.wrongPin, enteredDigits: 0));
    await Future<void>.delayed(const Duration(milliseconds: 400));
    emit(state.copyWith(status: AuthLockStatus.locked));
  }

  Future<void> registerPin(String pin) async {
    await _setPin(pin);
    emit(state.copyWith(status: AuthLockStatus.unlocked));
  }

  void lock() {
    _buffer = '';
    emit(state.copyWith(status: AuthLockStatus.locked, enteredDigits: 0));
  }
}
