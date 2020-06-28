import 'dart:convert';

import 'package:futt/futt/model/utils/PosicionamentoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/utils/PosicionamentoServiceFixo.dart';

class PosicionamentoRest extends BaseRest {

  Future<List<PosicionamentoModel>> processaHttpGetList() async {
    PosicionamentoServiceFixo serviceFixo = PosicionamentoServiceFixo();
    var dadosJson = json.decode(serviceFixo.responseLista());
    return _parseListaPosicionamentoModel(dadosJson);
  }

  List<PosicionamentoModel> _parseListaPosicionamentoModel(dadosJson) {
    List<PosicionamentoModel> lista = List();
    for (var registro in dadosJson) {
      PosicionamentoModel resultadoModel = PosicionamentoModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

}