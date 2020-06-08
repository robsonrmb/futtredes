class LoginModel {
  String email;
  String senha;

  LoginModel({this.email, this.senha});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json["email"],
      senha: json["senha"],
    );
  }

  toJson() {
    return {
      'email': email,
      'senha': senha,
    };
  }
}