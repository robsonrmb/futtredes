class UsuarioModel {
  int? _id;
  String? _nome;
  String? _email;
  String? _senha;
  String? _novaSenha;
  String? _apelido;
  String? _dataNascimento;
  String? _ondeJoga;
  String? _tipo;
  String? _nivel;
  String? _cidade;
  String? _estado;
  String? _pais;
  String? _status;
  String? _sexo;
  String? _posicao;
  String? _professor;
  String? _nomeFoto;
  int? _qtdRedePromocional;
  String? _user;
  int? _numMaximoRedePromocional;

  UsuarioModel.Novo(this._id);
  UsuarioModel.Atualiza(this._nome, this._apelido, this._dataNascimento, this._sexo, this._posicao,
      this._pais, this._cidade, this._ondeJoga);
  UsuarioModel.AtualizaSenha(this._email, this._senha, this._novaSenha);
  UsuarioModel(this._id, this._nome, this._email, this._senha, this._apelido,
      this._dataNascimento, this._ondeJoga, this._tipo, this._nivel, this._cidade,
      this._estado, this._pais, this._status, this._sexo, this._posicao, this._professor,
      this._nomeFoto,this._qtdRedePromocional,this._user, this._numMaximoRedePromocional);

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    // String data = json['dataNascimento'];
    // DateTime dateTime = new DateTime.now();
    // if (data != null && data != "" && data.length == 8) {
    //   dateTime = new DateTime(
    //       int.parse(data.substring(0, 4)),
    //       int.parse(data.substring(5, 7)),
    //       int.parse(data.substring(8)));
    // }

    return UsuarioModel(
        json["id"],
        json["nome"],
        json["email"],
        json["senha"],
        json["apelido"],
        json["dataNascimento"],
        json["ondeJoga"],
        json["tipo"],
        json["nivel"],
        json["cidade"],
        json["estado"],
        json["pais"],
        json["status"],
        json["sexo"],
        json["posicao"],
        json["professor"],
        json["nomeFoto"],
        json['qtdRedePromocional'],
        json['user'],
        json['numMaximoRedePromocional']
    );
  }

  toJson() {
    return {
      'id': _id,
      'nome': _nome,
      'email': _email,
      'senha': _senha,
      'apelido': _apelido,
      'dataNascimento': _dataNascimento,
      'ondeJoga': _ondeJoga,
      'tipo': _tipo,
      'nivel': _nivel,
      'pais': _pais,
      'estado': _estado,
      'cidade': _cidade,
      'sexo': _sexo,
      'posicao': _posicao,
      'nomeFoto': _nomeFoto,
      'novaSenha': _novaSenha,
      'qtdRedePromocional':_qtdRedePromocional,
      'user': _user,
      'numMaximoRedePromocional':_numMaximoRedePromocional,
    };
  }
  String _getDateJson() {
    if (_dataNascimento != null && _dataNascimento != "") {
      return _dataNascimento.toString().substring(0,10);
    }
    return "";
  }

  String? get nomeFoto => _nomeFoto;

  set nomeFoto(String? value) {
    _nomeFoto = value;
  }

  String? get professor => _professor;

  set professor(String? value) {
    _professor = value;
  }

  String? get sexo => _sexo;

  set sexo(String? value) {
    _sexo = value;
  }

  String? get status => _status;

  set status(String? value) {
    _status = value;
  }

  String? get pais => _pais;

  set pais(String? value) {
    _pais = value;
  }

  String? get estado => _estado;

  set estado(String? value) {
    _estado = value;
  }

  String? get cidade => _cidade;

  set cidade(String? value) {
    _cidade = value;
  }

  String? get nivel => _nivel;

  set nivel(String? value) {
    _nivel = value;
  }

  String? get tipo => _tipo;

  set tipo(String? value) {
    _tipo = value;
  }

  String? get ondeJoga => _ondeJoga;

  set ondeJoga(String? value) {
    _ondeJoga = value;
  }

  String? get dataNascimento => _dataNascimento;

  set dataNascimento(String? value) {
    _dataNascimento = value;
  }

  String? get apelido => _apelido;

  set apelido(String? value) {
    _apelido = value;
  }

  String? get senha => _senha;

  set senha(String? value) {
    _senha = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String? get posicao => _posicao;

  set posicao(String? value) {
    _posicao = value;
  }

  String? get user => _user;

  set user(String? value) {
    _user = value;
  }

  int? get numMaximoRedePromocional => _numMaximoRedePromocional;

  set numMaximoRedePromocional(int? value) {
    _numMaximoRedePromocional = value;
  }

  int? get qtdRedePromocional => _qtdRedePromocional;

  set qtdRedePromocional(int? value) {
    _qtdRedePromocional = value;
  }

}
