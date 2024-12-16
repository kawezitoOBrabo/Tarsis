// DAO - DATA ACCESS OBJECT
import 'package:Tarsis/db/db_helper.dart';
import 'package:Tarsis/domain/domain_video_player.dart';
import 'package:sqflite/sqflite.dart';

class PaginaDao {
  Future<List<DomainVideoPlayer>> listaPaginas() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM PAGINAS;';

    var result = await db.rawQuery(sql);

    List<DomainVideoPlayer> lista = [];

    for (var json in result) {
      DomainVideoPlayer paginas = DomainVideoPlayer.fromJson(json);
      lista.add(paginas);
    }
    return lista;
  }
}