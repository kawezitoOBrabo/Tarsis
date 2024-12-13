import 'package:Tarsis/db/db_helper.dart';
import 'package:Tarsis/domain/message_card_class.dart';
import 'package:sqflite/sqflite.dart';

class MessageDao {
  Future<List<MessageCardClass>> listarMensagem(int telaId) async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM MENSAGEM WHERE tela_id = ?'; // Filtra por tela_id
    var result = await db.rawQuery(sql, [telaId]); // Passa o tela_id como parâmetro

    List<MessageCardClass> lista = [];

    // Verifica se não há resultados
    if (result.isEmpty) {
      print("Nenhuma mensagem encontrada para tela_id $telaId");
      return lista;
    }

    for (var json in result) {
      MessageCardClass mensagem = MessageCardClass.fromJson(json);
      lista.add(mensagem);
    }

    return lista;
  }

  // Método para inserir a nova mensagem no banco de dados
  Future<void> inserirMensagem(MessageCardClass mensagem) async {
    Database db = await DBHelper().initDB();

    await db.insert(
      'MENSAGEM',
      mensagem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Caso a mensagem já exista, substitui
    );
  }
}
