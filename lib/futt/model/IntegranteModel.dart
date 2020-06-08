class IntegranteModel {
  int idUsuario;
  String nome;
  String nomeFoto;
  String pais;
  String estado;

  IntegranteModel({this.idUsuario, this.nome, this.nomeFoto, this.pais, this.estado});

  factory IntegranteModel.fromJson(Map<String, dynamic> json) {
    return IntegranteModel(
      idUsuario: json["idUsuario"],
      nome: json["nome"],
      nomeFoto: json["nomeFoto"],
      pais: json["pais"],
      estado: json["estado"],
    );
  }
}