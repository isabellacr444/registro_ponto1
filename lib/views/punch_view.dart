import 'package:flutter/material.dart';
import 'package:registro_pont01/controllers/auth_controller.dart';
import '../services/location_service.dart';
import '../services/firestore_service.dart';
import '../config/app_config.dart';
import '../utils/distance_calculator.dart';

class PunchView extends StatefulWidget {
  const PunchView({super.key});
  @override
  State<PunchView> createState() => _PunchViewState();
}

class _PunchViewState extends State<PunchView> {
  final loc = LocationService();
  final fs = FirestoreService();
  final auth = AuthService();
  double? lastDistance;
  bool loading = false;

  Future<void> attemptPunch() async {
    setState(() => loading = true);
    try {
      final pos = await loc.getCurrentPosition();
      final dist = DistanceCalculator.distanceBetween(pos.latitude, pos.longitude, AppConfig.officeLat, AppConfig.officeLng);
      setState(() => lastDistance = dist);
      if (dist <= AppConfig.maxDistanceMeters) {
        final user = auth.currentUser;
        if (user == null) throw Exception('Usuário não autenticado');
        await fs.savePunch(user.uid, pos.latitude, pos.longitude, DateTime.now());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ponto registrado')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fora da área (${dist.toStringAsFixed(1)} m)')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bater Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Local de trabalho: ${AppConfig.officeLat}, ${AppConfig.officeLng}'),
            const SizedBox(height: 8),
            if (lastDistance != null) Text('Última distância: ${lastDistance!.toStringAsFixed(1)} m'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: loading ? null : attemptPunch, child: Text(loading ? 'Verificando...' : 'Bater Ponto')),
          ],
        ),
      ),
    );
  }
}
