import 'package:firebase_auth/firebase_auth.dart';

class RecoveryPassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> recoveryPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Email enviado com sucesso!');
    } on FirebaseAuthException catch (e) {
      print('Erro ao enviar o email: ${e.message}');
    } catch (e) {
      print('Erro desconhecido: $e');
    }
  }

  Future<void> changePasswordWithToken(String token, String newPassword) async {
    try {
      UserCredential userCredential = await _auth.signInWithCustomToken(token);

      await userCredential.user?.updatePassword(newPassword);
      print('Senha alterada com sucesso!');
    } on FirebaseAuthException catch (e) {
      print('Erro ao alterar a senha: ${e.message}');
    } catch (e) {
      print('Erro desconhecido: $e');
    }
  }
}
