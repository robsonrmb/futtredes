import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/rest/LoginRest.dart';

class LoginService {

  logar(var loginModel) {
    String url = ConstantesRest.URL_LOGIN;
    LoginRest loginRest = LoginRest();
    loginRest.processaHttpPost(url, loginModel);
  }

}