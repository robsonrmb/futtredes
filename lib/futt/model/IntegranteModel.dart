class IntegranteModel {
  int _idUsuario;
  String _email;
  String _nome;
  String _nomeFoto;
  String _pais;
  String _estado;
  String _cidade;
  int _idRede;

  IntegranteModel(this._idUsuario, this._email, this._nome, this._nomeFoto, this._pais, this._estado, this._cidade, this._idRede);
  IntegranteModel.Novo(this._idRede, this._email);
  IntegranteModel.Remove(this._idRede, this._idUsuario);

  factory IntegranteModel.fromJson(Map<String, dynamic> json) {
    return IntegranteModel(
      json["idUsuario"],
      json["email"],
      json["nome"],
      json["nomeFoto"],
      json["pais"],
      json["estado"],
      json["cidade"],
      json["idRede"],
    );
  }

  toJson() {
    return {
      'idUsuario': _idUsuario,
      'email': _email,
      'nome': _nome,
      'nomeFoto': _nomeFoto,
      'pais': _pais,
      'estado': _estado,
      'cidade': _cidade,
      'idRede': _idRede,
    };
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get nomeFoto => _nomeFoto;

  set nomeFoto(String value) {
    _nomeFoto = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int value) {
    _idUsuario = value;
  }

  int get idRede => _idRede;

  set idRede(int value) {
    _idRede = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}