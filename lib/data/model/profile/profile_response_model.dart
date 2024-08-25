// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:changa_lab/data/model/global/userdata/global_user.dart';

import '../global/meassage_model.dart';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    ProfileResponseModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
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
    GlobalUser? user;

    Data({
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}


