import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ClassificacaoTorneioModel.dart';
import 'package:futt/futt/rest/ClassificacaoTorneioRest.dart';

class ClassificacaoTorneioService {

  Future<List<ClassificacaoTorneioModel>> listaTodos(bool fixo) {
    String url = "${ConstantesRest.URL_TIPO_TORNEIO}";
    ClassificacaoTorneioRest tipoTorneioRest = ClassificacaoTorneioRest();
    return tipoTorneioRest.processaHttpGetList(url, fixo);
  }

}