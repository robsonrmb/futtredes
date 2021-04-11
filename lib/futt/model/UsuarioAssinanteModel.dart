class UsuarioAssinanteModel {
  int idAssinatura;
  bool status;
  String validade;
  String produto;
  String email;

  UsuarioAssinanteModel(
      {this.idAssinatura,
      this.status,
      this.validade,
      this.produto,
      this.email});

  factory UsuarioAssinanteModel.fromJson(Map<String, dynamic> json) {
    return UsuarioAssinanteModel(
        idAssinatura: json["idAssinatura"],
        status: json["status"],
        validade: json['validade'],
        produto: json['produto'],
        email: json['email']);
  }
}
