class QuantidadeModel {
  int _quantidade;

  QuantidadeModel(this._quantidade);

  factory QuantidadeModel.fromJson(Map<String, dynamic> json) {
    return QuantidadeModel(
      json["quantidade"],
    );
  }

  int get quantidade => _quantidade;

  set quantidade(int value) {
    _quantidade = value;
  }

}