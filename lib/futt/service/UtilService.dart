import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/model/utils/PosicionamentoModel.dart';
import 'package:futt/futt/rest/utils/GeneroRest.dart';
import 'package:futt/futt/rest/utils/PaisRest.dart';
import 'package:futt/futt/rest/utils/PosicionamentoRest.dart';

class UtilService {

  Future<List<PaisModel>> listaPaises() async {
    PaisRest paisRest = PaisRest();
    return paisRest.processaHttpGetList();
  }

  Future<List<PosicionamentoModel>> listaPosiconamentos() async {
    PosicionamentoRest posicionamentoRest = PosicionamentoRest();
    return posicionamentoRest.processaHttpGetList();
  }

  Future<List<GeneroModel>> listaGeneros() async {
    GeneroRest generoRest = GeneroRest();
    return generoRest.processaHttpGetList();
  }

}