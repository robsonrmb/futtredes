import 'package:futt/futt/model/PatrocinadorModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/PatrocinadorServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatrocinadorRest extends BaseRest {

  Future<List<PatrocinadorModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        PatrocinadorServiceFixo serviceFixo = PatrocinadorServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<PatrocinadorModel> lista = List();
      for (var registro in dadosJson) {
        PatrocinadorModel patrocinadorModel = PatrocinadorModel.fromJson(
            registro); //.converteJson
        lista.add(patrocinadorModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }
}