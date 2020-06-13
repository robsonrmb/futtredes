import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/rest/IntegranteRest.dart';

class IntegranteService {

  Future<List<IntegranteModel>> listaIntegrantesDaRede(int idRede, bool fixo, int lista) {
    String url = "${ConstantesRest.URL_PARTICIPANTES}/${idRede}";
    IntegranteRest integranteRest = IntegranteRest();
    return integranteRest.processaHttpGetList(url, fixo, lista);
  }

}