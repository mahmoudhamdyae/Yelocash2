import 'dart:convert';
import 'dart:io';

import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/meassage_model.dart';
import 'package:changa_lab/data/model/global/userdata/global_user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

PrevExchangeModal prevExchangeModalFromJson(String str) => PrevExchangeModal.fromJson(json.decode(str));

String prevExchangeModalToJson(PrevExchangeModal data) => json.encode(data.toJson());

class PrevExchangeModal {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PrevExchangeModal({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory PrevExchangeModal.fromJson(Map<String, dynamic> json) => PrevExchangeModal(
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
  PrevExchange? exchange;
  GlobalKYCForm? requiredData;
  String? imagePath;

  Data({
    this.exchange,
    this.requiredData,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exchange: json["exchange"] == null ? null : PrevExchange.fromJson(json["exchange"]),
        requiredData: json["required_data"] == null ? null : GlobalKYCForm.fromJson(json["required_data"]),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "exchange": exchange?.toJson(),
        "required_data": requiredData,
        "image_path": imagePath,
      };
}

class PrevExchange {
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
  SendCurrency? sendCurrency;
  ReceivedCurrency? receivedCurrency;

  PrevExchange({
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
    this.sendCurrency,
    this.receivedCurrency,
  });

  factory PrevExchange.fromJson(Map<String, dynamic> json) => PrevExchange(
        id: json["id"],
        userId: json["user_id"].toString(),
        sendCurrencyId: json["send_currency_id"] == null ? '' : json["send_currency_id"].toString(),
        receiveCurrencyId: json["receive_currency_id"] == '' ? null : json["receive_currency_id"].toString(),
        sendingAmount: json["sending_amount"] == null ? '' : json["sending_amount"].toString(),
        receivingAmount: json["receiving_amount"] == null ? '' : json["receiving_amount"].toString(),
        sendingCharge: json["sending_charge"] == null ? '' : json['sending_charge'].toString(),
        receivingCharge: json["receiving_charge"] == null ? '' : json['receiving_charge'].toString(),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        exchangeId: json["exchange_id"] == null ? null : json['exchange_id'].toString(),
        status: json["status"].toString(),
        sendCurrency: json["send_currency"] == null ? null : SendCurrency.fromJson(json["send_currency"]),
        receivedCurrency: json["received_currency"] == null ? null : ReceivedCurrency.fromJson(json["received_currency"]),
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

class ReceivedCurrency {
  int? id;
  String? name;
  String? image;
  String? curSym;
  String? userDetailFormId;
  GlobalUserKycData? userDetailsData;

  ReceivedCurrency({
    this.id,
    this.name,
    this.image,
    this.curSym,
    this.userDetailFormId,
    this.userDetailsData,
  });

  factory ReceivedCurrency.fromJson(Map<String, dynamic> json) => ReceivedCurrency(
        id: json["id"],
        name: json["name"].toString(),
        curSym: json["cur_sym"].toString(),
        image: json["image"],
        userDetailFormId: json["user_detail_form_id"].toString(),
        userDetailsData: json["user_details_data"] == null ? null : GlobalUserKycData.fromJson(json["user_details_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "cur_sym": curSym,
        "user_detail_form_id": userDetailFormId,
        "user_details_data": userDetailsData,
      };
}

class SendCurrency {
  int? id;
  String? name;
  String? image;
  String? curSym;

  SendCurrency({
    this.id,
    this.name,
    this.image,
    this.curSym,
  });

  factory SendCurrency.fromJson(Map<String, dynamic> json) => SendCurrency(
        id: json["id"],
        name: json["name"].toString(),
        curSym: json["cur_sym"].toString(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "cur_sym": curSym,
      };
}

// class UserDetailsData {
//   int? id;
//   String? act;
//   Form? formData;
//   String? createdAt;
//   String? updatedAt;

//   UserDetailsData({
//     this.id,
//     this.act,
//     this.formData,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory UserDetailsData.fromJson(Map<String, dynamic> json) => UserDetailsData(
//         id: json["id"],
//         act: json["act"].toString(),
//         formData: json["form_data"] == null ? null : Form.fromJson(json["form_data"]),
//         createdAt: json["created_at"] == null ? '' : json["created_at"].toString(),
//         updatedAt: json["updated_at"] == null ? '' : json["updated_at"].toString(),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "act": act,
//         "form_data": formData,
//         "created_at": createdAt?.toString(),
//         "updated_at": updatedAt?.toString(),
//       };
// }

// class Form {
//   Form({List<FormModel>? list}) {
//     _list = list;
//   }

//   List<FormModel>? _list = [];
//   List<FormModel>? get list => _list;

//   Form.fromJson(dynamic json) {
//     var map = Map.from(json).map((key, value) => MapEntry(key, value));
//     try {
//       List<FormModel>? list = map.entries
//           .map(
//             (e) => FormModel(e.value['name'], e.value['label'], e.value['is_required'], e.value['instruction'], e.value['extensions'], (e.value['options'] as List).map((e) => e as String).toList(), e.value['type'], ''),
//           )
//           .toList();
//       print("object${map.entries}");
//       if (list.isNotEmpty) {
//         list.removeWhere((element) => element.toString().isEmpty);
//         _list?.addAll(list);
//       }
//       _list;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     }
//   }
// }

// class FormModel {
//   String? name;
//   String? label;
//   String? isRequired;
//   String? instruction;
//   String? extensions;
//   List<String>? options;
//   String? type;
//   dynamic selectedValue;
//   TextEditingController? textEditingController;
//   File? imageFile;
//   List<String>? cbSelected;
//   // Added an optional parameter to initialize the textEditingController
//   FormModel(this.name, this.label, this.isRequired, this.instruction, this.extensions, this.options, this.type, this.selectedValue, {this.cbSelected, this.imageFile, this.textEditingController}) {
//     // Initialize textEditingController if not provided
//     textEditingController ??= TextEditingController();
//   }
// }
