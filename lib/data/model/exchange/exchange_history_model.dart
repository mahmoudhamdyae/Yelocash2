// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:changa_lab/data/model/global/meassage_model.dart';

ExchangeHistoryModel exchangeHistoryModelFromJson(String str) => ExchangeHistoryModel.fromJson(json.decode(str));

String exchangeHistoryModelToJson(ExchangeHistoryModel data) => json.encode(data.toJson());

class ExchangeHistoryModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  ExchangeHistoryModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory ExchangeHistoryModel.fromJson(Map<String, dynamic> json) => ExchangeHistoryModel(
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
  Exchanges? exchanges;
  String? imagePath;

  Data({
    this.exchanges,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exchanges: json["exchanges"] == null ? null : Exchanges.fromJson(json["exchanges"]),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "exchanges": exchanges?.toJson(),
        "image_path": imagePath,
      };
}

class Exchanges {
  int? currentPage;
  List<HistoryExchange>? data;

  dynamic nextPageUrl;

  int? total;

  Exchanges({
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Exchanges.fromJson(Map<String, dynamic> json) => Exchanges(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<HistoryExchange>.from(json["data"]!.map((x) => HistoryExchange.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "total": total,
      };
}

class HistoryExchange {
  int? id;
  String? userId;
  String? sendCurrencyId;
  String? receiveCurrencyId;
  String? sendingAmount;
  String? receivingAmount;
  String? sendingCharge;
  String? receivingCharge;
  Charge? charge;
  String? exchangeId;
  String? status;
  DCurrency sendCurrency;
  DCurrency receivedCurrency;
  String? createdAt;
  String? updatedAt;

  HistoryExchange({
    this.id,
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.sendingAmount,
    this.receivingAmount,
    this.sendingCharge,
    this.receivingCharge,
    this.charge,
    this.exchangeId,
    this.status,
    required this.sendCurrency,
    required this.receivedCurrency,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryExchange.fromJson(Map<String, dynamic> json) => HistoryExchange(
        id: json["id"],
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"] == null ? '' : json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"] == null ? '' : json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"] == null ? '' : json["sending_amount"].toString(),
        receivingAmount: json["receiving_amount"] == null ? '' : json["receiving_amount"].toString(),
        sendingCharge: json["sending_charge"] == null ? '' : json['sending_charge'].toString(),
        receivingCharge: json["receiving_charge"] == null ? '' : json['receiving_charge'].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        exchangeId: json["exchange_id"] == null ? '' : json['exchange_id'].toString(),
        status: json["status"].toString(),
        sendCurrency: DCurrency.fromJson(json["send_currency"]),
        receivedCurrency: DCurrency.fromJson(json["received_currency"]),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
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
        "exchange_id": exchangeId,
        "status": status,
        "send_currency": sendCurrency.toJson(),
        "received_currency": receivedCurrency.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
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

class DCurrency {
  int? id;
  String? name;
  String? image;
  String? curSym;

  DCurrency({
    this.id,
    this.name,
    this.image,
    this.curSym,
  });

  factory DCurrency.fromJson(Map<String, dynamic> json) => DCurrency(
        id: json["id"],
        name: json["name"] != null ? json["name"].toString() : '',
        curSym: json["cur_sym"] != null ? json["cur_sym"].toString() : '',
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "cur_sym": curSym,
      };
}

