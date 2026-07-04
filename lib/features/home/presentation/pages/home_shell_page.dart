import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo_gallery/core/theme/theme_cubit.dart';

class HomeShellPage extends StatelessWidget {
  const HomeShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.photo_library_outlined), label: 'Galeria'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.delete_outline), label: 'Lixeira'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
