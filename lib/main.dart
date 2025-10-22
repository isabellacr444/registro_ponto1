
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'config/app_config.dart';
import 'view_models/auth_view_model.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Inicializar Firebase aqui (flutterfire configure -> lib/firebase_options.dart)
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        // adicionar outros view_models
      ],
      child: MaterialApp(
        title: 'Registro de Ponto',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const LoginView(),
      ),
    );
  }
}
