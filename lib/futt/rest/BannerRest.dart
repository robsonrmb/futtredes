import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/BannerModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BannerRest extends BaseRest {

  Future<BannerModel> processaHttpGetObject(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        BannerModel bannerModel = BannerModel.fromJson(dadosJson);
        return bannerModel;

      } else {
        return BannerModel(false, false, false, false, false, false, false, false, false,"","","","","","","","","");
      }
    } on Exception catch (exception) {
      return BannerModel(false, false, false, false, false, false, false, false, false,"","","","","","","","","");

    } catch (error) {
      return BannerModel(false, false, false, false, false, false, false, false, false,"","","","","","","","","");
    }
  }

  List<BannerModel> _parseListaBannerModel(dadosJson, view) {
    if (view) {
      List<BannerModel> lista = List();
      for (var registro in dadosJson) {
        BannerModel resultadoModel = BannerModel.fromJson(
            registro); //.converteJson
        lista.add(resultadoModel);
      }
      return lista;
    }else{

    }
  }
}