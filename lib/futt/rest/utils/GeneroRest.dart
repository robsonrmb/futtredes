import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/utils/GeneroServiceFixo.dart';
import 'dart:convert';

class GeneroRest extends BaseRest {

  Future<List<GeneroModel>> processaHttpGetList() async {
    GeneroServiceFixo serviceFixo = GeneroServiceFixo();
    var dadosJson = json.decode(serviceFixo.responseLista());
    return _parseListaGeneroModel(dadosJson);
  }

  List<GeneroModel> _parseListaGeneroModel(dadosJson) {
    List<GeneroModel> lista = [];
    for (var registro in dadosJson) {
      GeneroModel resultadoModel = GeneroModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

}