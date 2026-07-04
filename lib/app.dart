import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kairo_gallery/core/di/injection.dart';
import 'package:kairo_gallery/core/router/app_router.dart';
import 'package:kairo_gallery/core/theme/app_theme.dart';
import 'package:kairo_gallery/core/theme/theme_cubit.dart';

class KairoApp extends StatelessWidget {
  const KairoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      bloc: sl<ThemeCubit>(),
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Kairo Gallery',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
