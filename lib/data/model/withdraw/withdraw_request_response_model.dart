// To parse this JSON data, do
//
//     final withdrawCurrencyResponse = withdrawCurrencyResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:changa_lab/data/model/global/userdata/global_user_data.dart';
import 'package:flutter/foundation.dart';

import '../global/meassage_model.dart';

WithdrawCurrencyResponse withdrawCurrencyResponseFromJson(String str) => WithdrawCurrencyResponse.fromJson(json.decode(str));

String withdrawCurrencyResponseToJson(WithdrawCurrencyResponse data) => json.encode(data.toJson());

class WithdrawCurrencyResponse {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  WithdrawCurrencyResponse({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawCurrencyResponse.fromJson(Map<String, dynamic> json) => WithdrawCurrencyResponse(
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
  List<Currency>? currencies;

  Data({
    this.currencies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currencies: json["currencies"] == null ? [] : List<Currency>.from(json["currencies"]!.map((x) => Currency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currencies": currencies == null ? [] : List<dynamic>.from(currencies!.map((x) => x.toJson())),
      };
}

class Currency {
  int? id;
  String? gatewayId;
  String? name;
  String? curSym;
  String? conversionRate;
  String? percentDecrease;
  String? percentIncrease;
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
  GlobalUserKycData? userDetailsData;

  Currency({
    this.id,
    this.gatewayId,
    this.name,
    this.curSym,
    this.conversionRate,
    this.percentDecrease,
    this.percentIncrease,
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
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json["id"],
      gatewayId: json["gateway_id"].toString(),
      name: json["name"].toString(),
      curSym: json["cur_sym"].toString(),
      conversionRate: json["conversion_rate"].toString(),
      percentDecrease: json["percent_decrease"].toString(),
      percentIncrease: json["percent_increase"].toString(),
      sellAt: json["sell_at"].toString(),
      buyAt: json["buy_at"].toString(),
      fixedChargeForSell: json["fixed_charge_for_sell"].toString(),
      percentChargeForSell: json["percent_charge_for_sell"].toString(),
      fixedChargeForBuy: json["fixed_charge_for_buy"].toString(),
      percentChargeForBuy: json["percent_charge_for_buy"].toString(),
      reserve: json["reserve"].toString(),
      minimumLimitForSell: json["minimum_limit_for_sell"].toString(),
      maximumLimitForSell: json["maximum_limit_for_sell"].toString(),
      minimumLimitForBuy: json["minimum_limit_for_buy"].toString(),
      maximumLimitForBuy: json["maximum_limit_for_buy"].toString(),
      userDetailFormId: json["user_detail_form_id"].toString(),
      instruction: json["instruction"].toString(),
      image: json["image"].toString(),
      availableForSell: json["available_for_sell"].toString(),
      availableForBuy: json["available_for_buy"].toString(),
      showRate: json["show_rate"].toString(),
      status: json["status"].toString(),
      trxProofFormId: json["trx_proof_form_id"].toString(),
      createdAt: json["created_at"].toString(),
      updatedAt: json["updated_at"].toString(),
      userDetailsData: json["user_details_data"] == null ? null : GlobalUserKycData.fromJson(json["user_details_data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gateway_id": gatewayId,
        "name": name,
        "cur_sym": curSym,
        "conversion_rate": conversionRate,
        "percent_decrease": percentDecrease,
        "percent_increase": percentIncrease,
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_details_data": userDetailsData?.toJson(),
      };
}
