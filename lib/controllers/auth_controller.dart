// ignore: unused_import
import '../services/auth_service.dart';
/// Controller simples que expõe métodos sincronizados para as views.
class AuthController {
  final AuthService _service;
  AuthController(this._service);

  Future login(String email, String password) async {
    return await _service.signInWithEmail(email, password);
  }

  Future<bool> biometricLogin() async {
    return await _service.authenticateBiometric();
  }
}

class   AuthService {
  get currentUser => null;

  Future<void> signInWithEmail(String email, String password) async {
    // Lógica de autenticação aqui
  }

  Future<bool> authenticateBiometric() async {
    // Lógica de autenticação biométrica aqui
    return await authenticateBiometric();
  }

  Future signInWithEmailAndPassword({required String email, required String password}) async {}
}
