import 'package:flutter/material.dart';
import 'package:Tarsis/domain/message_card_class.dart';

class DomainVideoPlayer {
  late String url; // URL do vídeo
  late String image; // Imagem do perfil
  late String nome; // Nome da conta
  late String descricao; // Descrição do vídeo
  late String nomeMusica; // Nome da música adicionada
  late List<MessageCardClass>? messageCard; // Lista dinâmica de mensagens

  DomainVideoPlayer({
    required this.url,
    required this.image,
    required this.nome,
    required this.descricao,
    required this.nomeMusica,
    this.messageCard,
  });

  // Método para criar uma instância a partir de um JSON
  DomainVideoPlayer.fromJson(Map<String, dynamic> json) {
    url = json['video']; // Mapeia o campo 'video' da tabela 'PAGINA'
    image = json['perfilImagem']; // Mapeia o campo 'perfilImagem'
    nome = json['nomePerfil']; // Mapeia o campo 'nomePerfil'
    descricao = json['descricao']; // Mapeia o campo 'descricao'
    nomeMusica = json['musica']; // Mapeia o campo 'musica'
    messageCard = []; // Inicializa como uma lista vazia (será preenchida separadamente)
  }
}
