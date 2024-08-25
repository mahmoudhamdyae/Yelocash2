// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';
import 'dart:io';

import 'package:changa_lab/data/model/global/exchange/exchange_model.dart';
import 'package:changa_lab/data/model/global/meassage_model.dart';
import 'package:flutter/foundation.dart';

ConfirmExchangeModel confirmExchangeModelFromJson(String str) => ConfirmExchangeModel.fromJson(json.decode(str));

String confirmExchangeModelToJson(ConfirmExchangeModel data) => json.encode(data.toJson());

class ConfirmExchangeModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  ConfirmExchangeModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory ConfirmExchangeModel.fromJson(Map<String, dynamic> json) => ConfirmExchangeModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  bool? isAutometic;
  GlobalExchangeModel? exchange;
  String? redirectUrl;

  Data({
    this.isAutometic,
    this.exchange,
    this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isAutometic: json["is_autometic"],
        exchange: json["exchange"] == null ? null : GlobalExchangeModel.fromJson(json["exchange"]),
        redirectUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "is_autometic": isAutometic,
        "exchange": exchange?.toJson(),
        "redirect_url": redirectUrl,
      };
}

class Exchange {
  int? id;
  String? userId;
  String? sendCurrencyId;
  String? receiveCurrencyId;
  String? sendingAmount;
  String? receivingAmount;
  String? sendingCharge;
  String? receivingCharge;
  Charge? charge;
  String? buyRate;
  String? sellRate;
  String? refundAmount;
  String? status;
  String? automaticPaymentStatus;
  String? walletId;
  String? exchangeId;
  dynamic userProof;
  dynamic adminTrxNo;
  dynamic adminFeedback;
  List<UserData>? userData;
  List<TransactionProofData>? transactionProofData;
  String? plafrom;
  String? createdAt;
  String? updatedAt;
  DCurrency? receivedCurrency;
  DCurrency? sendCurrency;

