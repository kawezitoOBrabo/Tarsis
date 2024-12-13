import 'package:flutter/material.dart';
import 'package:Tarsis/widget/card_video_player.dart';
import 'package:Tarsis/domain/domain_video_player.dart';
import 'package:Tarsis/db/pagina_dao.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  List<DomainVideoPlayer> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      PaginaDao dao = PaginaDao();
      List<DomainVideoPlayer> videos = await dao.listaPaginas();
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar os vídeos: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return VideoPlayerScreen(
            domain_videoPlayer: _videos[index],
            telaIdAtual: index + 1,
          );
        },
      ),
    );
  }
}
