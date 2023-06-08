import 'dart:convert';
import 'dart:developer';

import 'package:expathy/Models/apply_discount_model.dart';
import 'package:expathy/Models/subscription_list_model.dart';
import 'package:expathy/Remote/api_config.dart';
import 'package:flutter/material.dart';

import '../../Remote/remote_service.dart';
import '../../Utils/helper_methods.dart';

class SubscriptionProvider with ChangeNotifier {
  SubscriptionListModel? subscriptionListModel;
  ApplyDiscountModel? applyDiscountModel;
  Plan? plan;
  bool fetchingSubscription = false;
  bool applyingDiscount = false;

  Future<SubscriptionListModel?> fetchSubscriptionListApi(
      {required BuildContext context}) async {
    fetchingSubscription = true;
    notifyListeners();
    final data = await RemoteService().callGetApi(
      url: eSubscriptionList,
    );
    if (data != null) {
      final subscriptionListResponse =
      SubscriptionListModel.fromJson(jsonDecode(data.body));
      log('api call response : ${subscriptionListResponse.toJson()
          .toString()}');
      if (context.mounted) {
        if (subscriptionListResponse.status == 200) {
          subscriptionListModel = subscriptionListResponse;
          plan = subscriptionListModel?.data?.data?[0];
          fetchingSubscription = false;
        } else if (subscriptionListResponse.status == 404) {
          fetchingSubscription = false;
          showSnackBar(
              isSuccess: false,
              message: subscriptionListResponse.message,
              context: context);
        } else if (subscriptionListResponse.status == 400) {
          fetchingSubscription = false;
          showSnackBar(
              isSuccess: false,
              message: subscriptionListResponse.message,
              context: context);
        }
      }
      fetchingSubscription = false;
      notifyListeners();
      return subscriptionListResponse;
    }
    fetchingSubscription = false;
    notifyListeners();
    return null;
  }

  Future<void> filterPlan({required int index}) async {
    plan = subscriptionListModel?.data?.data?[index];
    notifyListeners();
  }

  Future<ApplyDiscountModel?> applyDiscountApi({required BuildContext context,
    required String subscriptionId,
    required String promoCode}) async {
    applyingDiscount = true;
    notifyListeners();
    final data =
    await RemoteService().callPostApi(url: eApplyDiscount, jsonData: {
      "subscription": subscriptionId,
      "promoCode": promoCode,
    });
    if (data != null) {
      final applyDiscountResponse =
      ApplyDiscountModel.fromJson(jsonDecode(data.body));
      log('api call response : ${applyDiscountResponse.toJson().toString()}');
      if (context.mounted) {
        if (applyDiscountResponse.status == 200) {
          applyDiscountModel = applyDiscountResponse;
          applyingDiscount = false;
          showSnackBar(
              isSuccess: true,
              message: applyDiscountResponse.message,
              context: context);
        } else if (applyDiscountResponse.status == 404) {
          applyingDiscount = false;
          showSnackBar(
              isSuccess: false,
              message: applyDiscountResponse.message,
              context: context);
        } else if (applyDiscountResponse.status == 400) {
          applyingDiscount = false;
          showSnackBar(
              isSuccess: false,
              message: applyDiscountResponse.message,
              context: context);
        }
      }
      applyingDiscount = false;
      notifyListeners();
      return applyDiscountResponse;
    }
    applyingDiscount = false;
    notifyListeners();
    return null;
  }


  Future<void> clearApplyDiscountData() async {
    applyDiscountModel = ApplyDiscountModel();
    notifyListeners();
  }
}
