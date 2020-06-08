class RespPerformanceModel {

  String _descricao;
  int _valor;
  int _maior;

  int _ruim;
  int _regular;
  int _bom;
  int _otimo;

  RespPerformanceModel(this._ruim, this._regular, this._bom, this._otimo);
  RespPerformanceModel.GraficoSimples(this._descricao, this._ruim, this._regular, this._bom, this._otimo);
  RespPerformanceModel.Grafico(this._descricao, this._valor);
  RespPerformanceModel.Ruim(this._descricao, this._valor, this._maior);
  RespPerformanceModel.Regular(this._descricao, this._valor, this._maior);
  RespPerformanceModel.Bom(this._descricao, this._valor, this._maior);
  RespPerformanceModel.Otimo(this._descricao, this._valor, this._maior);

  factory RespPerformanceModel.fromJson(Map<String, dynamic> json) {
    return RespPerformanceModel(
      json["ruim"],
      json["regular"],
      json["bom"],
      json["otimo"],
    );
  }

  int get otimo => _otimo;

  set otimo(int value) {
    _otimo = value;
  }

  int get bom => _bom;

  set bom(int value) {
    _bom = value;
  }

  int get regular => _regular;

  set regular(int value) {
    _regular = value;
  }

  int get ruim => _ruim;

  set ruim(int value) {
    _ruim = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get valor => _valor;

  set valor(int value) {
    _valor = value;
  }

  int get maior => _maior;

  set maior(int value) {
    _maior = value;
  }

}