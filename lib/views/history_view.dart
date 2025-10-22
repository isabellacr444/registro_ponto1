import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registro_ponto1/controllers/auth_controller.dart';
import '../services/firestore_service.dart';
// ignore: unused_import
import '../services/auth_service.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final fs = FirestoreService();
    final auth = AuthService();
    final user = auth.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text('Usuário não autenticado')));
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: StreamBuilder<QuerySnapshot>(
        stream: fs.punchesFor(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Erro'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('Nenhum registro'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i];
              final ts = (d['timestamp'] as Timestamp).toDate();
              return ListTile(
                title: Text(DateFormat('yyyy-MM-dd HH:mm').format(ts)),
                subtitle: Text('Lat:${d['lat']} Lng:${d['lng']}'),
              );
            },
          );
        },
      ),
    );
  }
}

class DateFormat {
  DateFormat(String pattern);

  String format(DateTime date) {
    // Implementar formatação de data
    return '';
  }
}
