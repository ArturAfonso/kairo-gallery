import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kairo_gallery/core/di/injection.dart';
import 'package:kairo_gallery/core/theme/app_theme.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_cubit.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_state.dart';

class LockScreenPage extends StatelessWidget {
  const LockScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: sl<AuthLockCubit>(), child: const _LockScreenView());
  }
}

class _LockScreenView extends StatefulWidget {
  const _LockScreenView();

  @override
  State<_LockScreenView> createState() => _LockScreenViewState();
}

class _LockScreenViewState extends State<_LockScreenView> with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  double _shakeOffset(double t) => 12 * sin(t * pi * 6) * (1 - t);

  @override
  Widget build(BuildContext context) {
    final kairoColors = context.kairoColors;
    final kairoText = context.kairoText;

    return Scaffold(
      backgroundColor: kairoColors.cream,
      body: SafeArea(
        child: BlocConsumer<AuthLockCubit, AuthLockState>(
          listener: (context, state) {
            if (state.status == AuthLockStatus.wrongPin) {
              _shakeController.forward(from: 0);
            }
          },
          builder: (context, state) {
            final isError = state.status == AuthLockStatus.wrongPin;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _LockIcon(isError: isError),
                  const SizedBox(height: 24),
                  Text('Bem-vindo de volta', style: kairoText.titleLarge),
                  const SizedBox(height: 8),
                  Text('Digite seu PIN para abrir a Kairo', style: kairoText.bodyMedium),
                  const SizedBox(height: 32),
                  AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      return Transform.translate(offset: Offset(_shakeOffset(_shakeController.value), 0), child: child);
                    },
                    child: _PinDots(filled: state.enteredDigits, total: state.pinLength, isError: isError),
                  ),
                  const Spacer(flex: 3),
                  _NumPad(
                    onDigit: context.read<AuthLockCubit>().onDigitPressed,
                    onBackspace: context.read<AuthLockCubit>().onBackspacePressed,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _showForgotPinSheet(context),
                    style: TextButton.styleFrom(foregroundColor: kairoColors.terracota),
                    child: const Text('Esqueci meu PIN'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showForgotPinSheet(BuildContext context) {
    final kairoColors = context.kairoColors;
    final kairoText = context.kairoText;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kairoColors.cardBackground,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Esqueceu seu PIN?', style: kairoText.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Por segurança, o PIN não pode ser recuperado. '
              'Você precisará reinstalar o app (isso não apaga suas fotos, só o PIN).',
              textAlign: TextAlign.center,
              style: kairoText.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kairoColors.terracota),
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LockIcon extends StatelessWidget {
  const _LockIcon({required this.isError});
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = context.kairoColors;
    final color = isError ? colors.terracotaEscuro : colors.terracota;
    return CircleAvatar(
      radius: 32,
      backgroundColor: color.withValues(alpha: 0.12),
      child: Icon(Icons.lock_outline, color: color, size: 28),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({required this.filled, required this.total, required this.isError});
  final int filled;
  final int total;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = context.kairoColors;
    final color = isError ? colors.terracotaEscuro : colors.terracota;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final isFilled = index < filled;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: isFilled ? color : color.withValues(alpha: 0.25)),
        );
      }),
    );
  }
}

class _NumPad extends StatelessWidget {
  const _NumPad({required this.onDigit, required this.onBackspace});
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [null, '0', 'backspace'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              if (key == null) return const SizedBox(width: 64, height: 64);
              if (key == 'backspace') {
                return _NumPadKey(onTap: onBackspace, child: const Icon(Icons.backspace_outlined));
              }
              return _NumPadKey(
                child: Text(key, style: const TextStyle(fontSize: 24)),
                onTap: () => onDigit(key),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _NumPadKey extends StatelessWidget {
  const _NumPadKey({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.kairoColors.cardBackground,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(width: 64, height: 64, child: Center(child: child)),
      ),
    );
  }
}
