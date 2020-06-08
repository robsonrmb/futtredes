class TipoRespostaEstatisticaModel {
  int id;
  String nome;

  TipoRespostaEstatisticaModel({this.id, this.nome});

  factory TipoRespostaEstatisticaModel.fromJson(Map<String, dynamic> json) {
    return TipoRespostaEstatisticaModel(
      id: json["id"],
      nome: json["nome"],
    );
  }
}