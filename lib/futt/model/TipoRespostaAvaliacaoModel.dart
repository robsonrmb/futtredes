class TipoRespostaAvaliacaoModel {
  int id;
  String nome;

  TipoRespostaAvaliacaoModel({this.id, this.nome});

  factory TipoRespostaAvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return TipoRespostaAvaliacaoModel(
      id: json["id"],
      nome: json["nome"],
    );
  }
}