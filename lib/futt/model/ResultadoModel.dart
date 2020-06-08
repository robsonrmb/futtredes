class ResultadoModel {

  int _idTorneio;
  String _tituloTorneio;
  String _dataTorneio;
  String _paisTorneio;
  String _cidadeTorneio;
  int _idJogador1;
  int _idJogador2;
  String _nomeJogador1;
  String _nomeJogador2;
  String _apelidoJogador1;
  String _apelidoJogador2;
  String _fotoJogador1;
  String _fotoJogador2;

  ResultadoModel(this._idTorneio, this._tituloTorneio, this._dataTorneio,
      this._paisTorneio, this._cidadeTorneio, this._idJogador1, this._idJogador2,
      this._nomeJogador1, this._nomeJogador2, this._apelidoJogador1,
      this._apelidoJogador2, this._fotoJogador1, this._fotoJogador2);

  factory ResultadoModel.fromJson(Map<String, dynamic> json) {
    return ResultadoModel(
        json["idTorneio"],
        json["tituloTorneio"],
        json["dataTorneio"],
        json["paisTorneio"],
        json["cidadeTorneio"],
        json["idJogador1"],
        json["idJogador2"],
        json["nomeJogador1"],
        json["nomeJogador2"],
        json["apelidoJogador1"],
        json["apelidoJogador2"],
        json["fotoJogador1"],
        json["fotoJogador2"]
    );
  }

  String get apelidoJogador2 => _apelidoJogador2;

  set apelidoJogador2(String value) {
    _apelidoJogador2 = value;
  }

  String get apelidoJogador1 => _apelidoJogador1;

  set apelidoJogador1(String value) {
    _apelidoJogador1 = value;
  }

  String get nomeJogador2 => _nomeJogador2;

  set nomeJogador2(String value) {
    _nomeJogador2 = value;
  }

  String get nomeJogador1 => _nomeJogador1;

  set nomeJogador1(String value) {
    _nomeJogador1 = value;
  }

  int get idJogador2 => _idJogador2;

  set idJogador2(int value) {
    _idJogador2 = value;
  }

  int get idJogador1 => _idJogador1;

  set idJogador1(int value) {
    _idJogador1 = value;
  }

  String get cidadeTorneio => _cidadeTorneio;

  set cidadeTorneio(String value) {
    _cidadeTorneio = value;
  }

  String get paisTorneio => _paisTorneio;

  set paisTorneio(String value) {
    _paisTorneio = value;
  }

  String get dataTorneio => _dataTorneio;

  set dataTorneio(String value) {
    _dataTorneio = value;
  }

  String get tituloTorneio => _tituloTorneio;

  set tituloTorneio(String value) {
    _tituloTorneio = value;
  }

  int get idTorneio => _idTorneio;

  set idTorneio(int value) {
    _idTorneio = value;
  }

  String get fotoJogador2 => _fotoJogador2;

  set fotoJogador2(String value) {
    _fotoJogador2 = value;
  }

  String get fotoJogador1 => _fotoJogador1;

  set fotoJogador1(String value) {
    _fotoJogador1 = value;
  }

}