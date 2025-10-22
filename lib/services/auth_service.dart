
import 'package:local_auth/local_auth.dart';


final LocalAuthentication _localAuth = LocalAuthentication();

Future<bool> authenticateBiometric() async {
  // Verifica se há biometria disponível ou suporte no dispositivo
  final canCheck = await _localAuth.canCheckBiometrics;
  final isSupported = await _localAuth.isDeviceSupported();
  final can = canCheck || isSupported;

  if (!can) return false;

  try {
    return await _localAuth.authenticate(
      localizedReason: 'Autentique-se para continuar',
        biometricOnly: true,
      );
  } catch (e) {
    print('Erro na autenticação biométrica: $e');
    return false;
  }
}

class AuthenticationOptions {
  const AuthenticationOptions({required this.biometricOnly, required this.stickyAuth});
  final bool biometricOnly;
  final bool stickyAuth;
}
