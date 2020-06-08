import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/TipoTorneioModel.dart';
import 'package:futt/futt/rest/TipoTorneioRest.dart';

class TipoTorneioService {

  Future<List<TipoTorneioModel>> listaTodos(bool fixo) {
    String url = "${ConstantesRest.URL_TIPO_TORNEIO}";
    TipoTorneioRest tipoTorneioRest = TipoTorneioRest();
    return tipoTorneioRest.processaHttpGetList(url, fixo);
  }

}