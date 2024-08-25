class SendReciveCurrencyModel {
  String? id;
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
  String? qrCodeImage;
  String? availableForSell;
  String? availableForBuy;
  String? showRate;
  String? status;
  String? trxProofFormId;
  String? walletAddress;
  String? walletAddressNickName;
  String? instructionText;
  String? sellKycRequired;
  String? buyKycRequired;
  String? addressCopiable;
  String? createdAt;
  String? updatedAt;
  String? formatWalletAddress;
  String? qrCodeImageWithUrl;

  SendReciveCurrencyModel({
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
    this.qrCodeImage,
    this.availableForSell,
    this.availableForBuy,
    this.showRate,
    this.status,
    this.trxProofFormId,
    this.walletAddress,
    this.walletAddressNickName,
    this.instructionText,
    this.sellKycRequired,
    this.buyKycRequired,
    this.addressCopiable,
    this.createdAt,
    this.updatedAt,
    this.formatWalletAddress,
    this.qrCodeImageWithUrl,
  });

  factory SendReciveCurrencyModel.fromJson(Map<String, dynamic> json) => SendReciveCurrencyModel(
        id: json["id"].toString(),
        gatewayId: json["gateway_id"].toString(),
        name: json["name"].toString(),
        curSym: json["cur_sym"].toString(),
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
        qrCodeImage: json["qr_code_image"].toString(),
        availableForSell: json["available_for_sell"].toString(),
        availableForBuy: json["available_for_buy"].toString(),
        showRate: json["show_rate"].toString(),
        status: json["status"].toString(),
        trxProofFormId: json["trx_proof_form_id"].toString(),
        walletAddress: json["wallet_address"].toString(),
        walletAddressNickName: json["wallet_address_nick_name"].toString(),
        instructionText: json["instruction_text"].toString(),
        sellKycRequired: json["sell_kyc_required"].toString(),
        buyKycRequired: json["buy_kyc_required"].toString(),
        addressCopiable: json["address_copiable"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        qrCodeImageWithUrl: json["qr_code_image_with_url"].toString(),
        formatWalletAddress: json["formatted_wallet_address"].toString(),
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
        "qr_code_image": qrCodeImage,
        "available_for_sell": availableForSell,
        "available_for_buy": availableForBuy,
        "show_rate": showRate,
        "status": status,
        "trx_proof_form_id": trxProofFormId,
        "wallet_address": walletAddress,
        "wallet_address_nick_name": walletAddressNickName,
        "instruction_text": instructionText,
        "sell_kyc_required": sellKycRequired,
        "buy_kyc_required": buyKycRequired,
        "address_copiable": addressCopiable,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
