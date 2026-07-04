import 'package:flutter/material.dart';
import 'package:kairo_gallery/core/di/injection.dart';
import 'package:kairo_gallery/core/theme/theme_cubit.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_cubit.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});

  final cubit = sl<AuthLockCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Center(
        child: Column(
          children: [
            Text('Gallery Page'),
            ElevatedButton(
              onPressed: () {
                cubit.lock();
              },
              child: Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}
