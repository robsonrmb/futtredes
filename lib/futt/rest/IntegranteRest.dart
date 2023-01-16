import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntegranteRest extends BaseRest {

  Future<List<IntegranteModel>> processaHttpGetList(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaIntegranteModel(dadosJson);

      } else {
        throw Exception('Falha na busca dos integrantes da rede!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha na busca dos integrantes da rede!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  List<IntegranteModel> _parseListaIntegranteModel(dadosJson) {
    List<IntegranteModel> lista = List();
    for (var registro in dadosJson) {
      IntegranteModel resultadoModel = IntegranteModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}