  Exchange({
    this.id,
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.sendingAmount,
    this.receivingAmount,
    this.sendingCharge,
    this.receivingCharge,
    this.charge,
    this.buyRate,
    this.sellRate,
    this.refundAmount,
    this.status,
    this.automaticPaymentStatus,
    this.walletId,
    this.exchangeId,
    this.userProof,
    this.adminTrxNo,
    this.adminFeedback,
    this.userData,
    this.transactionProofData,
    this.plafrom,
    this.createdAt,
    this.updatedAt,
    this.receivedCurrency,
    this.sendCurrency,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        id: json["id"],
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"] == null ? null : json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"] == null ? null : json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"] == null ? null : json["sending_amount"].toString(),
        receivingAmount: json["receiving_amount"] == null ? null : json["receiving_amount"].toString(),
        sendingCharge: json["sending_charge"] == null ? null : json['sending_charge'].toString(),
        receivingCharge: json["receiving_charge"] == null ? null : json['receiving_charge'].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        buyRate: json["buy_rate"] == null ? null : json['buy_rate'].toString(),
        sellRate: json["sell_rate"] == null ? null : json['sell_rate'].toString(),
        refundAmount: json["refund_amount"] == null ? null : json['refund_amount'].toString(),
        status: json["status"].toString(),
        automaticPaymentStatus: json["automatic_payment_status"].toString(),
        walletId: json["wallet_id"] == null ? null : json['wallet_id'].toString(),
        exchangeId: json["exchange_id"] == null ? null : json['exchange_id'].toString(),
        userProof: json["user_proof"],
        adminTrxNo: json["admin_trx_no"],
        adminFeedback: json["admin_feedback"],
        userData: json["user_data"] == null ? [] : List<UserData>.from(json["user_data"]!.map((x) => UserData.fromJson(x))),
        transactionProofData: json["transaction_proof_data"] == null ? [] : List<TransactionProofData>.from(json["transaction_proof_data"]!.map((x) => TransactionProofData.fromJson(x))),
        plafrom: json["plafrom"] == null ? null : json['plafrom'].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
        sendCurrency: json["send_currency"] == null ? null : DCurrency.fromJson(json["send_currency"]),
        receivedCurrency: json["received_currency"] == null ? null : DCurrency.fromJson(json["received_currency"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "send_currency_id": sendCurrencyId,
        "receive_currency_id": receiveCurrencyId,
        "sending_amount": sendingAmount,
        "receiving_amount": receivingAmount,
        "sending_charge": sendingCharge,
        "receiving_charge": receivingCharge,
        "charge": charge?.toJson(),
        "buy_rate": buyRate,
        "sell_rate": sellRate,
        "refund_amount": refundAmount,
        "status": status,
        "automatic_payment_status": automaticPaymentStatus,
        "wallet_id": walletId,
        "exchange_id": exchangeId,
        "user_proof": userProof,
        "admin_trx_no": adminTrxNo,
        "admin_feedback": adminFeedback,
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
        "transaction_proof_data": transactionProofData,
        "plafrom": plafrom,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "received_currency": receivedCurrency?.toJson(),
        "send_currency": sendCurrency?.toJson(),
      };
}

class Charge {
  IngCharge? sendingCharge;
  IngCharge? receivingCharge;

  Charge({
    this.sendingCharge,
    this.receivingCharge,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        sendingCharge: json["sending_charge"] == null ? null : IngCharge.fromJson(json["sending_charge"]),
        receivingCharge: json["receiving_charge"] == null ? null : IngCharge.fromJson(json["receiving_charge"]),
      );

  Map<String, dynamic> toJson() => {
        "sending_charge": sendingCharge?.toJson(),
        "receiving_charge": receivingCharge?.toJson(),
      };
}

class IngCharge {
  String? fixedCharge;
  String? percentCharge;
  String? percentAmount;
  String? totalCharge;

  IngCharge({
    this.fixedCharge,
    this.percentCharge,
    this.percentAmount,
    this.totalCharge,
  });

  factory IngCharge.fromJson(Map<String, dynamic> json) => IngCharge(
        fixedCharge: json["fixed_charge"] == null ? '' : json['fixed_charge'].toString(),
        percentCharge: json["percent_charge"] == null ? '' : json['percent_charge'].toString(),
        percentAmount: json["percent_amount"] == null ? '' : json['percent_amount'].toString(),
        totalCharge: json["total_charge"] == null ? '' : json['total_charge'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "fixed_charge": fixedCharge,
        "percent_charge": percentCharge,
        "percent_amount": percentAmount,
        "total_charge": totalCharge,
      };
}

class TransactionProofData {
  String? name;
  String? type;
  String? value;

  TransactionProofData({
    this.name,
    this.type,
    this.value,
  });

  factory TransactionProofData.fromJson(Map<String, dynamic> json) => TransactionProofData(
        name: json["name"].toString(),
        type: json["type"] != null ? json["type"].toString() : '',
        value: json["value"] != null ? json["value"].toString() : '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}

class DCurrency {
  int? id;
  String? gatewayId;
  String? name;
  String? curSym;
  String? sellAt;
  String? buyAt;
  String? fixedChargeForSell;
  String? percentChargeForSell;
  String? fixedChargeForBuy;
  String? percentChargeForBuy;
  String? reserve;
  String? minimumLimitForSell;
  String? maximumLimitForSell;
  String? minimumLimitForBuy;
  String? maximumLimitForBuy;
  String? userDetailFormId;
  String? instruction;
  String? image;
  String? availableForSell;
  String? availableForBuy;
  String? showRate;
  String? status;
  String? trxProofFormId;
  String? createdAt;
  String? updatedAt;
  UserDetailsData? userDetailsData;
  GatewayCurrency? gatewayCurrency;

  DCurrency({
    this.id,
    this.gatewayId,
    this.name,
    this.curSym,
    this.sellAt,
    this.buyAt,
    this.fixedChargeForSell,
    this.percentChargeForSell,
    this.fixedChargeForBuy,
    this.percentChargeForBuy,
    this.reserve,
    this.minimumLimitForSell,
    this.maximumLimitForSell,
    this.minimumLimitForBuy,
    this.maximumLimitForBuy,
    this.userDetailFormId,
    this.instruction,
    this.image,
    this.availableForSell,
    this.availableForBuy,
    this.showRate,
    this.status,
    this.trxProofFormId,
    this.createdAt,
    this.updatedAt,
    this.userDetailsData,
    this.gatewayCurrency,
  });

  factory DCurrency.fromJson(Map<String, dynamic> json) => DCurrency(
        id: json["id"],
        name: json["name"] != null ? json["name"].toString() : '',
        curSym: json["cur_sym"] != null ? json["cur_sym"].toString() : '',
        sellAt: json["sell_at"] != null ? json["sell_at"].toString() : '',
        buyAt: json["buy_at"] != null ? json["buy_at"].toString() : '',
        fixedChargeForSell: json["fixed_charge_for_sell"] != null ? json["fixed_charge_for_sell"].toString() : '',
        percentChargeForSell: json["percent_charge_for_sell"] != null ? json["percent_charge_for_sell"].toString() : '',
        fixedChargeForBuy: json["fixed_charge_for_buy"] != null ? json["fixed_charge_for_buy"].toString() : '',
        percentChargeForBuy: json["percent_charge_for_buy"] != null ? json["percent_charge_for_buy"].toString() : '',
        reserve: json["reserve"] != null ? json["reserve"].toString() : '',
        minimumLimitForSell: json["minimum_limit_for_sell"] != null ? json["minimum_limit_for_sell"].toString() : '',
        maximumLimitForSell: json["maximum_limit_for_sell"] != null ? json["maximum_limit_for_sell"].toString() : '',
        minimumLimitForBuy: json["minimum_limit_for_buy"] != null ? json["minimum_limit_for_buy"].toString() : '',
        maximumLimitForBuy: json["maximum_limit_for_buy"] != null ? json["maximum_limit_for_buy"].toString() : '',
        image: json["image"].toString(),
        gatewayId: json["gateway_id"].toString(),
        userDetailFormId: json["user_detail_form_id"].toString(),
        instruction: json["instruction"].toString(),
        availableForSell: json["available_for_sell"] != null ? json["available_for_sell"].toString() : '',
        availableForBuy: json["available_for_buy"] != null ? json["available_for_buy"].toString() : '',
        showRate: json["show_rate"] != null ? json["show_rate"].toString() : '',
        status: json["status"].toString(),
        trxProofFormId: json["trx_proof_form_id"].toString(),
        createdAt: json["created_at"] == null ? '' : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? '' : json["updated_at"].toString(),
        userDetailsData: json["user_details_data"] == null ? null : UserDetailsData.fromJson(json["user_details_data"]),
        // attention: sometime gateway currency
        gatewayCurrency: json["gateway_currency"] == null ? null : GatewayCurrency.fromJson(json["gateway_currency"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gateway_id": gatewayId,
        "name": name,
        "cur_sym": curSym,
        "sell_at": sellAt,
        "buy_at": buyAt,
        "fixed_charge_for_sell": fixedChargeForSell,
        "percent_charge_for_sell": percentChargeForSell,
        "fixed_charge_for_buy": fixedChargeForBuy,
        "percent_charge_for_buy": percentChargeForBuy,
        "reserve": reserve,
        "minimum_limit_for_sell": minimumLimitForSell,
        "maximum_limit_for_sell": maximumLimitForSell,
        "minimum_limit_for_buy": minimumLimitForBuy,
        "maximum_limit_for_buy": maximumLimitForBuy,
        "user_detail_form_id": userDetailFormId,
        "instruction": instruction,
        "image": image,
        "available_for_sell": availableForSell,
        "available_for_buy": availableForBuy,
        "show_rate": showRate,
        "status": status,
        "trx_proof_form_id": trxProofFormId,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "user_details_data": userDetailsData?.toJson(),
        "gateway_currency": gatewayCurrency?.toJson(),
      };
}

class GatewayCurrency {
  int? id;
  String? formId;
  String? code;
  String? name;
  String? alias;
  String? status;
  String? gatewayParameters;

  String? crypto;
  dynamic extra;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;

  GatewayCurrency({
    this.id,
    this.formId,
    this.code,
    this.name,
    this.alias,
    this.status,
    this.gatewayParameters,
    this.crypto,
    this.extra,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory GatewayCurrency.fromJson(Map<String, dynamic> json) => GatewayCurrency(
        id: json["id"],
        formId: json["form_id"].toString(),
        code: json["code"].toString(),
        name: json["name"] != null ? json["name"].toString() : '',
        alias: json["alias"],
        status: json["status"].toString(),
        gatewayParameters: json["gateway_parameters"].toString(),
        crypto: json["crypto"] != null ? json["crypto"].toString() : '',
        extra: json["extra"].toString(),
        description: json["description"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "form_id": formId,
        "code": code,
        "name": name,
        "alias": alias,
        "status": status,
        "gateway_parameters": gatewayParameters,
        "crypto": crypto,
        "extra": extra,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class UserData {
  String? name;
  String? type;
  String? value;

  UserData({
    this.name,
    this.type,
    this.value,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        type: json["type"],
        value: json["value"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}

class UserDetailsData {
  int? id;
  String? act;
  Form? formData;
  String? createdAt;
  String? updatedAt;

  UserDetailsData({
    this.id,
    this.act,
    this.formData,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) => UserDetailsData(
        id: json["id"],
        act: json["act"],
        formData: json["form_data"] == null ? null : Form.fromJson(json["form_data"]),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "act": act,
        "form_data": formData,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
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
