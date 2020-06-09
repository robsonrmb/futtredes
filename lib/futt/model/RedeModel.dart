class RedeModel {
  int _id;
  String _nome;
  int _status;
  String _pais;
  String _estado;
  String _cidade;
  String _local;
  String _info;
  DateTime _disponibilidade;
  int _qtdIntegrantes;
  int _responsavelRede;
  int _responsavelJogos1;
  int _responsavelJogos2;
  int _responsavelJogos3;

  RedeModel(this._id, this._nome, this._status, this._pais, this._estado,
      this._cidade, this._local, this._info, this._disponibilidade,
      this._qtdIntegrantes, this._responsavelRede, this._responsavelJogos1,
      this._responsavelJogos2, this._responsavelJogos3);

  factory RedeModel.fromJson(Map<String, dynamic> json) {
    return RedeModel(
      json["id"],
      json["nome"],
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
    );
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

  DateTime get disponibilidade => _disponibilidade;

  set disponibilidade(DateTime value) {
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

}