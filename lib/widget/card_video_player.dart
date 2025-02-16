import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:Tarsis/db/message_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Tarsis/domain/domain_video_player.dart';
import 'package:Tarsis/domain/message_card_class.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:screenshot/screenshot.dart';
import "package:share_plus/share_plus.dart";
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class VideoPlayerScreen extends StatefulWidget {
  final DomainVideoPlayer domain_videoPlayer;
  final int telaIdAtual;

  const VideoPlayerScreen({
    super.key,
    required this.domain_videoPlayer,
    required this.telaIdAtual,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  DomainVideoPlayer get domainVideoPlayer => widget.domain_videoPlayer;
  late Future<List<MessageCardClass>> _messagesFuture;
  List<bool> _isFavorite = [];

  late VideoPlayerController _controller;
  final controller = ScreenshotController();
  final TextEditingController _textVideo = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nomeImagemSalva = TextEditingController();
  final TextEditingController _nomeCaminhoImagemSalva = TextEditingController();

  int selectedItemIndex = 0;

  Color _iconColor = Colors.white;
  Color _seguirColor = Colors.transparent;
  Color _seguirBorderColor = Colors.white;
  Color _seguirTextColor = Colors.white;

  bool _isCardVisible = false;
  bool isHovering = false;
  String _myAppLink =
      "https://play.google.com/store/apps/details?id=com.example.myapp";

  Future<void> _requestPermission() async {
    await Permission.storage.request();
  }

  Future<void> _saveImage(Uint8List image) async {
    final time = DateTime.now().toIso8601String().replaceAll(".", "-");
    final newNomeImagem = _nomeImagemSalva.text.trim();
    if (_nomeCaminhoImagemSalva.text.isNotEmpty) {
      final path =
          join(_nomeCaminhoImagemSalva.text, "$newNomeImagem-$time.png");

      final file = File(path);
      await file.writeAsBytes(image);

      print('Imagem salva em: $path');
    } else {
      print('Nenhum caminho selecionado para salvar a imagem.');
    }
  }

  Future<void> _selectedSavePath() async {
    String? selectedDiretory = await FilePicker.platform.getDirectoryPath();

    if (selectedDiretory != null) {
      setState(() {
        _nomeCaminhoImagemSalva.text = selectedDiretory;
      });
    }
  }

  Future<void> _loadMessages() async {
    List<MessageCardClass> mensagens =
        await MessageDao().listarMensagem(widget.telaIdAtual);
    setState(() {
      _messagesFuture = Future.value(mensagens);
      _isFavorite = List.filled(mensagens.length, false);
    });
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      MessageCardClass novaMensagem = MessageCardClass(
        tela_id: widget.telaIdAtual,
        image:
            'https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg', //Não dinamizado
        nome: 'Usuário', //Não dinamizado
        tempoMensagem: 'Agora', //Não dinamizado
        mensagem: _messageController.text,
        views: 0, //Não dinamizado
      );

      try {
        await MessageDao().inserirMensagem(novaMensagem);
        _messageController.clear();
        Future.delayed(Duration(milliseconds: 1500), () async {
          await _loadMessages();
        });

        setState(() {});
      } catch (e) {
        print("Erro ao inserir mensagem: $e");
      }
    }
  }

  Future<void> _shareLink() async {
    String mensagem = await "Confira esse link: $_myAppLink";
    Share.share(mensagem, subject: 'Look what I made!');
  }

  void _messageCardVisibility() {
    setState(() {
      _isCardVisible = !_isCardVisible;
    });
  }

  Future<bool> checkMessageForToxicity(String message) async {
    try {
      final apiKey = "";
      final url = "https://commentanalyzer.googleapis.com/v1/comments:analyze?key:$apiKey";

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type' : 'aplication/json'},
        body: json.encode({
          'comment' : {'text': message},
          'languages': ['pt'],
          'requestedAttributes': {'TOXICITY': {}},
        }),
      );

      if(response.statusCode == 200) {
        var responsyBody = json.decode(response.body);
        var toxicityScore = responsyBody['attributeScores']['TOXICITY']['summatyScore']['value'];

        return toxicityScore > 0.7;
      } else {
        throw Exception("Erro ao verificar a mensagem!");
      }
    }catch(e) {
      print('Erro ao verificar a mensagem $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network("${domainVideoPlayer.url}")
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });

    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Screenshot(
        controller: controller,
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            if (!_controller.value.isInitialized)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ),
              ),
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Reels",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              _buildPopMenuItem(context),
                            ],
                           ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: IconButton(
                            onPressed: () async {
                              final image = await controller.capture();
                              if (image == null) return;
                              await _requestPermission();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Salvar imagem",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: _nomeImagemSalva,
                                          decoration: InputDecoration(
                                              labelText: 'Nome da Imagem'),
                                        ),
                                        TextField(
                                          controller: _nomeCaminhoImagemSalva,
                                          decoration: InputDecoration(
                                              labelText: 'Local (opcional)'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _selectedSavePath();
                                          Navigator.of(context)
                                              .pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Imagem salva com sucesso!'),
                                            ),
                                          );
                                        },
                                        child: Text('Salvar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage(domainVideoPlayer.image),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    ("${domainVideoPlayer.nome}").toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 25,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_seguirColor ==
                                              Colors.transparent) {
                                            _seguirColor = Colors.redAccent;
                                            _seguirBorderColor =
                                                Colors.redAccent;
                                          } else {
                                            _seguirColor = Colors.transparent;
                                            _seguirBorderColor = Colors.white;
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _seguirColor,
                                        side: BorderSide(
                                          color: _seguirBorderColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      child: Text(
                                        "Seguir",
                                        style: TextStyle(
                                          color: _seguirTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "${domainVideoPlayer.descricao}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                              SizedBox(height: 14),
                              SizedBox(
                                height: 25,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.music_note_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        domainVideoPlayer.nomeMusica,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(68, 0, 0, 0),
                                    side: BorderSide(color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              _buildIconButton(
                                icon: _iconColor == Colors.white
                                    ? Icons.favorite_border_outlined
                                    : Icons.favorite,
                                iconColor: _iconColor,
                                size: 35,
                                onPressed: () {
                                  setState(() {
                                    _iconColor = _iconColor == Colors.white
                                        ? Colors.redAccent
                                        : Colors.white;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildIconButton(
                                icon: Icons.comment,
                                iconColor: Colors.white,
                                size: 35,
                                onPressed: _messageCardVisibility,
                              ),
                              const SizedBox(height: 16),
                              _buildIconButton(
                                icon: Icons.send,
                                iconColor: Colors.white,
                                size: 35,
                                onPressed: () async {
                                  await _shareLink();
                                },
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 35,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isCardVisible)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _messageCardVisibility,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.65,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildHandleBar(),
                        Expanded(
                          child: _buildMessageList(),
                        ),
                        _buildMessageTextField(
                          height: 60,
                          onSend: _sendMessage,
                          context: context,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PopupMenuButton<String> _buildPopMenuItem(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.expand_more_sharp,
        color: Colors.white,
        size: 32,
      ),
      offset: Offset(0, 50),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'compartilhar',
            child: Text('Compartilhar'),
          ),
          PopupMenuItem<String>(
            value: 'salvar',
            child: Text('Salvar'),
          ),
          PopupMenuItem<String>(
            value: 'reportar',
            child: Text('Reportar'),
          ),
          PopupMenuItem<String>(
            value: 'voltar',
            child: Text('Voltar'),
          ),
        ];
      },
      onSelected: (String value) {
        switch (value) {
          case 'compartilhar':
            print('Compartilhar selecionado');
            break;
          case 'salvar':
            print('Salvar selecionado');
            break;
          case 'reportar':
            print('Reportar selecionado');
            break;
          case 'voltar':
            print('Voltar selecionado');
            Navigator.pop(context);
            break;
          default:
            print("Nenhuma opção selecionada");
            break;
        }
      },
    );
  }

  Widget _buildMessageTextField({double height = 60, VoidCallback? onSend, required BuildContext context}) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Digite sua mensagem",
                labelStyle: const TextStyle(color: Colors.green),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff27de2d)),
                ),
              ),
            ),
          ),
          if (onSend != null)
            IconButton(
              onPressed: () async {
                final message = _messageController.text;

                bool isToxic = await checkMessageForToxicity(message);

                if (isToxic) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Mensagem Inapropriada'),
                      content: Text('A mensagem contém conteúdo tóxico e não será enviada.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  onSend();
                }
              },
              icon: const Icon(Icons.send, color: Colors.green),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color iconColor,
    required double size,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: size,
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 64,
      height: 6,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildMessageList() {
    return FutureBuilder<List<MessageCardClass>>(
      future: _messagesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar mensagens'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma mensagem encontrada'));
        }

        final messages = snapshot.data!;
        _isFavorite = List.filled(messages.length, false);

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            return _buildMessageItem(message, index);
          },
        );
      },
    );
  }

  List<bool> _isFavorite_two = [];
  List<int> _likesCount = [];

  Widget _buildMessageItem(MessageCardClass message, int index) {
    if (_isFavorite_two.length <= index) {
      _isFavorite_two.add(false);
    }
    if (_likesCount.length <= index) {
      _likesCount.add(message.views);
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(message.image),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        message.nome,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        message.tempoMensagem,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.mensagem,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(180, 0, 0, 0),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (!_isFavorite_two[index]) {
                        _likesCount[index] += 1;
                      } else {
                        _likesCount[index] -= 1;
                      }

                      _isFavorite_two[index] = !_isFavorite_two[index];
                    });
                  },
                  icon: Icon(
                    _isFavorite_two[index] ? Icons.favorite : Icons.favorite_border_outlined,
                    color: _isFavorite_two[index] ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                ),
                Text(
                  "${_likesCount[index]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text("Ver mais"),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    super.dispose();
  }
}
