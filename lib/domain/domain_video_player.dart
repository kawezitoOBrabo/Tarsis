import 'package:flutter/material.dart';
import 'package:Tarsis/domain/message_card_class.dart';

class DomainVideoPlayer {
  late String url;
  late String image;
  late String nome;
  late String descricao;
  late String nomeMusica;
  late List<MessageCardClass>? messageCard;

  DomainVideoPlayer({
    required this.url,
    required this.image,
    required this.nome,
    required this.descricao,
    required this.nomeMusica,
    this.messageCard,
  });

  DomainVideoPlayer.fromJson(Map<String, dynamic> json) {
    url = json['video'];
    image = json['perfilImagem'];
    nome = json['nomePerfil'];
    descricao = json['descricao'];
    nomeMusica = json['musica'];
    messageCard = [];
  }
}
