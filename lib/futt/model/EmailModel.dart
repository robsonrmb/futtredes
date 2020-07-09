class EmailModel {
  String _email;
  int _ano;

  EmailModel(this._email, this._ano);

  toJson() {
    return {
      'email': _email,
      'ano': _ano,
    };
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}