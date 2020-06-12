class LoginModel {
  String _email;
  String _senha;

  LoginModel(this._email, this._senha);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      json["email"],
      json["senha"],
    );
  }

  toJson() {
    return {
      'email': _email,
      'senha': _senha,
    };
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

}