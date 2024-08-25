import 'package:changa_lab/data/model/global/userdata/global_user.dart';

class RegistrationResponseModel {
  RegistrationResponseModel({String? remark, String? status, Message? message, Data? data}) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  RegistrationResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({String? accessToken, GlobalUser? user, String? tokenType}) {
    _accessToken = accessToken;
    _user = user;
    _tokenType = tokenType;
  }

  Data.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _user = json['user'] != null ? GlobalUser.fromJson(json['user']) : null;
    _tokenType = json['token_type'];
  }

  String? _accessToken;
  GlobalUser? _user;
  String? _tokenType;

  String? get accessToken => _accessToken;
  GlobalUser? get user => _user;
  String? get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token_type'] = _tokenType;
    return map;
  }
}

class Message {
  Message({List<String>? success, List<String>? error}) {
    _success = success;
    _error = error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ? [json['success'].toString()] : null;
    _error = json['error'] != null ? [json['error'].toString()] : null;
  }

  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }
}
