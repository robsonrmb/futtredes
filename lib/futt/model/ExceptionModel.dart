import 'package:futt/futt/model/TipoAvaliacaoModel.dart';

class ExceptionModel {
  int? _status;
  String? _msg;
  int? _timeStamp;
  String? _cause;
  String? _stackTrace;

  ExceptionModel(this._status, this._msg, this._timeStamp, this._cause, this._stackTrace);

  factory ExceptionModel.fromJson(Map<String, dynamic> json) {
    return ExceptionModel(
      json["status"],
      json["msg"],
      json["timeStamp"],
      json["cause"],
      json["stackTrace"],
    );
  }

  String? get stackTrace => _stackTrace;

  set stackTrace(String? value) {
    _stackTrace = value;
  }

  String? get cause => _cause;

  set cause(String? value) {
    _cause = value;
  }

  int? get timeStamp => _timeStamp;

  set timeStamp(int? value) {
    _timeStamp = value;
  }

  String? get msg => _msg;

  set msg(String? value) {
    _msg = value;
  }

  int? get status => _status;

  set status(int? value) {
    _status = value;
  }

}