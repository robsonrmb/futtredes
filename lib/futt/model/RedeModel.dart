class RedeModel {
  int id;
  String nome;
  int status;
  String pais;
  String estado;
  String cidade;
  String local;
  String info;
  DateTime disponibilidade;
  int qtdIntegrantes;
  int responsavelRede;
  int responsavelJogos1;
  int responsavelJogos2;
  int responsavelJogos3;

  RedeModel({this.id, this.nome, this.status, this.pais, this.estado,
      this.cidade, this.local, this.info, this.disponibilidade,
      this.qtdIntegrantes, this.responsavelRede, this.responsavelJogos1,
      this.responsavelJogos2, this.responsavelJogos3});

  factory RedeModel.fromJson(Map<String, dynamic> json) {
    return RedeModel(
      id: json["id"],
      nome: json["nome"],
      status: json["status"],
      pais: json["pais"],
      estado: json["estado"],
      cidade: json["cidade"],
      local: json["local"],
      info: json["info"],
      disponibilidade: json["disponibilidade"],
      qtdIntegrantes: json["qtdIntegrantes"],
      responsavelRede: json["responsavelRede"],
      responsavelJogos1: json["responsavelJogos1"],
      responsavelJogos2: json["responsavelJogos2"],
      responsavelJogos3: json["responsavelJogos3"],
    );
  }
}