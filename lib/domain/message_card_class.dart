import 'package:flutter/material.dart';

class MessageCardClass {
  late int id;
  late int tela_id;
  late String image;
  late String nome;
  late String tempoMensagem;
  late String mensagem;
  late Icon icon;
  late int views;

  MessageCardClass({
    required this.image,
    required this.nome,
    required this.tempoMensagem,
    required this.mensagem,
    required this.icon,
    required this.views,
  });

  MessageCardClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tela_id = json['tela_id'];
    image = json['imagem'];
    nome = json['nome_perfil'];
    tempoMensagem = json['tempoMensagem'];
    mensagem = json['mensagem'];
    views = json['views'];
  }
}
