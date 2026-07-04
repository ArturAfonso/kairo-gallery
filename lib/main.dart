import 'package:flutter/material.dart';
import 'package:kairo_gallery/app.dart';
import 'package:kairo_gallery/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const KairoApp());
}
