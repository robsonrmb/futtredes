import 'package:futt/futt/model/AreaAvaliacaoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/AreaAvaliacaoServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AreaAvaliacaoRest extends BaseRest {

  Future<List<AreaAvaliacaoModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        AreaAvaliacaoServiceFixo serviceFixo = AreaAvaliacaoServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<AreaAvaliacaoModel> lista = List();
      for (var registro in dadosJson) {
        AreaAvaliacaoModel areaAvaliacaoModel = AreaAvaliacaoModel.fromJson(
            registro); //.converteJson
        lista.add(areaAvaliacaoModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }

}