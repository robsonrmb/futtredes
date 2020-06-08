class EstatisticaModel {
  int id;
  int idUsuario;
  int ano;
  String nomeTipoAvaliacao;

  EstatisticaModel({this.id, this.idUsuario, this.ano, this.nomeTipoAvaliacao});

  factory EstatisticaModel.fromJson(Map<String, dynamic> json) {
    return EstatisticaModel(
      id: json["id"],
      idUsuario: json["idUsuario"],
      ano: json["ano"],
      nomeTipoAvaliacao: json["nomeTipoAvaliacao"],
    );
  }

}