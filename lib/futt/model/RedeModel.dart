class RedeModel {
  int _id;
  String _nome;
  String _nomeFoto;
  int _status;
  String _pais;
  String _estado;
  String _cidade;
  String _local;
  String _info;
  String _disponibilidade;
  int _qtdIntegrantes;
  int _responsavelRede;
  int _responsavelJogos1;
  int _responsavelJogos2;
  int _responsavelJogos3;
  String _nomeResponsavelRede;
  String _nomeResponsavelJogos1;
  String _nomeResponsavelJogos2;
  String _nomeResponsavelJogos3;
  String _emailResponsavelRede;
  String _emailResponsavelJogos1;
  String _emailResponsavelJogos2;
  String _emailResponsavelJogos3;
  String _subresponsavel1;
  String _subresponsavel2;
  String _subresponsavel3;

  RedeModel(
      this._id,
      this._nome,
      this._nomeFoto,
      this._status,
      this._pais,
      this._estado,
      this._cidade,
      this._local,
      this._info,
      this._disponibilidade,
      this._qtdIntegrantes,
      this._responsavelRede,
      this._responsavelJogos1,
      this._responsavelJogos2,
      this._responsavelJogos3,
      this._nomeResponsavelRede,
      this._nomeResponsavelJogos1,
      this._nomeResponsavelJogos2,
      this._nomeResponsavelJogos3,
      this._emailResponsavelRede,
      this._emailResponsavelJogos1,
      this._emailResponsavelJogos2,
      this._emailResponsavelJogos3,
      this._subresponsavel1,
      this._subresponsavel2,
      this._subresponsavel3);

  RedeModel.Novo(this._nome, this._pais, this._estado,this._cidade, this._local,
      this._qtdIntegrantes, this._info);

  RedeModel.Edita(this._id, this._nome, this._pais,this._estado, this._cidade, this._local,
      this._qtdIntegrantes, this._info);

  RedeModel.Responsaveis(
      this._id,
      this._emailResponsavelRede,
      this._subresponsavel1,
      this._subresponsavel2,
      this._subresponsavel3);

  factory RedeModel.fromJson(Map<String, dynamic> json) {
    return RedeModel(
      json["id"],
      json["nome"],
      json["nomeFoto"],
      json["status"],
      json["pais"],
      json["estado"],
      json["cidade"],
      json["local"],
      json["info"],
      json["disponibilidade"],
      json["qtdIntegrantes"],
      json["responsavelRede"],
      json["responsavelJogos1"],
      json["responsavelJogos2"],
      json["responsavelJogos3"],
      json["nomeResponsavelRede"],
      json["nomeResponsavelJogos1"],
      json["nomeResponsavelJogos2"],
      json["nomeResponsavelJogos3"],
      json["emailResponsavelRede"],
      json["emailResponsavelJogos1"],
      json["emailResponsavelJogos2"],
      json["emailResponsavelJogos3"],
      json["subresponsavel1"],
      json["subresponsavel2"],
      json["subresponsavel3"],

    );
  }

  toJson() {
    return {
      'id': _id,
      'nome': _nome,
      'pais': _pais,
      'cidade': _cidade,
      'local': _local,
      'info': _info,
      'qtdIntegrantes': _qtdIntegrantes,
      'emailResponsavelRede': _emailResponsavelRede,
      'emailResponsavelJogos1': _emailResponsavelJogos1,
      'emailResponsavelJogos2': _emailResponsavelJogos2,
      'emailResponsavelJogos3': _emailResponsavelJogos3,

      'subresponsavel1': _subresponsavel1,
      'subresponsavel2': _subresponsavel2,
      'subresponsavel3': _subresponsavel3,

    };
  }

  int get responsavelJogos3 => _responsavelJogos3;

  set responsavelJogos3(int value) {
    _responsavelJogos3 = value;
  }

  int get responsavelJogos2 => _responsavelJogos2;

  set responsavelJogos2(int value) {
    _responsavelJogos2 = value;
  }

  int get responsavelJogos1 => _responsavelJogos1;

  set responsavelJogos1(int value) {
    _responsavelJogos1 = value;
  }

  int get responsavelRede => _responsavelRede;

  set responsavelRede(int value) {
    _responsavelRede = value;
  }

  int get qtdIntegrantes => _qtdIntegrantes;

  set qtdIntegrantes(int value) {
    _qtdIntegrantes = value;
  }

  String get disponibilidade => _disponibilidade;

  set disponibilidade(String value) {
    _disponibilidade = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }

  String get local => _local;

  set local(String value) {
    _local = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get nomeFoto => _nomeFoto;

  set nomeFoto(String value) {
    _nomeFoto = value;
  }

  String get emailResponsavelJogos3 => _emailResponsavelJogos3;

  set emailResponsavelJogos3(String value) {
    _emailResponsavelJogos3 = value;
  }

  String get emailResponsavelJogos2 => _emailResponsavelJogos2;

  set emailResponsavelJogos2(String value) {
    _emailResponsavelJogos2 = value;
  }

  String get emailResponsavelJogos1 => _emailResponsavelJogos1;

  set emailResponsavelJogos1(String value) {
    _emailResponsavelJogos1 = value;
  }

  String get emailResponsavelRede => _emailResponsavelRede;

  set emailResponsavelRede(String value) {
    _emailResponsavelRede = value;
  }

  String get nomeResponsavelJogos3 => _nomeResponsavelJogos3;

  set nomeResponsavelJogos3(String value) {
    _nomeResponsavelJogos3 = value;
  }

  String get nomeResponsavelJogos2 => _nomeResponsavelJogos2;

  set nomeResponsavelJogos2(String value) {
    _nomeResponsavelJogos2 = value;
  }

  String get nomeResponsavelJogos1 => _nomeResponsavelJogos1;

  set nomeResponsavelJogos1(String value) {
    _nomeResponsavelJogos1 = value;
  }

  String get nomeResponsavelRede => _nomeResponsavelRede;

  set nomeResponsavelRede(String value) {
    _nomeResponsavelRede = value;
  }

  String getStatusFormatado() {
    if (status == 10) {
      return "NOVA";
    } else if (status == 20) {
      return "ABERTA";
    } else if (status == 30) {
      return "FECHADA";
    } else if (status == 40) {
      return "DESATIVADA";
    }
  }
}
