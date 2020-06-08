import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/RedeServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RedeRest extends BaseRest {

  Future<List<RedeModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        RedeServiceFixo serviceFixo = RedeServiceFixo();
        dadosJson = serviceFixo.responseRedeLista();
      }
      List<RedeModel> lista = List();
      for (var registro in dadosJson) {
        RedeModel redeModel = RedeModel.fromJson(
            registro); //.converteJson
        lista.add(redeModel);
      }
      return lista;

    }else{
      throw Exception('Failed to load Tipo Usuario!!!');
    }
  }

  Future<List<IntegranteModel>> processaHttpGetListIntegrantes(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        RedeServiceFixo serviceFixo = RedeServiceFixo();
        dadosJson = serviceFixo.responseIntegrantesLista();
      }
      List<IntegranteModel> lista = List();
      for (var registro in dadosJson) {
        IntegranteModel integranteModel = IntegranteModel.fromJson(
            registro); //.converteJson
        lista.add(integranteModel);
      }
      return lista;

    }else{
      throw Exception('Failed to load Tipo Usuario!!!');
    }
  }

  Future<List<RedeModel>> processaHttpPostReturn(String url, var redeModel, bool fixo) async {
    http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          jsonDecode(redeModel)
        }
    );
    var dadosJson = json.decode(response.body);

    if (fixo != null && fixo == true) {
      RedeServiceFixo serviceFixo = RedeServiceFixo();
      dadosJson = serviceFixo.responseRedeLista();
    }
    List<RedeModel> lista = List();
    for (var registro in dadosJson) {
      RedeModel usuarioModel = RedeModel.fromJson(registro); //.converteJson
      lista.add(usuarioModel);
    }
    return lista;
  }
}