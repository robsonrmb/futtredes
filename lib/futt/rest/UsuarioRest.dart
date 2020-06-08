import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/UsuarioServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioRest extends BaseRest {

  Future<List<UsuarioModel>> processaHttpGetList(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
        dadosJson = serviceFixo.responseLista();
      }
      List<UsuarioModel> lista = List();
      for (var registro in dadosJson) {
        UsuarioModel usuarioModel = UsuarioModel.fromJson(
            registro); //.converteJson
        lista.add(usuarioModel);
      }
      return lista;

    } else {
      throw Exception('Failed to load Tipo Torneio!!!');
    }
  }

  Future<UsuarioModel> processaHttpGetObject(String url, bool fixo) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || (fixo != null && fixo == true)) {
      var dadosJson = json.decode(response.body);
      if (fixo != null && fixo == true) {
        UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
        dadosJson = serviceFixo.responseObjeto();
      }
      return UsuarioModel.fromJson(dadosJson); //.converteJson

    }else{
      throw Exception('Failed to load Tipo Usuario!!!');
    }
  }

  Future<List<UsuarioModel>> processaHttpPostReturn(String url, var usuarioModel, bool fixo) async {
    http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          jsonDecode(usuarioModel)
        }
    );
    var dadosJson = json.decode(response.body);

    if (fixo != null && fixo == true) {
      UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
      dadosJson = serviceFixo.responseLista();
    }
    List<UsuarioModel> lista = List();
    for (var registro in dadosJson) {
      UsuarioModel usuarioModel = UsuarioModel.fromJson(registro); //.converteJson
      lista.add(usuarioModel);
    }
    return lista;
  }
}