class IntegranteModel {
  int? _idUsuario;
  String? _email;
  String? _nome;
  String? _nomeFoto;
  String? _pais;
  String? _estado;
  String? _cidade;
  String? _local;
  String? _apelido;
  int? _idRede;
  String? _user;
  String? _integrante;

  IntegranteModel(this._apelido,this._local,this._idUsuario, this._email, this._nome, this._nomeFoto, this._pais, this._estado, this._cidade, this._idRede,this._user,this._integrante);
  IntegranteModel.Novo(this._idRede, this._integrante);
  IntegranteModel.Remove(this._idRede, this._idUsuario);

  factory IntegranteModel.fromJson(Map<String, dynamic> json) {
    return IntegranteModel(
      json['apelido'],
      json['local'],
      json["idUsuario"],
      json["email"],
      json["nome"],
      json["nomeFoto"],
      json["pais"],
      json["estado"],
      json["cidade"],
      json["idRede"],
      json["user"],
      json["integrante"]
    );
  }

  toJson() {
    return {
      'apelido': _apelido,
      'local': _local,
      'idUsuario': _idUsuario,
      'email': _email,
      'nome': _nome,
      'nomeFoto': _nomeFoto,
      'pais': _pais,
      'estado': _estado,
      'cidade': _cidade,
      'idRede': _idRede,
      'user': _user,
      'integrante': _integrante
    };
  }

  String? get apelido => _apelido;

  set apelido(String? value) {
    _apelido = value;
  }


  String? get local => _local;

  set local(String? value) {
    _local = value;
  }


  String? get estado => _estado;

  set estado(String? value) {
    _estado = value;
  }

  String? get pais => _pais;

  set pais(String? value) {
    _pais = value;
  }

  String? get nomeFoto => _nomeFoto;

  set nomeFoto(String? value) {
    _nomeFoto = value;
  }

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  int? get idUsuario => _idUsuario;

  set idUsuario(int? value) {
    _idUsuario = value;
  }

  int? get idRede => _idRede;

  set idRede(int? value) {
    _idRede = value;
  }

  String? get cidade => _cidade;

  set cidade(String? value) {
    _cidade = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get user => _user;

  set user(String? value) {
    _user = value;
  }

}