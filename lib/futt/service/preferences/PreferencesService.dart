import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {

  void salva(String nome, String valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(nome, valor);
  }

  Future<String> recupera(String nome) async {
    String retorno = "";
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(nome) != null) {
      retorno = prefs.getString(nome);
    }
    return retorno;
  }

  void remove(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nome");
  }

}