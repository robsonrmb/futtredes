import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogoRedeRest extends BaseRest {

  Future<List<JogoRedeModel>?> processaHttpGetList(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Falha na busca dos integrantes da rede!!!');
      }
    } on Exception catch (exception) {
      throw Exception('Falha na busca dos integrantes da rede!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<JogoRedeModel>?> processaHttpGetListToken(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.get(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Falha na busca dos jogos!!!');
      }
    } on Exception catch (exception) {
      throw Exception('Falha na busca dos jogos!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<JogoRedeModel>?> processaHttpGetListPlacarAtualizado(String url, int dia, bool atualizouPlacar) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar participantes!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  List<JogoRedeModel> _parseListaJogoRedeModel(dadosJson) {
    List<JogoRedeModel> lista = [];
    for (var registro in dadosJson) {
      JogoRedeModel resultadoModel = JogoRedeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}