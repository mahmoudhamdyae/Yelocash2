

import 'dart:convert';

import 'package:changa_lab/data/model/global/meassage_model.dart';
import 'package:changa_lab/data/model/global/userdata/global_user.dart';

CommissionLogModel commissionLogModelFromJson(String str) => CommissionLogModel.fromJson(json.decode(str));

String commissionLogModelToJson(CommissionLogModel data) => json.encode(data.toJson());

class CommissionLogModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CommissionLogModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CommissionLogModel.fromJson(Map<String, dynamic> json) => CommissionLogModel(
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
  String? affiliateLink;
  CommissionLog? commission;

  Data({
    this.affiliateLink,
    this.commission,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        affiliateLink: json["affiliate_link"],
        commission: json["commission"] == null ? null : CommissionLog.fromJson(json["commission"]),
      );

  Map<String, dynamic> toJson() => {
        "affiliate_link": affiliateLink,
        "commission": commission?.toJson(),
      };
}

class CommissionLog {
  List<Commission>? data;
  dynamic nextPageUrl;

  CommissionLog({
    this.data,
    this.nextPageUrl,
  });

  factory CommissionLog.fromJson(Map<String, dynamic> json) => CommissionLog(
        data: json["data"] == null ? [] : List<Commission>.from(json["data"]!.map((x) => Commission.fromJson(x))),
        nextPageUrl: json["next_page_url"]
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl
      };
}

class Commission {
  int? id;
  String? userId;
  String? who;
  String? level;
  String? amount;
  String? mainAmo;
  String? title;
  String? trx;
  dynamic createdAt;
  dynamic updatedAt;
  GlobalUser? userFrom;

  Commission({
    this.id,
    this.userId,
    this.who,
    this.level,
    this.amount,
    this.mainAmo,
    this.title,
    this.trx,
    this.createdAt,
    this.updatedAt,
    this.userFrom,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        id: json["id"],
        userId: json["user_id"] != null ? json["user_id"].toString() : '',
        who: json["who"] != null ? json["who"].toString() : '',
        level: json["level"] != null ? json["level"].toString() : '',
        amount: json["amount"] != null ? json["amount"].toString() : '',
        mainAmo: json["main_amo"] != null ? json["main_amo"].toString() : '',
        title: json["title"].toString(),
        trx: json["trx"] != null ? json["trx"].toString() : '',
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        userFrom: json["user_from"] == null ? null : GlobalUser.fromJson(json["user_from"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "who": who,
        "level": level,
        "amount": amount,
        "main_amo": mainAmo,
        "title": title,
        "trx": trx,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_from": userFrom?.toJson(),
      };
}

