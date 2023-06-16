import 'dart:convert';
import 'dart:developer';

import 'package:expathy/Models/apply_discount_model.dart';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/subscription_list_model.dart';
import 'package:expathy/Remote/api_config.dart';
import 'package:expathy/Utils/navigation_services.dart';
import 'package:flutter/material.dart';

import '../../Remote/remote_service.dart';
import '../../Screens/Payment Screen/payment_successful_screen.dart';
import '../../Utils/helper_methods.dart';

class SubscriptionProvider with ChangeNotifier {
  SubscriptionListModel? subscriptionListModel;
  List<Plan>? subscriptionPlanList = [];
  ApplyDiscountModel? applyDiscountModel;
  Plan? plan;
  bool fetchingSubscription = false;
  bool applyingDiscount = false;
  bool makingPayment = false;
  int? planLength;

  Future<SubscriptionListModel?> fetchSubscriptionListApi(
      {required BuildContext context}) async {
    fetchingSubscription = true;
    final data = await RemoteService().callGetApi(
      url: eSubscriptionList,
    );
    if (data != null) {
      final subscriptionListResponse =
          SubscriptionListModel.fromJson(jsonDecode(data.body));
      log('api call response : ${subscriptionListResponse.toJson().toString()}');
      if (context.mounted) {
        if (subscriptionListResponse.status == 200) {
          /* subscriptionListModel = subscriptionListResponse;
          plan = subscriptionListModel?.data?.data?[0];*/
          subscriptionListModel = subscriptionListResponse;

          subscriptionPlanList = subscriptionListResponse.data?.data;
          plan = subscriptionPlanList?[0];
          planLength = subscriptionListResponse.data?.data?.length;
        } else if (subscriptionListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: subscriptionListResponse.message,
              context: context);
        } else if (subscriptionListResponse.status == 400) {
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
    //plan = subscriptionListModel?.data?.data?[index];
    plan = subscriptionPlanList?[index];
    notifyListeners();
  }

  Future<ApplyDiscountModel?> applyDiscountApi(
      {required BuildContext context,
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

  Future<CommonModel?> paymentApi({
    required BuildContext context,
    required String? subscriptionId,
    String? promoCode,
    required String? totalAmount,
    String? amount,
    String? discountAmount,
  }) async {
    makingPayment = true;
    notifyListeners();
    final data = await RemoteService().callPostApi(url: ePay, jsonData: {
      "subscription": subscriptionId,
      "promoCode": promoCode,
      "totalAmount": totalAmount,
      "amount": amount,
      "discountAmount": discountAmount,
    });
    if (data != null) {
      final paymentApiResponse = CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${paymentApiResponse.toJson().toString()}');
      if (context.mounted) {
        if (paymentApiResponse.status == 200) {
          showSnackBar(
              isSuccess: true,
              message: paymentApiResponse.message,
              context: context);

          NavigationServices.pushReplacement(
              context: context, screen: const PaymentSuccessfulScreen());
        } else if (paymentApiResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: paymentApiResponse.message,
              context: context);
        } else if (paymentApiResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: paymentApiResponse.message,
              context: context);
        }
      }
      makingPayment = false;
      notifyListeners();
      return paymentApiResponse;
    }
    makingPayment = false;
    notifyListeners();
    return null;
  }
}
