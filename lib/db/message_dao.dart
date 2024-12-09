// DAO - DATA ACCESS OBJECT
import 'package:Tarsis/db/db_helper.dart';
import 'package:Tarsis/domain/message_card_class.dart';
import 'package:sqflite/sqflite.dart';

class MessageDao {
  Future<List<MessageCardClass>> listarPacotes() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM MENSAGEM;';

    var result = await db.rawQuery(sql);
    // [
    // { 'id' : 1, 'titulo': 'a' },
    // { 'id' : 2, 'titulo': 'a' },
    // { 'id' : 3, 'titulo': 'a' }
    // ]
    List<MessageCardClass> lista = [];
    for (var json in result) {
      MessageCardClass mensagem = MessageCardClass.fromJson(json);
      lista.add(mensagem);
    }

    return lista;
  }
}