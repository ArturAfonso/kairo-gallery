import 'package:equatable/equatable.dart';

enum AuthLockStatus { checking, locked, wrongPin, unlocked }

class AuthLockState extends Equatable {
  const AuthLockState({required this.status, this.enteredDigits = 0, this.pinLength = 4});

  static const initial = AuthLockState(status: AuthLockStatus.checking);

  final AuthLockStatus status;
  final int enteredDigits;
  final int pinLength;

  bool get isUnlocked => status == AuthLockStatus.unlocked;

  AuthLockState copyWith({AuthLockStatus? status, int? enteredDigits}) {
    return AuthLockState(
      status: status ?? this.status,
      enteredDigits: enteredDigits ?? this.enteredDigits,
      pinLength: pinLength,
    );
  }

  @override
  List<Object?> get props => [status, enteredDigits, pinLength];
}
