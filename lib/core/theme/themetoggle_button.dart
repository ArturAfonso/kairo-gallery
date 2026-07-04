import 'package:flutter/material.dart';
import 'package:kairo_gallery/core/di/injection.dart';
import 'package:kairo_gallery/core/theme/theme_cubit.dart';

class ThemetoggleButton extends StatelessWidget {
  const ThemetoggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<ThemeCubit>();
    final isDark = cubit.state == ThemeMode.dark;
    return IconButton(
      onPressed: () {
        cubit.setTheme(isDark ? ThemeMode.light : ThemeMode.dark);
      },
      icon: Icon(!isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
    );
  }
}
