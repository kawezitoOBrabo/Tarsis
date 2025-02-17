import 'dart:convert';
import 'package:http/http.dart' as http;

class RecoveryPassword {
  Future<void> recoveryPassword(String userIdOrEmail) async {
    final url = Uri.parse(
        'http://localhost:8051/api/framework/v1/users/$userIdOrEmail/recoveryPassword');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('Email enviado com sucesso!');
    } else {
      print('Erro ao enviar o email: ${response.body}');
    }
  }

  Future<void> changePasswordWithToken(
      String userIdOrEmail, String token, String newPassword) async {
    final url = Uri.parse(
        'http://localhost:8051/api/framework/v1/users/$userIdOrEmail/changePasswordWithToken');

    final payload = json.encode({
      "lastPassword": token,
      "newPassword": newPassword,
      "confirmationPassword": newPassword,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: payload,
    );

    if (response.statusCode == 200) {
      print('Senha alterada com sucesso!');
    } else {
      print('Erro ao alterar a senha: ${response.body}');
    }
  }
}
