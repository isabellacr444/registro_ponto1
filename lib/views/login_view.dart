import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email / NIF')),
            TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: vm.loading ? null : () async {
                final ok = await vm.signIn(_email.text.trim(), _pass.text);
                if (ok) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
                else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credenciais inválidas')));
              },
              child: vm.loading ? const CircularProgressIndicator() : const Text('Entrar'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final ok = await vm.signInBiometric();
                if (ok) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
                else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Biometria falhou')));
              },
              child: const Text('Entrar com Biometria'),
            )
          ],
        ),
      ),
    );
  }
}
