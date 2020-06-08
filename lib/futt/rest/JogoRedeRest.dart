import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/JogoRedeServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogoRedeRest extends BaseRest {

  Future<List<JogoRedeModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        JogoRedeServiceFixo serviceFixo = JogoRedeServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<JogoRedeModel> lista = List();
      for (var registro in dadosJson) {
        JogoRedeModel jogoRedeModel = JogoRedeModel.fromJson(
            registro); //.converteJson
        lista.add(jogoRedeModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }
}