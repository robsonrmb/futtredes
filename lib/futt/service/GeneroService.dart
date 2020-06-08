import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/rest/utils/GeneroRest.dart';

class GeneroService {

  Future<List<GeneroModel>> listaGeneros() async {
    GeneroRest generoRest = GeneroRest();
    return generoRest.processaHttpGetList();
  }

}