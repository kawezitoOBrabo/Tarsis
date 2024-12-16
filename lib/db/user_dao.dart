import 'package:Tarsis/db/db_helper.dart';
import 'package:Tarsis/domain/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  autenticar(String email, String password) async {
    Database db = await DBHelper().initDB();

    String sql = 'SELECT * FROM USER '
        'WHERE email = ? AND '
        'password = ?;';

    var result = await db.rawQuery(sql, [email, password]);
    return result.isNotEmpty;
  }

  // Método para salvar um novo usuário no banco de dados
  saveUser(User user) async {
    Database db = await DBHelper().initDB();
    await db.insert('USER', user.toJson());
  }
}