import 'package:futt/futt/model/TipoAvaliacaoModel.dart';

class AreaAvaliacaoModel {
  int id;
  String nome;
  List<TipoAvaliacaoModel> listaTipoAvaliacao;

  AreaAvaliacaoModel({this.id, this.nome, this.listaTipoAvaliacao});

  factory AreaAvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AreaAvaliacaoModel(
      id: json["id"],
      nome: json["nome"],
    );
  }

}