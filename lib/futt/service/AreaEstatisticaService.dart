import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/AreaEstatisticaModel.dart';
import 'package:futt/futt/rest/AreaEstatisticaRest.dart';

class AreaEstatisticaService {

  Future<List<AreaEstatisticaModel>> listaAtivas() {
    String url = "${ConstantesRest.URL_AREA_ESTATISTICA}/ativas";
    AreaEstatisticaRest areaEstatisticaRest = AreaEstatisticaRest();
    return areaEstatisticaRest.processaHttpGetList(url);
  }

}