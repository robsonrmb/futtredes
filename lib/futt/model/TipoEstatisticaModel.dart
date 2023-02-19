import 'package:futt/futt/model/TipoRespostaEstatisticaModel.dart';

class TipoEstatisticaModel {
  int? id;
  String? nome;
  String? descricao;
  List<TipoRespostaEstatisticaModel>? listaTipoRespostaEstatistica;

  TipoEstatisticaModel({this.id, this.nome, this.descricao, this.listaTipoRespostaEstatistica});

  factory TipoEstatisticaModel.fromJson(Map<String, dynamic> json) {
    return TipoEstatisticaModel(
      id: json["id"],
      nome: json["nome"],
      descricao: json["descricao"],
    );
  }
}