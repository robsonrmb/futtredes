import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/AreaAvaliacaoModel.dart';
import 'package:futt/futt/rest/AreaAvaliacaoRest.dart';

class AreaAvaliacaoService {

  Future<List<AreaAvaliacaoModel>> listaAtivas({bool fixo}) {
    String url = "${ConstantesRest.URL_AREA_AVALIACAO}/ativas";
    AreaAvaliacaoRest areaAvaliacaoRest = AreaAvaliacaoRest();
    return areaAvaliacaoRest.processaHttpGetList(url, fixo);
  }

}