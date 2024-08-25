// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

import '../global/meassage_model.dart';

ReferralModel refferalResponseModelFromJson(String str) => ReferralModel.fromJson(json.decode(str));

String refferalResponseModelToJson(ReferralModel data) => json.encode(data.toJson());

class ReferralModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    ReferralModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
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
    Commission? commission;
    User? user;
    String? maxLevel;

    Data({
        this.affiliateLink,
        this.commission,
        this.user,
        this.maxLevel,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        affiliateLink: json["affiliate_link"].toString(),
        commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        maxLevel: json["max_level"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "affiliate_link": affiliateLink,
        "commission": commission?.toJson(),
        "user": user?.toJson(),
        "max_level": maxLevel,
    };
}

class Commission {
    String? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    String? from;
    String? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    String? perPage;
    String? prevPageUrl;
    String? to;
    String? total;

    Commission({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        currentPage: json["current_page"].toString(),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"].toString(),
        from: json["from"].toString(),
        lastPage: json["last_page"].toString(),
        lastPageUrl: json["last_page_url"].toString(),
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"].toString(),
        path: json["path"].toString(),
        perPage: json["per_page"].toString(),
        prevPageUrl: json["prev_page_url"].toString(),
        to: json["to"].toString(),
        total: json["total"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? id;
    String? userId;
    String? who;
    String? level;
    String? amount;
    String? mainAmo;
    String? title;
    String? trx;
    String? createdAt;
    String? updatedAt;
    User? userFrom;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"].toString(),
        who: json["who"].toString(),
        level: json["level"].toString(),
        amount: json["amount"].toString(),
        mainAmo: json["main_amo"].toString(),
        title: json["title"].toString(),
        trx: json["trx"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"] .toString(),
        userFrom: json["user_from"] == null ? null : User.fromJson(json["user_from"]),
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

class User {
    int? id;
    String? firstname;
    String? lastname;
    String? username;
    String? email;
    String? dialCode;
    String? state;
    String? city;
    String? zip;
    String? mobile;
    String? refBy;
    String? image;
    String? address;
    String? status;
    String? kycRejectionReason;
    String? kv;
    String? ev;
    String? sv;
    String? profileComplete;
    String? verCodeSendAt;
    String? ts;
    String? tv;
    String? tsc;
    String? banReason;
    String? loginBy;
    String? provider;
    String? providerId;
    String? createdAt;
    String? updatedAt;
    List<User>? allReferrals;
    User? referrer;

    User({
        this.id,
        this.firstname,
        this.lastname,
        this.username,
        this.email,
        this.dialCode,
        this.state,
        this.city,
        this.zip,
        this.mobile,
        this.refBy,
        this.image,
        this.address,
        this.status,
        this.kycRejectionReason,
        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        this.verCodeSendAt,
        this.ts,
        this.tv,
        this.tsc,
        this.banReason,
        this.loginBy,
        this.provider,
        this.providerId,
        this.createdAt,
        this.updatedAt,
        this.allReferrals,
        this.referrer,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"].toString(),
        lastname: json["lastname"].toString(),
        username: json["username"].toString(),
        email: json["email"].toString(),
        dialCode: json["dial_code"].toString(),
        state: json["state"].toString(),
        city: json["city"].toString(),
        zip: json["zip"].toString(),
        mobile: json["mobile"].toString(),
        refBy: json["ref_by"].toString(),
        image: json["image"].toString(),
        address: json["address"].toString(),
        status: json["status"].toString(),
        kycRejectionReason: json["kyc_rejection_reason"].toString(),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCodeSendAt: json["ver_code_send_at"].toString(),
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        loginBy: json["login_by"].toString(),
        provider: json["provider"].toString(),
        providerId: json["provider_id"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        allReferrals: json["all_referrals"] == null ? [] : List<User>.from(json["all_referrals"]!.map((x) => User.fromJson(x))),
        referrer: json["referrer"] == null ? null : User.fromJson(json["referrer"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "dial_code": dialCode,
        "state": state,
        "city": city,
        "zip": zip,
        "mobile": mobile,
        "ref_by": refBy,
        "image": image,
        "address": address,
        "status": status,
        "kyc_rejection_reason": kycRejectionReason,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt,
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "login_by": loginBy,
        "provider": provider,
        "provider_id": providerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "all_referrals": allReferrals == null ? [] : List<dynamic>.from(allReferrals!.map((x) => x.toJson())),
        "referrer": referrer?.toJson(),
    };
}



class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"].toString(),
        label: json["label"].toString(),
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

