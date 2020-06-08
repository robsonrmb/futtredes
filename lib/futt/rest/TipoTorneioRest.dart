import 'package:futt/futt/model/TipoTorneioModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/TipoTorneioServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoTorneioRest extends BaseRest {

  Future<List<TipoTorneioModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaTipoTorneioModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        TipoTorneioServiceFixo serviceFixo = TipoTorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaTipoTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<TipoTorneioModel> _parseListaTipoTorneioModel(dadosJson) {
    List<TipoTorneioModel> lista = List();
    for (var registro in dadosJson) {
      TipoTorneioModel resultadoModel = TipoTorneioModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}