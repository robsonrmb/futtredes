class RespQuantidadeModel {
  int _valor1;
  int _valor2;
  int _valor3;
  int _valor4;
  int _valor5;
  int _valor6;
  int _valor7;
  int _valor8;
  int _valor9;
  int _valor10;
  int _valor11;
  int _valor12;
  int _valor13;
  int _valor14;
  int _valor15;
  int _valor16;
  int _valor17;
  int _valor18;
  int _valor19;
  int _valor20;

  RespQuantidadeModel(this._valor1, this._valor2, this._valor3, this._valor4,
      this._valor5, this._valor6, this._valor7, this._valor8, this._valor9,
      this._valor10, this._valor11, this._valor12, this._valor13, this._valor14,
      this._valor15, this._valor16, this._valor17, this._valor18, this._valor19,
      this._valor20);

  RespQuantidadeModel.Resposta(this._valor1, this._valor2);

  factory RespQuantidadeModel.fromJson(Map<String, dynamic> json) {
    return RespQuantidadeModel(
      json["valor1"],
      json["valor2"],
      json["valor3"],
      json["valor4"],
      json["valor5"],
      json["valor6"],
      json["valor7"],
      json["valor8"],
      json["valor9"],
      json["valor10"],
      json["valor11"],
      json["valor12"],
      json["valor13"],
      json["valor14"],
      json["valor15"],
      json["valor16"],
      json["valor17"],
      json["valor18"],
      json["valor19"],
      json["valor20"],
    );
  }

  int get valor20 => _valor20;

  set valor20(int value) {
    _valor20 = value;
  }

  int get valor19 => _valor19;

  set valor19(int value) {
    _valor19 = value;
  }

  int get valor18 => _valor18;

  set valor18(int value) {
    _valor18 = value;
  }

  int get valor17 => _valor17;

  set valor17(int value) {
    _valor17 = value;
  }

  int get valor16 => _valor16;

  set valor16(int value) {
    _valor16 = value;
  }

  int get valor15 => _valor15;

  set valor15(int value) {
    _valor15 = value;
  }

  int get valor14 => _valor14;

  set valor14(int value) {
    _valor14 = value;
  }

  int get valor13 => _valor13;

  set valor13(int value) {
    _valor13 = value;
  }

  int get valor12 => _valor12;

  set valor12(int value) {
    _valor12 = value;
  }

  int get valor11 => _valor11;

  set valor11(int value) {
    _valor11 = value;
  }

  int get valor10 => _valor10;

  set valor10(int value) {
    _valor10 = value;
  }

  int get valor9 => _valor9;

  set valor9(int value) {
    _valor9 = value;
  }

  int get valor8 => _valor8;

  set valor8(int value) {
    _valor8 = value;
  }

  int get valor7 => _valor7;

  set valor7(int value) {
    _valor7 = value;
  }

  int get valor6 => _valor6;

  set valor6(int value) {
    _valor6 = value;
  }

  int get valor5 => _valor5;

  set valor5(int value) {
    _valor5 = value;
  }

  int get valor4 => _valor4;

  set valor4(int value) {
    _valor4 = value;
  }

  int get valor3 => _valor3;

  set valor3(int value) {
    _valor3 = value;
  }

  int get valor2 => _valor2;

  set valor2(int value) {
    _valor2 = value;
  }

  int get valor1 => _valor1;

  set valor1(int value) {
    _valor1 = value;
  }

}