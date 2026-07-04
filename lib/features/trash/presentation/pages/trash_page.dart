import 'package:flutter/material.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lixeira')),
      body: const Center(child: Text('Itens removidos')),
    );
  }
}
