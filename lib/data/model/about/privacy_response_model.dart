// To parse this JSON data, do
//
//     final privacyResponseModel = privacyResponseModelFromJson(jsonString);

import 'dart:convert';

import '../global/meassage_model.dart';

PrivacyResponseModel privacyResponseModelFromJson(String str) => PrivacyResponseModel.fromJson(json.decode(str));

String privacyResponseModelToJson(PrivacyResponseModel data) => json.encode(data.toJson());

class PrivacyResponseModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    PrivacyResponseModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory PrivacyResponseModel.fromJson(Map<String, dynamic> json) => PrivacyResponseModel(
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
    List<Policy>? policies;

    Data({
        this.policies,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        policies: json["policies"] == null ? [] : List<Policy>.from(json["policies"]!.map((x) => Policy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "policies": policies == null ? [] : List<dynamic>.from(policies!.map((x) => x.toJson())),
    };
}

class Policy {
    int? id;
    String? dataKeys;
    DataValues? dataValues;
    String? seoContent;
    String? tempname;
    String? slug;
    String? createdAt;
    String? updatedAt;

    Policy({
        this.id,
        this.dataKeys,
        this.dataValues,
        this.seoContent,
        this.tempname,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        id: json["id"],
        dataKeys: json["data_keys"].toString(),
        dataValues: json["data_values"] == null ? null : DataValues.fromJson(json["data_values"]),
        seoContent: json["seo_content"].toString(),
        tempname: json["tempname"].toString(),
        slug: json["slug"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"] .toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data_keys": dataKeys,
        "data_values": dataValues?.toJson(),
        "seo_content": seoContent,
        "tempname": tempname,
        "slug": slug,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class DataValues {
    String? title;
    String? description;

    DataValues({
        this.title,
        this.description,
    });

    factory DataValues.fromJson(Map<String, dynamic> json) => DataValues(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}

