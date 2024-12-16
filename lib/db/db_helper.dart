import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "recycle.db");

    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    print("Database path: $dbPath");
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE PAGINAS (
        id INTEGER PRIMARY KEY,
        video TEXT,
        perfilImagem TEXT,
        nomePerfil TEXT,
        descricao TEXT,
        musica TEXT
      );
    ''');

    await db.execute('''
      INSERT INTO PAGINAS (
        id, video, perfilImagem, nomePerfil, descricao, musica
      ) VALUES
        (1, 'https://videos.pexels.com/video-files/28699246/12454963_1440_2560_50fps.mp4', 'https://images.pexels.com/users/avatars/522575817/iddea-photo-898.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'LeitoraAvida', 'Mulher lendo livro no campo durante o pôr do sol.', 'Sem música'),
        (2, 'https://videos.pexels.com/video-files/10677320/10677320-uhd_1440_2732_25fps.mp4', 'https://images.pexels.com/users/avatars/1302114817/a-b-s-498.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'GatiinhosFofos', 'Gato britânico de pelo curto relaxando dentro de casa.', 'Sem música'),
        (3, 'https://videos.pexels.com/video-files/28663010/12445553_1080_1920_60fps.mp4', 'https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'Carlos Eduardo', 'Trilha nas montanhas com amigos.', 'Adventure Beats - Electro Pop'),
        (4, 'https://videos.pexels.com/video-files/4920770/4920770-uhd_1440_2732_25fps.mp4', 'https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'Maria Fernanda', 'Um dia no parque com a família.', 'Nature Harmony - Acoustic Guitar'),
        (5, 'https://videos.pexels.com/video-files/6395999/6395999-hd_1080_1920_25fps.mp4', 'https://images.pexels.com/users/avatars/2297095/pavel-danilyuk-690.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'Rafael Santana', 'Mostrando meu setup gamer atualizado.', 'Techno Waves - EDM Mix');
    ''');

    await db.execute('''
      CREATE TABLE MENSAGEM (
        id INTEGER PRIMARY KEY,
        tela_id INTEGER,
        imagem TEXT,
        nomePerfil TEXT,
        tempoMensagem TEXT,
        mensagem TEXT,
        views INT
      );
    ''');

    await db.execute('''
      INSERT INTO MENSAGEM (
        id, tela_id, imagem, nomePerfil, tempoMensagem, mensagem, views
      ) VALUES 
        (1, 1, 'https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg', 'CottonBro', '10 sem', 'Adorei a explicação, muito clara e objetiva', 3400),
        (2, 2, 'https://images.pexels.com/users/avatars/123456/julia-40.jpeg', 'Julia', '1 dia', 'Isso ajudou bastante no meu trabalho.', 4100),
        (3, 3, 'https://images.pexels.com/users/avatars/23456/leo-40.jpeg', 'Leo', '8 horas', 'Explicação objetiva, ótimo trabalho!', 2400),      
        (4, 4, 'https://images.pexels.com/users/avatars/7890/lucas-40.jpeg', 'Lucas', '1 mês', 'Nunca vi uma explicação tão completa.', 2900),        
        (5, 5, 'https://images.pexels.com/users/avatars/5432/rob-40.jpeg', 'Rob', '6 horas', 'Fiquei muito satisfeito, ótimo!', 2900);
      ''');

    await db.execute('''
      CREATE TABLE USER (
        username varchar(100) PRIMARY KEY,
        password varchar(100),
        email varchar(100),
        cpf varchar(20)
      );
    ''');

    await db.execute('''
        INSERT INTO USER (username, password, email, cpf) 
        VALUES ('joao@gmail.com', '123456', 'joao@gmail.com','123.456.789-00');
    ''');
  }
}
