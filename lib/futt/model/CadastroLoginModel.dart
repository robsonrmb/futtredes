class CadastroLoginModel {
  String? email;
  String? user;
  String? senha;
  String? nome;
  String? pais;
  String? estado;
  String? sexo;

  CadastroLoginModel({this.email, this.user,this.senha, this.nome, this.pais, this.estado,
      this.sexo});

  factory CadastroLoginModel.fromJson(Map<String, dynamic> json) {
    return CadastroLoginModel(
      nome: json["nome"],
      user: json['user'],
      email: json["email"],
      senha: json["senha"],
      estado: json["estado"],
      pais: json["pais"],
      sexo: json["sexo"],
    );
  }

  toJson() {
    return {
      'user':user,
      'nome': nome,
      'email': email,
      'senha': senha,
      'estado': estado,
      'pais': pais,
      'sexo': sexo,
    };
  }

}