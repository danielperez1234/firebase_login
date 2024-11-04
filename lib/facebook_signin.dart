import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<User?> signInWithFacebook() async {
  // Instancia de FirebaseAuth
  FirebaseAuth auth = FirebaseAuth.instance;

  // Iniciar sesión con Facebook
  final LoginResult result = await FacebookAuth.instance.login();
  if (result.status == LoginStatus.success) {
    // Si la autenticación fue exitosa, obtén el token de acceso
    final AccessToken? facebookAccessToken = result.accessToken;

    // Usa el token de acceso para crear las credenciales de Facebook en Firebase
    final OAuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken!.tokenString);

    // Inicia sesión en Firebase con las credenciales de Facebook
    final UserCredential userCredential = await auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      print("Inicio de sesión exitoso: ${user.displayName}");
    }

    return user;
  } else {
    print("Error en el inicio de sesión: ${result.message}");
    return null;
  }
}
