import 'package:flutter/material.dart';
import 'package:Tarsis/widget/card_video_player.dart';
import 'package:Tarsis/domain/domain_video_player.dart';
import 'package:Tarsis/db/page_dao.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  late Future<List<DomainVideoPlayer>> futureVideos;

  @override
  void initState() {
    super.initState();
    futureVideos = _loadVideos();
  }

  Future<List<DomainVideoPlayer>> _loadVideos() async {
    try {
      PaginaDao dao = PaginaDao();
      return await dao.listaPaginas();
    } catch (e) {
      print("Erro ao carregar os vídeos: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DomainVideoPlayer>>(
        future: futureVideos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ocorreu um erro inesperado!'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<DomainVideoPlayer> videos = snapshot.data!;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoPlayerScreen(
                  domain_videoPlayer: videos[index],
                  telaIdAtual: index + 1,
                );
              },
            );
          } else {
            // Caso não haja dados
            return const Center(child: Text('Nenhum vídeo encontrado.'));
          }
        },
      ),
    );
  }
}
