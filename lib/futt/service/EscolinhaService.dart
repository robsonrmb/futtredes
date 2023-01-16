import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EscolinhaModel.dart';
import 'package:futt/futt/rest/EscolinhaRest.dart';

class EscolinhaService {

  Future<List<EscolinhaModel>> listaEscolinhas(String pais, String cidade) {
    String url = "${ConstantesRest.URL_ESCOLINHA}/filtro";
    EscolinhaRest escolinhaRest = EscolinhaRest();
    bool _filtro = true;
    if (pais == "") {
      _filtro = false;
    }
    return escolinhaRest.processaHttpGetList(url, _filtro);
  }

}