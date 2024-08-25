import 'dart:convert';

import 'package:changa_lab/data/model/global/meassage_model.dart';

WithdrawHistoryResponseModel withdrawHistoryResponseModelFromJson(String str) =>
    WithdrawHistoryResponseModel.fromJson(json.decode(str));

String withdrawHistoryResponseModelToJson(WithdrawHistoryResponseModel data) =>
    json.encode(data.toJson());

class WithdrawHistoryResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  WithdrawHistoryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      WithdrawHistoryResponseModel(
        remark: json["remark"],
        status: json["status"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
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
  Withdrawals? withdrawals;

  Data({
    this.withdrawals,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        withdrawals: json["withdrawals"] == null
            ? null
            : Withdrawals.fromJson(json["withdrawals"]),
      );

  Map<String, dynamic> toJson() => {
        "withdrawals": withdrawals?.toJson(),
      };
}

class Withdrawals {
  List<WithdrawListModel>? data;
  dynamic nextPageUrl;

  Withdrawals({
    this.data,
    this.nextPageUrl
  });

  factory Withdrawals.fromJson(Map<String, dynamic> json) => Withdrawals(
        data: json["data"] == null
            ? []
            : List<WithdrawListModel>.from(
                json["data"]!.map((x) => WithdrawListModel.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WithdrawListModel {
  int? id;
  String? methodId;
  String? userId;
  String? amount;
  String? currency;
  String? rate;
  String? charge;
  String? trx;
  String? finalAmount;
  String? afterCharge;
  List<WithdrawInformation>? withdrawInformation;
  String? status;
  dynamic adminFeedback;
  String? createdAt;
  String? updatedAt;
  Method? method;

  WithdrawListModel({
    this.id,
    this.methodId,
    this.userId,
    this.amount,
    this.currency,
    this.rate,
    this.charge,
    this.trx,
    this.finalAmount,
    this.afterCharge,
    this.withdrawInformation,
    this.status,
    this.adminFeedback,
    this.createdAt,
    this.updatedAt,
    this.method,
  });

  factory WithdrawListModel.fromJson(Map<String, dynamic> json) =>
      WithdrawListModel(
        id: json["id"],
        methodId: json["method_id"].toString(),
        userId: json["user_id"].toString(),
        amount: json["amount"] !=null? json["amount"].toString() : '',
        currency: json["currency"].toString(),
        rate: json["rate"] !=null? json["rate"].toString() : '',
        charge: json["charge"] !=null? json["charge"].toString() : '',
        trx: json["trx"].toString(),
        finalAmount: json["final_amount"] !=null?  json["final_amount"].toString() : '',
        afterCharge: json["after_charge"] !=null?  json["final_amount"].toString() : '',
        withdrawInformation: json["withdraw_information"] == null
            ? []
            : List<WithdrawInformation>.from(json["withdraw_information"]
                .map((x) => WithdrawInformation.fromJson(x))),
        status: json["status"].toString(),
        adminFeedback: json["admin_feedback"].toString(),
        createdAt:
            json["created_at"] == null ? '' : json["created_at"].toString(),
        updatedAt:
            json["updated_at"] == null ? '' : json["updated_at"].toString(),
        method: json["method"] == null ? null : Method.fromJson(json["method"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_id": methodId,
        "user_id": userId,
        "amount": amount,
        "currency": currency,
        "rate": rate,
        "charge": charge,
        "trx": trx,
        "final_amount": finalAmount,
        "after_charge": afterCharge,
        "withdraw_information": withdrawInformation == null
            ? []
            : List<WithdrawInformation>.from(
                withdrawInformation!.map((x) => x)),
        "status": status,
        "admin_feedback": adminFeedback,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
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
        name: json["name"],
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
        image: json["image"],
        availableForSell: json["available_for_sell"] !=null? json["available_for_sell"].toString() : '',
        availableForBuy: json["available_for_buy"] !=null? json["available_for_buy"].toString() : '',
        showRate: json["show_rate"] !=null? json["show_rate"].toString() : '',
        status: json["status"].toString(),
        trxProofFormId: json["trx_proof_form_id"].toString(),
        createdAt: json["created_at"] == null ? '' : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? '' : json["updated_at"].toString(),
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
        name: json["name"],
        type: json["type"],
        value: json["value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}
