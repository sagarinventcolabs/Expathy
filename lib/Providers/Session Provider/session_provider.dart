import 'dart:convert';
import 'dart:developer';

import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/get_session_model.dart';
import 'package:expathy/Models/get_slot_model.dart';
import 'package:flutter/material.dart';

import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/helper_methods.dart';

class SessionProvider with ChangeNotifier {
  GetSlotModel? getSlotData;
  bool gettingSlots = false;
  bool bookingSession = false;
  int? index;

  Future<GetSlotModel?> getSlotListApi(
      {required BuildContext context, required String day}) async {
    gettingSlots = true;
    final data = await RemoteService().callGetApi(
      url: '$eGetSlot/$day',
    );
    if (data != null) {
      final getSlotResponse = GetSlotModel.fromJson(jsonDecode(data.body));
      log('api call response : ${getSlotResponse.toJson().toString()}');
      if (context.mounted) {
        if (getSlotResponse.status == 200) {
          getSlotData = getSlotResponse;
        } else if (getSlotResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: getSlotResponse.message,
              context: context);
        } else if (getSlotResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: getSlotResponse.message,
              context: context);
        }
      }
      gettingSlots = false;
      notifyListeners();
      return getSlotResponse;
    }
    gettingSlots = false;
    notifyListeners();
    return null;
  }

  Future<CommonModel?> bookSessionApi({
    required BuildContext context,
    required String date,
    required String time,
    required String day,
    required String type,
  }) async {
    bookingSession = true;
    notifyListeners();
    final data =
        await RemoteService().callPostApi(url: eBookingSession, jsonData: {
      "date": date,
      "time": time,
      "day": day,
      "type": type,
    });
    if (data != null) {
      final bookingSessionResponse =
          CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${bookingSessionResponse.toJson().toString()}');
      if (context.mounted) {
        if (bookingSessionResponse.status == 200) {
          showSnackBar(
              isSuccess: true,
              message: bookingSessionResponse.message,
              context: context);
        } else if (bookingSessionResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: bookingSessionResponse.message,
              context: context);
        } else if (bookingSessionResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: bookingSessionResponse.message,
              context: context);
        }
      }
      bookingSession = false;
      notifyListeners();
      return bookingSessionResponse;
    }
    bookingSession = false;
    notifyListeners();
    return null;
  }

  Future<List<Session>?> getSessionListApi(
      {required BuildContext context, required String type}) async {
    final data = await RemoteService().callGetApi(
      url: '$eGetSessionList/$type',
    );
    if (data != null) {
      final getSessionListResponse =
          GetSessionModel.fromJson(jsonDecode(data.body));
      log('api call response : ${getSessionListResponse.toJson().toString()}');
      if (context.mounted) {
        if (getSessionListResponse.status == 200) {
        } else if (getSessionListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: getSessionListResponse.message,
              context: context);
        } else if (getSessionListResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: getSessionListResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return getSessionListResponse.data?.data;
    }
    return null;
  }

  Future<void> setIndex({required int index}) async {
    this.index = index;
    notifyListeners();
  }
}
