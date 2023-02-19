import 'package:futt/futt/model/TipoEstatisticaModel.dart';

class AreaEstatisticaModel {
  int? id;
  String? nome;
  List<TipoEstatisticaModel>? listaTipoEstatistica;

  AreaEstatisticaModel({this.id, this.nome, this.listaTipoEstatistica});

  factory AreaEstatisticaModel.fromJson(Map<String, dynamic> json) {
    return AreaEstatisticaModel(
      id: json["id"],
      nome: json["nome"],
    );
  }

}