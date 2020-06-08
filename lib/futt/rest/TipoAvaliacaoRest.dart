import 'package:futt/futt/model/TipoAvaliacaoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/TipoAvaliacaoServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoAvaliacaoRest extends BaseRest {

  Future<List<TipoAvaliacaoModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        TipoAvaliacaoServiceFixo serviceFixo = TipoAvaliacaoServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<TipoAvaliacaoModel> lista = List();
      for (var registro in dadosJson) {
        TipoAvaliacaoModel tipoAvaliacaoModel = TipoAvaliacaoModel.fromJson(
            registro); //.converteJson
        lista.add(tipoAvaliacaoModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }

  Future<TipoAvaliacaoModel> processaHttpGetObject(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        TipoAvaliacaoServiceFixo serviceFixo = TipoAvaliacaoServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      return TipoAvaliacaoModel.fromJson(dadosJson); //.converteJson

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }

}