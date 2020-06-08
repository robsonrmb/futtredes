import 'package:futt/futt/model/ClassificacaoTorneioModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/ClassificacaoTorneioServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClassificacaoTorneioRest extends BaseRest {

  Future<List<ClassificacaoTorneioModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaClassificacaoTorneioModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        ClassificacaoTorneioServiceFixo serviceFixo = ClassificacaoTorneioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaClassificacaoTorneioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<ClassificacaoTorneioModel> _parseListaClassificacaoTorneioModel(dadosJson) {
    List<ClassificacaoTorneioModel> lista = List();
    for (var registro in dadosJson) {
      ClassificacaoTorneioModel resultadoModel = ClassificacaoTorneioModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}