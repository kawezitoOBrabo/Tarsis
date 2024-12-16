import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "pacote.db");
    Database database = await openDatabase(
      dbPath,
      version: 2, // Aumenta a versão para indicar que houve alterações no banco
      onCreate: onCreate,
    );

    // Coloque o print aqui para garantir que o banco está aberto
    print(dbPath);

    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    // Criar a tabela USER com os novos campos: username, password, email, cpf
    String sql = '''
      CREATE TABLE USER (
        username varchar(100) PRIMARY KEY,
        password varchar(100),
        email varchar(100),
        cpf varchar(20)
      );
    ''';
    await db.execute(sql);

    // Inserir um usuário de exemplo
    sql =
        "INSERT INTO USER (username, password, email, cpf) VALUES ('joao@gmail.com', '123456', 'joao@gmail.com', '123.456.789-00')";
    await db.execute(sql);
  }

  // Método onUpgrade para lidar com mudanças de versão do banco de dados
}
