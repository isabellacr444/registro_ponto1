import 'package:flutter/material.dart';
import 'punch_view.dart';
import 'history_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PunchView())), child: const Text('Bater Ponto')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryView())), child: const Text('Histórico')),
          ],
        ),
      ),
    );
  }
}
