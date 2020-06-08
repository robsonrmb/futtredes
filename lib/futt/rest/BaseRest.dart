import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseRest {

  processaHttpPost(String url, var model) async {
    http.Response response;
    if (model != null) {
      response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonDecode(model)
      );
    }else{
      response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

  processaHttpPut(String url, var model) async {
    http.Response response;
    if (model != null) {
      response = await http.put(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonDecode(model)
      );
    }else{
      response = await http.put(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

  processaHttpDelete(String url) async {
    http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load!!!');
    }
  }

}