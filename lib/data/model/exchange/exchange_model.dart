// To parse this JSON data, do
//
//     final exchange = exchangeFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:changa_lab/data/model/exchange/confirm_exchange_modal.dart';
import 'package:changa_lab/data/model/global/meassage_model.dart';

Exchange exchangeFromJson(String str) => Exchange.fromJson(json.decode(str));

String exchangeToJson(Exchange data) => json.encode(data.toJson());

class Exchange {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  Exchange({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
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
  ExchangeModel? exchange;
  String? imagePath;
  String? pdfPath;

  Data({
    this.exchange,
    this.imagePath,
    this.pdfPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exchange: json["exchange"] == null ? null : ExchangeModel.fromJson(json["exchange"]),
        imagePath: json["image_path"],
        pdfPath: json["pdfPath"],
      );

  Map<String, dynamic> toJson() => {
        "exchange": exchange?.toJson(),
        "image_path": imagePath,
      };
}

class ExchangeModel {
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
  Form? userData;
  List<TransactionProofData>? transactionProofData;
  String? plafrom;
  String? createdAt;
  String? updatedAt;
  DCurrency? sendCurrency;
  DCurrency? receivedCurrency;

  ExchangeModel({
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
    this.sendCurrency,
    this.receivedCurrency,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) => ExchangeModel(
        id: json["id"],
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"].toString(),
        receivingAmount: json["receiving_amount"].toString(),
        sendingCharge: json["sending_charge"].toString(),
        receivingCharge: json["receiving_charge"].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        buyRate: json["buy_rate"] !=null? json["buy_rate"].toString() : '',
        sellRate: json["sell_rate"] !=null? json["sell_rate"].toString() : '',
        refundAmount: json["refund_amount"] !=null? json["refund_amount"].toString() : '',
        status: json["status"].toString(),
        automaticPaymentStatus: json["automatic_payment_status"].toString(),
        walletId: json["wallet_id"].toString(),
        exchangeId: json["exchange_id"].toString(),
        userProof: json["user_proof"].toString(),
        adminTrxNo: json["admin_trx_no"].toString(),
        adminFeedback: json["admin_feedback"].toString(),
        userData: json["form_data"] == null ? null : Form.fromJson(json["user_data"]),
        transactionProofData: json["transaction_proof_data"] == null ? [] : List<TransactionProofData>.from(json["transaction_proof_data"]!.map((x) => TransactionProofData.fromJson(x))),
        plafrom: json["plafrom"].toString(),
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
        "user_data": userData,
        "transaction_proof_data": transactionProofData == null ? [] : List<dynamic>.from(transactionProofData!.map((x) => x.toJson())),
        "plafrom": plafrom,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "send_currency": sendCurrency?.toJson(),
        "received_currency": receivedCurrency?.toJson(),
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
