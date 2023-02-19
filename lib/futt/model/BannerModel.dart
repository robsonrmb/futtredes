class BannerModel {
  bool? _showRedes;
  bool? _showMinhasRedes;
  bool? _showDashboard;
  bool? _showCadastroRedes;
  bool? _showPerfil;
  bool? _showRegras;
  bool? _showJogos;
  bool? _showIntegrantes;
  bool? _showRanking;
  String? _linkRedes;
  String? _linkMinhasRedes;
  String? _linkDashboard;
  String? _linkCadastroRedes;
  String? _linkPerfil;
  String? _linkRegras;
  String? _linkJogos;
  String? _linkIntegrantes;
  String? _linkRanking;

  BannerModel(this._showRedes, this._showMinhasRedes, this._showDashboard, this._showCadastroRedes, this._showPerfil,
              this._showRegras, this._showJogos, this._showIntegrantes, this._showRanking,
              this._linkRedes, this._linkMinhasRedes, this._linkDashboard, this._linkCadastroRedes, this._linkPerfil,
              this._linkRegras, this._linkJogos, this._linkIntegrantes, this._linkRanking);

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        json["showRedes"],
        json["showMinhasRedes"],
        json["showDashboard"],
        json["showCadastroRedes"],
        json["showPerfil"],
        json["showRegras"],
        json["showJogos"],
        json["showIntegrantes"],
        json["showRanking"],
        json["linkRedes"],
        json["linkMinhasRedes"],
        json["linkDashboard"],
        json["linkCadastroRedes"],
        json["linkPerfil"],
        json["linkRegras"],
        json["linkJogos"],
        json["linkIntegrantes"],
        json["linkRanking"]
    );
  }

  toJson() {
    return {
      'showRedes': _showRedes,
      'showMinhasRedes': _showMinhasRedes,
    };
  }

  bool? get showRedes => _showRedes;

  set showRedes(bool? value) {
    _showRedes = value;
  }

  bool? get showMinhasRedes => _showMinhasRedes;

  set showMinhasRedes(bool? value) {
    _showMinhasRedes = value;
  }

  bool? get showRanking => _showRanking;

  set showRanking(bool? value) {
    _showRanking = value;
  }

  bool? get showIntegrantes => _showIntegrantes;

  set showIntegrantes(bool? value) {
    _showIntegrantes = value;
  }

  bool? get showJogos => _showJogos;

  set showJogos(bool? value) {
    _showJogos = value;
  }

  bool? get showRegras => _showRegras;

  set showRegras(bool? value) {
    _showRegras = value;
  }

  bool? get showPerfil => _showPerfil;

  set showPerfil(bool? value) {
    _showPerfil = value;
  }

  bool? get showCadastroRedes => _showCadastroRedes;

  set showCadastroRedes(bool? value) {
    _showCadastroRedes = value;
  }

  bool? get showDashboard => _showDashboard;

  set showDashboard(bool? value) {
    _showDashboard = value;
  }

  String? get linkRanking => _linkRanking;

  set linkRanking(String? value) {
    _linkRanking = value;
  }

  String? get linkIntegrantes => _linkIntegrantes;

  set linkIntegrantes(String? value) {
    _linkIntegrantes = value;
  }

  String? get linkJogos => _linkJogos;

  set linkJogos(String? value) {
    _linkJogos = value;
  }

  String? get linkRegras => _linkRegras;

  set linkRegras(String? value) {
    _linkRegras = value;
  }

  String? get linkPerfil => _linkPerfil;

  set linkPerfil(String? value) {
    _linkPerfil = value;
  }

  String? get linkCadastroRedes => _linkCadastroRedes;

  set linkCadastroRedes(String? value) {
    _linkCadastroRedes = value;
  }

  String? get linkDashboard => _linkDashboard;

  set linkDashboard(String? value) {
    _linkDashboard = value;
  }

  String? get linkMinhasRedes => _linkMinhasRedes;

  set linkMinhasRedes(String? value) {
    _linkMinhasRedes = value;
  }

  String? get linkRedes => _linkRedes;

  set linkRedes(String? value) {
    _linkRedes = value;
  }

}
