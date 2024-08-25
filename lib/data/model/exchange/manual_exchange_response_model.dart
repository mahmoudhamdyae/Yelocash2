import 'dart:io';
import 'package:changa_lab/data/model/global/exchange/exchange_model.dart';
import 'package:changa_lab/data/model/global/userdata/global_user_data.dart';
import 'package:flutter/foundation.dart';
import '../global/meassage_model.dart';

class ManualExchangeResponseModel {
  ManualExchangeResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  ManualExchangeResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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
  Data({
    GlobalExchangeModel? exchange,
    GlobalUserKycData? requiredData,
  }) {
    _exchange = exchange;
    _requiredData = requiredData;
  }

  Data.fromJson(dynamic json) {
    _exchange = json['exchange'] != null ? GlobalExchangeModel.fromJson(json['exchange']) : null;
    _requiredData = json['required_data'] != null ? GlobalUserKycData.fromJson(json['required_data']) : null;
  }
  GlobalExchangeModel? _exchange;
  GlobalUserKycData? _requiredData;

  GlobalExchangeModel? get exchange => _exchange;
  GlobalUserKycData? get requiredData => _requiredData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_exchange != null) {
      map['exchange'] = _exchange?.toJson();
    }
    if (_requiredData != null) {
      map['required_data'] = _requiredData?.toJson();
    }
    return map;
  }
}

