class AvaliacaoResultModel {
  int id;
  int idUsuario;
  int idAvaliado;
  DateTime data;
  String status;

  List<String> respostas;

  String nomeUsuario;
  String nomeAvaliado;

  AvaliacaoResultModel({this.id, this.idUsuario, this.idAvaliado, this.data,
      this.status, this.respostas, this.nomeUsuario, this.nomeAvaliado});

}