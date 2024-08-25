import 'package:changa_lab/data/model/global/exchange/send_recive_currency_model.dart';
import 'package:changa_lab/data/model/global/userdata/global_user.dart';
import 'package:changa_lab/data/model/global/userdata/kyc_pending_data.dart';

class GlobalExchangeModel {
  String? id;
  String? userId;
  String? sendCurrencyId;
  String? receiveCurrencyId;
  String? sendingAmount;
  String? receivingAmount;
  String? discountAmount;
  String? sendingCharge;
  String? receivingCharge;
  Charge? charge;
  String? buyRate;
  String? sellRate;
  String? refundAmount;
  String? status;
  String? formattedExchangeId;

  String? automaticPaymentStatus;
  String? walletId;
  String? formattedWalletId;
  String? walletAddress;

  String? walletAddressName;
  String? exchangeId;
  String? userProof;
  String? adminTrxNo;
  String? adminFeedback;
  List<KycPendingData>? userData;
  List<TransactionProofData>? transactionProofData;
  String? plafrom;
  String? createdAt;
  String? updatedAt;
  SendReciveCurrencyModel? sendCurrency;
  SendReciveCurrencyModel? receivedCurrency;
  GlobalUser? user;

  GlobalExchangeModel({
    this.id,
    this.userId,
    this.sendCurrencyId,
    this.receiveCurrencyId,
    this.sendingAmount,
    this.receivingAmount,
    this.discountAmount,
    this.sendingCharge,
    this.receivingCharge,
    this.charge,
    this.buyRate,
    this.sellRate,
    this.refundAmount,
    this.status,
    this.formattedExchangeId,
    this.automaticPaymentStatus,
    this.walletId,
    this.formattedWalletId,
    this.walletAddress,
    this.walletAddressName,
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
    this.user,
  });

  factory GlobalExchangeModel.fromJson(Map<String, dynamic> json) => GlobalExchangeModel(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"].toString(),
        receivingAmount: json["receiving_amount"].toString(),
        discountAmount: json["discount_amount"].toString(),
        sendingCharge: json["sending_charge"].toString(),
        receivingCharge: json["receiving_charge"].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        buyRate: json["buy_rate"].toString(),
        sellRate: json["sell_rate"].toString(),
        refundAmount: json["refund_amount"].toString(),
        status: json["status"].toString(),
        formattedExchangeId: json["formatted_exchange_id"] ?? '',
        automaticPaymentStatus: json["automatic_payment_status"].toString(),
        walletId: json["wallet_id"].toString(),
        formattedWalletId: json["formatted_wallet_id"].toString(),

        walletAddress: json["wallet_address"].toString(),
        walletAddressName: json["wallet_address_nick_name"].toString(),
        exchangeId: json["exchange_id"].toString(),
        userProof: json["user_proof"].toString(),
        adminTrxNo: json["admin_trx_no"].toString(),
        adminFeedback: json["admin_feedback"].toString(),
        // userData: json["user_data"] == null ? [] : List<KycPendingData>.from(json["user_data"]!.map((x) => x)),
        transactionProofData: json["transaction_proof_data"] == null ? [] : List<TransactionProofData>.from(json["transaction_proof_data"]!.map((x) => TransactionProofData.fromJson(x))),
        plafrom: json["plafrom"].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
        sendCurrency: json["send_currency"] == null ? null : SendReciveCurrencyModel.fromJson(json["send_currency"]),
        receivedCurrency: json["received_currency"] == null ? null : SendReciveCurrencyModel.fromJson(json["received_currency"]),
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
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
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x)),
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
        fixedCharge: json["fixed_charge"].toString(),
        percentCharge: json["percent_charge"].toString(),
        percentAmount: json["percent_amount"].toString(),
        totalCharge: json["total_charge"].toString(),
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
        name: json["name"],
        type: json["type"] != null ? json["type"].toString() : '',
        value: json["value"] != null ? json["value"].toString() : '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}

class TicketCount {
  String? answer;
  String? reapply;

  TicketCount({
    this.answer,
    this.reapply,
  });

  factory TicketCount.fromJson(Map<String, dynamic> json) => TicketCount(
        answer: json["answer"] != null ? json["answer"].toString() : '0',
        reapply: json["reapply"] != null ? json["reapply"].toString() : '0',
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "reapply": reapply,
      };
}