class RequiredData {
  RequiredData({
    int? id,
    String? act,
    Form? formData,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _act = act;
    _formData = formData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  RequiredData.fromJson(dynamic json) {
    _id = json['id'];
    _act = json['act'].toString();
    _formData = json['form_data'] != null ? Form.fromJson(json['form_data']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _act;
  Form? _formData;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get act => _act;
  Form? get formData => _formData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['act'] = _act;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Form {
  Form({List<FormModel>? list}) {
    _list = list;
  }

  List<FormModel>? _list = [];
  List<FormModel>? get list => _list;

  Form.fromJson(dynamic json) {
    var map = Map.from(json).map((key, value) => MapEntry(key, value));
    try {
      List<FormModel>? list = map.entries
          .map(
            (e) => FormModel(e.value['name'], e.value['label'], e.value['is_required'], e.value['extensions'], (e.value['options'] as List).map((e) => e as String).toList(), e.value['type'], ''),
          )
          .toList();

      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class FormModel {
  String? name;
  String? label;
  String? isRequired;
  String? extensions;
  List<String>? options;
  String? type;
  dynamic selectedValue;
  File? imageFile;
  List<String>? cbSelected;

  FormModel(this.name, this.label, this.isRequired, this.extensions, this.options, this.type, this.selectedValue, {this.cbSelected, this.imageFile});
}

// class Exchange {
//   Exchange({
//     int? id,
//     String? userId,
//     String? sendCurrencyId,
//     String? receiveCurrencyId,
//     String? sendingAmount,
//     String? receivingAmount,
//     String? sendingCharge,
//     String? receivingCharge,
//     Charge? charge,
//     String? buyRate,
//     String? sellRate,
//     String? refundAmount,
//     String? status,
//     String? automaticPaymentStatus,
//     String? walletId,
//     String? exchangeId,
//     dynamic userProof,
//     dynamic adminTrxNo,
//     dynamic adminFeedback,
//     List<dynamic>? userData,
//     dynamic transactionProofData,
//     String? plafrom,
//     String? createdAt,
//     String? updatedAt,
//     SendCurrency? sendCurrency,
//   }) {
//     _id = id;
//     _userId = userId;
//     _sendCurrencyId = sendCurrencyId;
//     _receiveCurrencyId = receiveCurrencyId;
//     _sendingAmount = sendingAmount;
//     _receivingAmount = receivingAmount;
//     _sendingCharge = sendingCharge;
//     _receivingCharge = receivingCharge;
//     _charge = charge;
//     _buyRate = buyRate;
//     _sellRate = sellRate;
//     _refundAmount = refundAmount;
//     _status = status;
//     _automaticPaymentStatus = automaticPaymentStatus;
//     _walletId = walletId;
//     _exchangeId = exchangeId;
//     _userProof = userProof;
//     _adminTrxNo = adminTrxNo;
//     _adminFeedback = adminFeedback;
//     _userData = userData;
//     _transactionProofData = transactionProofData;
//     _plafrom = plafrom;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _sendCurrency = sendCurrency;
//   }

//   Exchange.fromJson(dynamic json) {
//     _id = json['id'];
//     _userId = json['user_id'] == null ? '' : json["user_id"].toString();
//     _sendCurrencyId = json['send_currency_id'] == null ? '' : json["send_currency_id"].toString();
//     _receiveCurrencyId = json['receive_currency_id'] == null ? '' : json["receive_currency_id"].toString();
//     _sendingAmount = json['sending_amount'] == null ? '' : json["sending_amount"].toString();
//     _receivingAmount = json['receiving_amount'] == null ? '' : json["receiving_amount"].toString();
//     _sendingCharge = json['sending_charge'] == null ? '' : json["sending_charge"].toString();
//     _receivingCharge = json['receiving_charge'] == null ? '' : json["receiving_charge"].toString();
//     _charge = json['charge'] != null ? Charge.fromJson(json['charge']) : null;
//     _buyRate = json['buy_rate'] == null ? '' : json["receiving_charge"].toString();
//     _sellRate = json['sell_rate'] == null ? '' : json["sell_rate"].toString();
//     _refundAmount = json['refund_amount'] == null ? '' : json["refund_amount"].toString();
//     _status = json['status'] == null ? '' : json["status"].toString();
//     _automaticPaymentStatus = json['automatic_payment_status'] == null ? '' : json["automatic_payment_status"].toString();
//     _walletId = json['wallet_id'] == null ? '' : json["wallet_id"].toString();
//     _exchangeId = json['exchange_id'] == null ? '' : json["exchange_id"].toString();
//     _userProof = json['user_proof'].toString();
//     _adminTrxNo = json['admin_trx_no'] == null ? '' : json["admin_trx_no"].toString();
//     _adminFeedback = json['admin_feedback'] == null ? '' : json["admin_feedback"].toString();
//     _transactionProofData = json['transaction_proof_data'].toString();
//     _plafrom = json['plafrom'].toString();
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _sendCurrency = json['send_currency'] != null ? SendCurrency.fromJson(json['send_currency']) : null;
//   }

//   int? _id;
//   String? _userId;
//   String? _sendCurrencyId;
//   String? _receiveCurrencyId;
//   String? _sendingAmount;
//   String? _receivingAmount;
//   String? _sendingCharge;
//   String? _receivingCharge;
//   Charge? _charge;
//   String? _buyRate;
//   String? _sellRate;
//   String? _refundAmount;
//   String? _status;
//   String? _automaticPaymentStatus;
//   String? _walletId;
//   String? _exchangeId;
//   dynamic _userProof;
//   dynamic _adminTrxNo;
//   dynamic _adminFeedback;
//   List<dynamic>? _userData;
//   dynamic _transactionProofData;
//   String? _plafrom;
//   String? _createdAt;
//   String? _updatedAt;
//   SendCurrency? _sendCurrency;

//   int? get id => _id;
//   String? get userId => _userId;
//   String? get sendCurrencyId => _sendCurrencyId;
//   String? get receiveCurrencyId => _receiveCurrencyId;
//   String? get sendingAmount => _sendingAmount;
//   String? get receivingAmount => _receivingAmount;
//   String? get sendingCharge => _sendingCharge;
//   String? get receivingCharge => _receivingCharge;
//   Charge? get charge => _charge;
//   String? get buyRate => _buyRate;
//   String? get sellRate => _sellRate;
//   String? get refundAmount => _refundAmount;
//   String? get status => _status;
//   String? get automaticPaymentStatus => _automaticPaymentStatus;
//   String? get walletId => _walletId;
//   String? get exchangeId => _exchangeId;
//   dynamic get userProof => _userProof;
//   dynamic get adminTrxNo => _adminTrxNo;
//   dynamic get adminFeedback => _adminFeedback;
//   List<dynamic>? get userData => _userData;
//   dynamic get transactionProofData => _transactionProofData;
//   String? get plafrom => _plafrom;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   SendCurrency? get sendCurrency => _sendCurrency;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['user_id'] = _userId;
//     map['send_currency_id'] = _sendCurrencyId;
//     map['receive_currency_id'] = _receiveCurrencyId;
//     map['sending_amount'] = _sendingAmount;
//     map['receiving_amount'] = _receivingAmount;
//     map['sending_charge'] = _sendingCharge;
//     map['receiving_charge'] = _receivingCharge;
//     if (_charge != null) {
//       map['charge'] = _charge?.toJson();
//     }
//     map['buy_rate'] = _buyRate;
//     map['sell_rate'] = _sellRate;
//     map['refund_amount'] = _refundAmount;
//     map['status'] = _status;
//     map['automatic_payment_status'] = _automaticPaymentStatus;
//     map['wallet_id'] = _walletId;
//     map['exchange_id'] = _exchangeId;
//     map['user_proof'] = _userProof;
//     map['admin_trx_no'] = _adminTrxNo;
//     map['admin_feedback'] = _adminFeedback;
//     if (_userData != null) {
//       map['user_data'] = _userData?.map((v) => v.toJson()).toList();
//     }
//     map['transaction_proof_data'] = _transactionProofData;
//     map['plafrom'] = _plafrom;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     if (_sendCurrency != null) {
//       map['send_currency'] = _sendCurrency?.toJson();
//     }
//     return map;
//   }
// }

// class SendCurrency {
//   SendCurrency({
//     int? id,
//     String? gatewayId,
//     String? name,
//     String? curSym,
//     String? sellAt,
//     String? buyAt,
//     String? fixedChargeForSell,
//     String? percentChargeForSell,
//     String? fixedChargeForBuy,
//     String? percentChargeForBuy,
//     String? reserve,
//     String? minimumLimitForSell,
//     String? maximumLimitForSell,
//     String? minimumLimitForBuy,
//     String? maximumLimitForBuy,
//     String? userDetailFormId,
//     String? instruction,
//     String? image,
//     String? availableForSell,
//     String? availableForBuy,
//     String? showRate,
//     String? status,
//     String? trxProofFormId,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     _id = id;
//     _gatewayId = gatewayId;
//     _name = name;
//     _curSym = curSym;
//     _sellAt = sellAt;
//     _buyAt = buyAt;
//     _fixedChargeForSell = fixedChargeForSell;
//     _percentChargeForSell = percentChargeForSell;
//     _fixedChargeForBuy = fixedChargeForBuy;
//     _percentChargeForBuy = percentChargeForBuy;
//     _reserve = reserve;
//     _minimumLimitForSell = minimumLimitForSell;
//     _maximumLimitForSell = maximumLimitForSell;
//     _minimumLimitForBuy = minimumLimitForBuy;
//     _maximumLimitForBuy = maximumLimitForBuy;
//     _userDetailFormId = userDetailFormId;
//     _instruction = instruction;
//     _image = image;
//     _availableForSell = availableForSell;
//     _availableForBuy = availableForBuy;
//     _showRate = showRate;
//     _status = status;
//     _trxProofFormId = trxProofFormId;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//   }

//   SendCurrency.fromJson(dynamic json) {
//     _id = json['id'];
//     _gatewayId = json['gateway_id'].toString();
//     _name = json['name'];
//     _curSym = json['cur_sym'] != null ? json['cur_sym'].toString() : '';
//     _sellAt = json['sell_at'] != null ? json['sell_at'].toString() : '';
//     _buyAt = json['buy_at'] != null ? json['buy_at'].toString() : '';
//     _fixedChargeForSell = json['fixed_charge_for_sell'] != null ? json['fixed_charge_for_sell'].toString() : '';
//     _percentChargeForSell = json['percent_charge_for_sell'] != null ? json['percent_charge_for_sell'].toString() : '';
//     _fixedChargeForBuy = json['fixed_charge_for_buy'] != null ? json['fixed_charge_for_buy'].toString() : '';
//     _percentChargeForBuy = json['percent_charge_for_buy'] != null ? json['percent_charge_for_buy'].toString() : '';
//     _reserve = json['reserve'].toString();
//     _minimumLimitForSell = json['minimum_limit_for_sell'] != null ? json['minimum_limit_for_sell'].toString() : '';
//     _maximumLimitForSell = json['maximum_limit_for_sell'] != null ? json['maximum_limit_for_sell'].toString() : '';
//     _minimumLimitForBuy = json['minimum_limit_for_buy'] != null ? json['minimum_limit_for_buy'].toString() : '';
//     _maximumLimitForBuy = json['maximum_limit_for_buy'] != null ? json['maximum_limit_for_buy'].toString() : '';
//     _userDetailFormId = json['user_detail_form_id'].toString();
//     _instruction = json['instruction'].toString();
//     _image = json['image'].toString();
//     _availableForSell = json['available_for_sell'] != null ? json['available_for_sell'].toString() : '';
//     _availableForBuy = json['available_for_buy'] != null ? json['available_for_buy'].toString() : '';
//     _showRate = json['show_rate'] != null ? json['show_rate'].toString() : '';
//     _status = json['status'].toString();
//     _trxProofFormId = json['trx_proof_form_id'].toString();
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   String? _gatewayId;
//   String? _name;
//   String? _curSym;
//   String? _sellAt;
//   String? _buyAt;
//   String? _fixedChargeForSell;
//   String? _percentChargeForSell;
//   String? _fixedChargeForBuy;
//   String? _percentChargeForBuy;
//   String? _reserve;
//   String? _minimumLimitForSell;
//   String? _maximumLimitForSell;
//   String? _minimumLimitForBuy;
//   String? _maximumLimitForBuy;
//   String? _userDetailFormId;
//   String? _instruction;
//   String? _image;
//   String? _availableForSell;
//   String? _availableForBuy;
//   String? _showRate;
//   String? _status;
//   String? _trxProofFormId;
//   String? _createdAt;
//   String? _updatedAt;

//   int? get id => _id;
//   String? get gatewayId => _gatewayId;
//   String? get name => _name;
//   String? get curSym => _curSym;
//   String? get sellAt => _sellAt;
//   String? get buyAt => _buyAt;
//   String? get fixedChargeForSell => _fixedChargeForSell;
//   String? get percentChargeForSell => _percentChargeForSell;
//   String? get fixedChargeForBuy => _fixedChargeForBuy;
//   String? get percentChargeForBuy => _percentChargeForBuy;
//   String? get reserve => _reserve;
//   String? get minimumLimitForSell => _minimumLimitForSell;
//   String? get maximumLimitForSell => _maximumLimitForSell;
//   String? get minimumLimitForBuy => _minimumLimitForBuy;
//   String? get maximumLimitForBuy => _maximumLimitForBuy;
//   String? get userDetailFormId => _userDetailFormId;
//   String? get instruction => _instruction;
//   String? get image => _image;
//   String? get availableForSell => _availableForSell;
//   String? get availableForBuy => _availableForBuy;
//   String? get showRate => _showRate;
//   String? get status => _status;
//   String? get trxProofFormId => _trxProofFormId;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['gateway_id'] = _gatewayId;
//     map['name'] = _name;
//     map['cur_sym'] = _curSym;
//     map['sell_at'] = _sellAt;
//     map['buy_at'] = _buyAt;
//     map['fixed_charge_for_sell'] = _fixedChargeForSell;
//     map['percent_charge_for_sell'] = _percentChargeForSell;
//     map['fixed_charge_for_buy'] = _fixedChargeForBuy;
//     map['percent_charge_for_buy'] = _percentChargeForBuy;
//     map['reserve'] = _reserve;
//     map['minimum_limit_for_sell'] = _minimumLimitForSell;
//     map['maximum_limit_for_sell'] = _maximumLimitForSell;
//     map['minimum_limit_for_buy'] = _minimumLimitForBuy;
//     map['maximum_limit_for_buy'] = _maximumLimitForBuy;
//     map['user_detail_form_id'] = _userDetailFormId;
//     map['instruction'] = _instruction;
//     map['image'] = _image;
//     map['available_for_sell'] = _availableForSell;
//     map['available_for_buy'] = _availableForBuy;
//     map['show_rate'] = _showRate;
//     map['status'] = _status;
//     map['trx_proof_form_id'] = _trxProofFormId;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
// }

// class Charge {
//   Charge({
//     SendingCharge? sendingCharge,
//     ReceivingCharge? receivingCharge,
//   }) {
//     _sendingCharge = sendingCharge;
//     _receivingCharge = receivingCharge;
//   }

//   Charge.fromJson(dynamic json) {
//     _sendingCharge = json['sending_charge'] != null ? SendingCharge.fromJson(json['sending_charge']) : null;
//     _receivingCharge = json['receiving_charge'] != null ? ReceivingCharge.fromJson(json['receiving_charge']) : null;
//   }
//   SendingCharge? _sendingCharge;
//   ReceivingCharge? _receivingCharge;

//   SendingCharge? get sendingCharge => _sendingCharge;
//   ReceivingCharge? get receivingCharge => _receivingCharge;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_sendingCharge != null) {
//       map['sending_charge'] = _sendingCharge?.toJson();
//     }
//     if (_receivingCharge != null) {
//       map['receiving_charge'] = _receivingCharge?.toJson();
//     }
//     return map;
//   }
// }

// class ReceivingCharge {
//   ReceivingCharge({
//     String? fixedCharge,
//     String? percentCharge,
//     String? percentAmount,
//     String? totalCharge,
//   }) {
//     _fixedCharge = fixedCharge;
//     _percentCharge = percentCharge;
//     _percentAmount = percentAmount;
//     _totalCharge = totalCharge;
//   }

//   ReceivingCharge.fromJson(dynamic json) {
//     _fixedCharge = json['fixed_charge'] == null ? '' : json['fixed_charge'].toString();
//     _percentCharge = json['percent_charge'] == null ? '' : json['percent_charge'].toString();
//     _percentAmount = json['percent_amount'] == null ? '' : json['percent_amount'].toString();
//     _totalCharge = json['total_charge'] == null ? '' : json['total_charge'].toString();
//   }
//   String? _fixedCharge;
//   String? _percentCharge;
//   String? _percentAmount;
//   String? _totalCharge;

//   String? get fixedCharge => _fixedCharge;
//   String? get percentCharge => _percentCharge;
//   String? get percentAmount => _percentAmount;
//   String? get totalCharge => _totalCharge;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['fixed_charge'] = _fixedCharge;
//     map['percent_charge'] = _percentCharge;
//     map['percent_amount'] = _percentAmount;
//     map['total_charge'] = _totalCharge;
//     return map;
//   }
// }

// class SendingCharge {
//   SendingCharge({
//     String? fixedCharge,
//     String? percentCharge,
//     String? percentAmount,
//     String? totalCharge,
//   }) {
//     _fixedCharge = fixedCharge;
//     _percentCharge = percentCharge;
//     _percentAmount = percentAmount;
//     _totalCharge = totalCharge;
//   }

//   SendingCharge.fromJson(dynamic json) {
//     _fixedCharge = json['fixed_charge'] == null ? '' : json['fixed_charge'].toString();
//     _percentCharge = json['percent_charge'] == null ? '' : json['percent_charge'].toString();
//     _percentAmount = json['percent_amount'] == null ? '' : json['percent_amount'].toString();
//     _totalCharge = json['total_charge'] == null ? '' : json['total_charge'].toString();
//   }
//   String? _fixedCharge;
//   String? _percentCharge;
//   String? _percentAmount;
//   String? _totalCharge;

//   String? get fixedCharge => _fixedCharge;
//   String? get percentCharge => _percentCharge;
//   String? get percentAmount => _percentAmount;
//   String? get totalCharge => _totalCharge;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['fixed_charge'] = _fixedCharge;
//     map['percent_charge'] = _percentCharge;
//     map['percent_amount'] = _percentAmount;
//     map['total_charge'] = _totalCharge;
//     return map;
//   }
// }
