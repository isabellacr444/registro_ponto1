import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:registro_ponto1/controllers/auth_controller.dart' show AuthService;

class AuthViewModel extends ChangeNotifier {
  final AuthService _auth = AuthService();
  bool loading = false;

  // expose minimal API for UI
  Future<bool> signIn(String email, String password) async {
    loading = true;
    notifyListeners();
    try {
 final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
 final user = userCredential.user;
 return user != null;

    } catch (_) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> signInBiometric() async {
    return await _auth.authenticateBiometric();
  }
}
