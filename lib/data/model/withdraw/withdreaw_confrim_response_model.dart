// To parse this JSON data, do
//
//     final widthrawNowModel = widthrawNowModelFromJson(jsonString);
// ignore_for_file: prefer_null_aware_operators

import 'package:changa_lab/data/model/global/meassage_model.dart';
import 'dart:convert';

WithdrawNowModel withdrawNowModelFromJson(String str) => WithdrawNowModel.fromJson(json.decode(str));

String withdrawNowModelToJson(WithdrawNowModel data) => json.encode(data.toJson());

class WithdrawNowModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  WithdrawNowModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawNowModel.fromJson(Map<String, dynamic> json) =>
      WithdrawNowModel(
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
  Withdraw? withdraw;

  Data({this.withdraw});

  factory Data.fromJson(Map<String, dynamic> json) => Data(withdraw: json["withdraw"] == null ? null : Withdraw.fromJson(json["withdraw"]));

  Map<String, dynamic> toJson() => {"withdraw": withdraw?.toJson()};
}

class Withdraw {
  String? methodId;
  String? userId;
  String? amount;
  String? currency;
  String? rate;
  String? charge;
  String? finalAmount;
  String? afterCharge;
  String? trx;
  String? status;
  List<WithdrawInformation>? withdrawInformation;
  String? updatedAt;
  String? createdAt;
  int? id;
  Method? method;

  Withdraw({
    this.methodId,
    this.userId,
    this.amount,
    this.currency,
    this.rate,
    this.charge,
    this.finalAmount,
    this.afterCharge,
    this.trx,
    this.status,
    this.withdrawInformation,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.method,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        methodId: json["method_id"].toString(),
        userId: json["user_id"].toString(),
        amount: json["amount"] !=null? json["amount"].toString() : '',
        currency: json["currency"] !=null? json["currency"].toString() : '',
        rate: json["rate"] !=null? json["rate"].toString() : '',
        charge: json["charge"] !=null? json["charge"].toString() : '',
        finalAmount: json["final_amount"] !=null? json["final_amount"].toString() : '',
        afterCharge: json["after_charge"] !=null? json["after_charge"].toString() : '',
        trx: json["trx"].toString(),
        status: json["status"].toString(),
        withdrawInformation: json["withdraw_information"] == null ? [] : List<WithdrawInformation>.from(json["withdraw_information"]!.map((x) => WithdrawInformation.fromJson(x))),
        updatedAt: json["updated_at"] ,
        createdAt: json["created_at"],
        id: json["id"],
        method: json["method"] == null ? null : Method.fromJson(json["method"]),
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "user_id": userId,
        "amount": amount,
        "currency": currency,
        "rate": rate,
        "charge": charge,
        "final_amount": finalAmount,
        "after_charge": afterCharge,
        "trx": trx,
        "status": status,
        "withdraw_information": withdrawInformation == null
            ? []
            : List<dynamic>.from(withdrawInformation!.map((x) => x.toJson())),
        "updated_at": updatedAt?..toString(),
        "created_at": createdAt?.toString(),
        "id": id,
        "method": method?.toJson(),
      };
}

class Method {
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

  Method({
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
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        gatewayId: json["gateway_id"].toString(),
        name: json["name"].toString(),
        curSym: json["cur_sym"] !=null? json["cur_sym"].toString() : '',
        sellAt: json["sell_at"] !=null? json["sell_at"].toString() : '',
        buyAt: json["buy_at"] !=null? json["buy_at"].toString() : '',
        fixedChargeForSell: json["fixed_charge_for_sell"] !=null? json["fixed_charge_for_sell"].toString() : '',
        percentChargeForSell: json["percent_charge_for_sell"] !=null? json["percent_charge_for_sell"].toString() : '',
        fixedChargeForBuy: json["fixed_charge_for_buy"] !=null? json["fixed_charge_for_buy"].toString() : '',
        percentChargeForBuy: json["percent_charge_for_buy"] !=null? json["percent_charge_for_buy"].toString() : '',
        reserve: json["reserve"].toString(),
        minimumLimitForSell: json["minimum_limit_for_sell"] !=null? json["minimum_limit_for_sell"].toString() : '',
        maximumLimitForSell: json["maximum_limit_for_sell"] !=null? json["maximum_limit_for_sell"].toString() : '',
        minimumLimitForBuy: json["minimum_limit_for_buy"] !=null? json["minimum_limit_for_buy"].toString() : '',
        maximumLimitForBuy: json["maximum_limit_for_buy"] !=null? json["maximum_limit_for_buy"].toString() : '',
        userDetailFormId: json["user_detail_form_id"].toString(),
        instruction: json["instruction"].toString(),
        image: json["image"].toString(),
        availableForSell: json["available_for_sell"].toString(),
        availableForBuy: json["available_for_buy"].toString(),
        showRate: json["show_rate"].toString(),
        status: json["status"].toString(),
        trxProofFormId: json["trx_proof_form_id"].toString(),
        createdAt: json["created_at"] ,
        updatedAt: json["updated_at"] ,
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
      };
}

class WithdrawInformation {
  String? name;
  String? type;
  String? value;

  WithdrawInformation({
    this.name,
    this.type,
    this.value,
  });

  factory WithdrawInformation.fromJson(Map<String, dynamic> json) =>
      WithdrawInformation(
        name: json["name"].toString(),
        type: json["type"].toString(),
        value: json["value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}
