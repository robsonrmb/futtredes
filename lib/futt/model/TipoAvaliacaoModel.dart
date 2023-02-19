import 'package:futt/futt/model/TipoRespostaAvaliacaoModel.dart';

class TipoAvaliacaoModel {
  int? id;
  String? nome;
  String? descricao;
  List<TipoRespostaAvaliacaoModel>? listaTipoRespostaAvaliacao;

  TipoAvaliacaoModel({this.id, this.nome, this.descricao, this.listaTipoRespostaAvaliacao});

  factory TipoAvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return TipoAvaliacaoModel(
      id: json["id"],
      nome: json["nome"],
      descricao: json["descricao"],
    );
  }
}