import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "mensagem.db");

    // Abre o banco de dados e cria a tabela caso não exista.
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    print("Database path: $dbPath");
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    // SQL para criar a tabela MENSAGEM
    String sql = '''
      CREATE TABLE MENSAGEM (
        id INTEGER PRIMARY KEY,
        tela_id INTEGER,
        imagem TEXT,
        nomePerfil TEXT,
        tempoMensagem TEXT,
        mensagem TEXT,
        views TEXT
      );
    ''';
    await db.execute(sql);

    // Exemplo de inserção inicial de dados
    sql = '''
      INSERT INTO MENSAGEM (
        id, 
        tela_id,
        imagem, 
        nomePerfil, 
        tempoMensagem, 
        mensagem, 
        views
      ) VALUES 
        (1, 1, 'https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1', 'CottonBro', '10 sem', 'Adorei a explicação, muito clara e objetiva', '3400'),
        (2, 1, 'https://images.pexels.com/users/avatars/12345/alex-40.jpeg', 'Alex', '5 min', 'Muito interessante, parabéns!', '1500'),
        (3, 1, 'https://images.pexels.com/users/avatars/6789/emma-40.jpeg', 'Emma', '20 min', 'Gostei do ponto abordado, excelente.', '1200'),
        (4, 1, 'https://images.pexels.com/users/avatars/54321/john-40.jpeg', 'John', '1 hora', 'Conteúdo relevante e direto.', '3000'),
        (5, 1, 'https://images.pexels.com/users/avatars/9876/mary-40.jpeg', 'Mary', '2 horas', 'Muito esclarecedor, obrigada!', '2200'),
      
        (6, 2, 'https://images.pexels.com/users/avatars/123456/julia-40.jpeg', 'Julia', '1 dia', 'Isso ajudou bastante no meu trabalho.', '4100'),
        (7, 2, 'https://images.pexels.com/users/avatars/65432/paul-40.jpeg', 'Paul', '3 dias', 'Incrível! Continue assim.', '1800'),
        (8, 2, 'https://images.pexels.com/users/avatars/11111/lara-40.jpeg', 'Lara', '2 horas', 'Uma das melhores explicações que já vi.', '3000'),
        (9, 2, 'https://images.pexels.com/users/avatars/7777/adam-40.jpeg', 'Adam', '4 dias', 'Esse conteúdo é top!', '2700'),
        (10, 2, 'https://images.pexels.com/users/avatars/8888/nina-40.jpeg', 'Nina', '1 semana', 'Adorei, muito bem elaborado.', '3200'),
      
        (11, 3, 'https://images.pexels.com/users/avatars/23456/leo-40.jpeg', 'Leo', '8 horas', 'Explicação objetiva, ótimo trabalho!', '2400'),
        (12, 3, 'https://images.pexels.com/users/avatars/34567/sara-40.jpeg', 'Sara', '12 horas', 'Ficou incrível, obrigado por compartilhar.', '3300'),
        (13, 3, 'https://images.pexels.com/users/avatars/45678/mike-40.jpeg', 'Mike', '2 semanas', 'Amei o conteúdo, parabéns.', '3500'),
        (14, 3, 'https://images.pexels.com/users/avatars/56789/zoe-40.jpeg', 'Zoe', '3 semanas', 'Muito detalhado, adorei!', '3100'),
        (15, 3, 'https://images.pexels.com/users/avatars/67890/chris-40.jpeg', 'Chris', '4 semanas', 'Perfeito para iniciantes.', '2600'),
      
        (16, 4, 'https://images.pexels.com/users/avatars/7890/lucas-40.jpeg', 'Lucas', '1 mês', 'Nunca vi uma explicação tão completa.', '2900'),
        (17, 4, 'https://images.pexels.com/users/avatars/8901/ana-40.jpeg', 'Ana', '2 meses', 'Valeu muito a pena assistir.', '4100'),
        (18, 4, 'https://images.pexels.com/users/avatars/9012/tom-40.jpeg', 'Tom', '5 minutos', 'Foi direto ao ponto, obrigado!', '3200'),
        (19, 4, 'https://images.pexels.com/users/avatars/12321/lis-40.jpeg', 'Lis', '8 minutos', 'Conteúdo muito bem explicado.', '2800'),
        (20, 4, 'https://images.pexels.com/users/avatars/4321/nat-40.jpeg', 'Nat', '15 minutos', 'A melhor análise sobre o tema.', '3000'),
      
        (21, 5, 'https://images.pexels.com/users/avatars/5432/rob-40.jpeg', 'Rob', '6 horas', 'Fiquei muito satisfeito, ótimo!', '2900'),
        (22, 5, 'https://images.pexels.com/users/avatars/6543/camila-40.jpeg', 'Camila', '3 dias', 'Me ajudou bastante, valeu!', '3300'),
        (23, 5, 'https://images.pexels.com/users/avatars/7654/noah-40.jpeg', 'Noah', '1 dia', 'Incrível como tudo foi abordado.', '3700'),
        (24, 5, 'https://images.pexels.com/users/avatars/8765/vic-40.jpeg', 'Vic', '10 dias', 'Gostei da abordagem técnica.', '2500'),
        (25, 5, 'https://images.pexels.com/users/avatars/9876/sophia-40.jpeg', 'Sophia', '15 dias', 'Muito inspirador, obrigado!', '3600');
    ''';
    await db.execute(sql);

    sql = '''
      CREATE TABLE PAGINA (
        id INTEGER PRIMARY KEY,
        video TEXT,
        perfilImagem TEXT,
        nomePerfil TEXT,
        descricao TEXT, 
        musica TEXT,
      );
    ''';

    sql = ''' 
      INSERT INTO PAGINA (
        id,
        pagina_id,
        video,
        perfilImagem,
        nomePerfil,
        descricao,
        musica
    ) VALUES
      (1, 'https://example.com/video1.mp4', 'https://example.com/profile1.jpg', 'João Silva', 'Passeando pela praia ao pôr do sol.', 'Calm Waves - Ocean Sounds'),
      (2, 'https://example.com/video2.mp4', 'https://example.com/profile2.jpg', 'Ana Clara', 'Aprendendo novas receitas deliciosas.', 'Kitchen Vibes - Smooth Jazz'),
      (3, 'https://example.com/video3.mp4', 'https://example.com/profile3.jpg', 'Carlos Eduardo', 'Trilha nas montanhas com amigos.', 'Adventure Beats - Electro Pop'),
      (4, 'https://example.com/video4.mp4', 'https://example.com/profile4.jpg', 'Maria Fernanda', 'Um dia no parque com a família.', 'Nature Harmony - Acoustic Guitar'),
      (5, 'https://example.com/video5.mp4', 'https://example.com/profile5.jpg', 'Rafael Santos', 'Mostrando meu setup gamer atualizado.', 'Techno Waves - EDM Mix');
    ''';
  }
}