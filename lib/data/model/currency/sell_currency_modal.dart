// To parse this JSON data, do
//
//     final sellCurrencyModal = sellCurrencyModalFromJson(jsonString);

import 'dart:convert';

import 'package:changa_lab/data/model/global/meassage_model.dart';

SellCurrencyModal sellCurrencyModalFromJson(String str) => SellCurrencyModal.fromJson(json.decode(str));

String sellCurrencyModalToJson(SellCurrencyModal data) => json.encode(data.toJson());

class SellCurrencyModal {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SellCurrencyModal({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory SellCurrencyModal.fromJson(Map<String, dynamic> json) => SellCurrencyModal(
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
  List<SellCurrency>? currencies;
  String? imagePath;

  Data({
    this.currencies,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currencies: json["currencies"] == null ? [] : List<SellCurrency>.from(json["currencies"]!.map((x) => SellCurrency.fromJson(x))),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "currencies": currencies == null ? [] : List<dynamic>.from(currencies!.map((x) => x.toJson())),
        "image_path": imagePath,
      };
}

class SellCurrency {
  int? id;
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
  String? image;

  SellCurrency({
    this.id,
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
    this.image,
  });

  factory SellCurrency.fromJson(Map<String, dynamic> json) => SellCurrency(
        id: json["id"],
        name: json["name"].toString(),
        curSym: json["cur_sym"].toString(),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "image": image,
      };
}
