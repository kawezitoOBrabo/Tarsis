import 'package:login/db/db_helper.dart';
import 'package:login/domain/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  // Método de autenticação, que agora utiliza 'email' em vez de 'username'
  autenticar(String email, String password) async {
    Database db = await DBHelper().initDB();

    // Consulta para verificar se o email e a senha correspondem a algum usuário no banco de dados
    String sql = 'SELECT * FROM USER '
        'WHERE email = ? AND '
        'password = ?;';

    var result = await db.rawQuery(sql, [email, password]);
    return result.isNotEmpty;  // Retorna verdadeiro se encontrar algum usuário com esse email e senha
  }

  // Método para salvar um novo usuário no banco de dados
  saveUser(User user) async {
    Database db = await DBHelper().initDB();
    await db.insert('USER', user.toJson());  // Salva os dados do usuário no banco
  }
}
