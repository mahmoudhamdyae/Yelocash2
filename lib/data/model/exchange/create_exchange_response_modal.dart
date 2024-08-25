// To parse this JSON data, do
//
//     final createExchangeModal = createExchangeModalFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:changa_lab/data/model/global/meassage_model.dart';

CreateExchangeModal createExchangeModalFromJson(String str) => CreateExchangeModal.fromJson(json.decode(str));

String createExchangeModalToJson(CreateExchangeModal data) => json.encode(data.toJson());

class CreateExchangeModal {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CreateExchangeModal({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CreateExchangeModal.fromJson(Map<String, dynamic> json) => CreateExchangeModal(
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
  CreateExchangeResponse? exchange;

  Data({
    this.exchange,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exchange: json["exchange"] == null ? null : CreateExchangeResponse.fromJson(json["exchange"]),
      );

  Map<String, dynamic> toJson() => {
        "exchange": exchange?.toJson(),
      };
}

class CreateExchangeResponse {
  String? userId;
  String? sendCurrencyId;
  String? receiveCurrencyId;
  String? sendingAmount;
  String? sendingCharge;
  String? receivingAmount;
  String? receivingCharge;
  String? sellRate;
  String? buyRate;
  String? exchangeId;
  Charge? charge;
  String? updatedAt;
  String? createdAt;
  String? id;

  CreateExchangeResponse({
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.sendingAmount,
    this.sendingCharge,
    this.receivingAmount,
    this.receivingCharge,
    this.sellRate,
    this.buyRate,
    this.exchangeId,
    this.charge,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory CreateExchangeResponse.fromJson(Map<String, dynamic> json) => CreateExchangeResponse(
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"] == null ? '' : json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"] == null ? '' : json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"] == null ? '' : json["sending_amount"].toString(),
        sendingCharge: json["sending_charge"] == null ? '' : json["sending_charge"]?.toString(),
        receivingAmount: json["receiving_amount"] == null ? '' : json["receiving_amount"]?.toString(),
        receivingCharge: json["receiving_charge"] == null ? '' : json["receiving_charge"]?.toString(),
        sellRate: json["sell_rate"] != null ? json["sell_rate"].toString() : '',
        buyRate: json["buy_rate"] == null ? '' : json["buy_rate"].toString(),
        exchangeId: json["exchange_id"] == null ? '' : json["exchange_id"].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "send_currency_id": sendCurrencyId,
        "receive_currency_id": receiveCurrencyId,
        "sending_amount": sendingAmount,
        "sending_charge": sendingCharge,
        "receiving_amount": receivingAmount,
        "receiving_charge": receivingCharge,
        "sell_rate": sellRate,
        "buy_rate": buyRate,
        "exchange_id": exchangeId,
        "charge": charge?.toJson(),
        "updated_at": updatedAt?.toString(),
        "created_at": createdAt?.toString(),
        "id": id,
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
        fixedCharge: json["fixed_charge"] == null ? null : json['fixed_charge'].toString(),
        percentCharge: json["percent_charge"] == null ? null : json['percent_charge'].toString(),
        percentAmount: json["percent_amount"] == null ? null : json['percent_amount'].toString(),
        totalCharge: json["total_charge"] == null ? null : json['total_charge'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "fixed_charge": fixedCharge,
        "percent_charge": percentCharge,
        "percent_amount": percentAmount,
        "total_charge": totalCharge,
      };
}
