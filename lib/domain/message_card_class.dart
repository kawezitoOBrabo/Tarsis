class MessageCardClass {
  int? id;
  late int tela_id;
  late String image;
  late String nome;
  late String tempoMensagem;
  late String mensagem;
  late int views;

  MessageCardClass({
    this.id,
    required this.tela_id,
    required this.image,
    required this.nome,
    required this.tempoMensagem,
    required this.mensagem,
    required this.views,
  });

  MessageCardClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tela_id = json['tela_id'];
    image = json['imagem'];
    nome = json['nomePerfil'];
    tempoMensagem = json['tempoMensagem'];
    mensagem = json['mensagem'];
    views = json['views'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tela_id': tela_id,
      'imagem': image,
      'nomePerfil': nome,
      'tempoMensagem': tempoMensagem,
      'mensagem': mensagem,
      'views': views,
    };
  }
}
