import 'dart:convert';
import 'dart:developer';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/exchange/exchange_list_model.dart';
import 'package:changa_lab/data/model/exchange/exchange_model.dart';
import 'package:changa_lab/data/model/exchange/track_exchagne_response_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/view/components/file_download_dialog/download_dialogue.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeController extends GetxController {
  ExchangeRepo exchangeRepo;

  ExchangeController({required this.exchangeRepo});

  bool isLoading = false;

  List<LatestExchange> latestExchanges = [];

  String imageurl = '';
  int page = 0;
  int index = 0;
  String? nextPageUrl = '';

  ExchangeModel exchangeDetails = ExchangeModel();
  String? dawnloadURL = '';
  TrackExchange traceExchange = TrackExchange();
  TextEditingController trackExchangeController = TextEditingController();

  void changeIndex(int id) {
    index = id;
    update();
  }

  Future<void> getAllExchanges() async {
    if (page <= 1) {
      isLoading = true;
      update();
    }
    page = page + 1;
    update();

    ResponseModel responseModel = await exchangeRepo.getAllExchanges(page);
    if (responseModel.statusCode == 200) {
      LatestExchangeResponseModel model = LatestExchangeResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      if (model.status == MyStrings.success) {
        nextPageUrl = model.data!.exchanges!.nextPageUrl ?? '';
        List<LatestExchange>? tempData = model.data!.exchanges?.data;
        imageurl = model.data?.imagePath ?? '';

        if (tempData != null) {
          latestExchanges = latestExchanges + tempData;
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }

// get exchange by id -> details Exchange
  Future<void> getExchangeByID(int id) async {
    isLoading = true;
    dawnloadURL = null;
    update();
    ResponseModel responseModel =
        await exchangeRepo.getExchangeById(id.toString());
    if (responseModel.statusCode == 200) {
      Exchange model =
          Exchange.fromJson(jsonDecode(responseModel.responseJson));
      ExchangeModel? data = model.data?.exchange;
      if (model.status == MyStrings.success) {
        if (data != null) {
          exchangeDetails = data;
          dawnloadURL = model.data?.pdfPath;
        }
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
      Get.back();
    }
    isLoading = false;
    update();
  }

// track exchange // 16
  Future<void> trackExchange(String exchangeID) async {
    isLoading = true;

    update();
    ResponseModel responseModel = await exchangeRepo.trackExchange(exchangeID);
    if (responseModel.statusCode == 200) {
      TrackExchangeResponseModel model = TrackExchangeResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );
      log(model.status.toString());
      TrackExchange? data = model.data?.exchange;
      if (model.status == MyStrings.success) {
        traceExchange = TrackExchange();
        if (data != null) {
          traceExchange = data;
          Get.toNamed(RouteHelper.exchangeTrack);
        }
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
    }
    isLoading = false;
    update();
  }

// dawnload api
  Future<void> downloadAttachment(String url, BuildContext context) async {
    if (url.isNotEmpty && url != 'null') {
      showDialog(
        context: context,
        builder: (context) => DownloadingDialog(
          isPdf: true,
          isImage: false,
          url: url,
          fileName: exchangeDetails.exchangeId.toString(),
        ),
      );

      update();
    }
  }

  bool hasNext() {
    return nextPageUrl != null &&
            nextPageUrl!.isNotEmpty &&
            nextPageUrl != 'null'
        ? true
        : false;
  }
}
