import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RedeRest extends BaseRest {

  Future<List<RedeModel>?> processaHttpGetList(String url, String tipo) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaRedeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar redes!!!');

    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<RedeModel>?> processaHttpGetListToken(String url, String tipo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.get(Uri.parse(url),
        headers: <String, String>{
          'Authorization': token,
        });
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);

        var dadosJson = json.decode(source);

        return _parseListaRedeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar redes!!!');

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<RedeModel>> processaHttpPostList(String url, var redeModel) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            jsonDecode(redeModel)
          }
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaRedeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar redes!!!');

    } catch (error) {
      print(error.toString());
      throw Exception('Falha ao listar torneios!!!');
    }
  }

  Future<List<IntegranteModel>> processaHttpGetListIntegrantes(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      List<IntegranteModel> lista = [];
      for (var registro in dadosJson) {
        IntegranteModel integranteModel = IntegranteModel.fromJson(
            registro); //.converteJson
        lista.add(integranteModel);
      }
      return lista;
    } else {
      throw Exception('Failed to load Tipo Rede!!!');
    }
  }

  List<RedeModel> _parseListaRedeModel(dadosJson) {
    List<RedeModel> lista = [];
    for (var registro in dadosJson) {
      RedeModel resultadoModel = RedeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  Future<RedeModel?> processaHttpGetObject(String url) async {
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
        return RedeModel.fromJson(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      throw Exception('Falha ao listar usuários!!!');

    } catch (error) {
      print(error.toString());
    }
  }

}