import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/pyschologist_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/helper_methods.dart';

class PsychologistsProvider with ChangeNotifier {
  Future<List<PsychologistList>?> fetchPsychologistsListApi(
      {required BuildContext context}) async {
    final data = await RemoteService().callGetApi(
      url: ePsychologistList,
    );
    if (data != null) {
      final psychologistListResponse =
          PsychologistListModel.fromJson(jsonDecode(data.body));
      log('api call response : ${psychologistListResponse.toJson().toString()}');
      if (context.mounted) {
        if (psychologistListResponse.status == 200) {
        } else if (psychologistListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: psychologistListResponse.message,
              context: context);
        } else if (psychologistListResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: psychologistListResponse.message,
              context: context);
        }
      }
      notifyListeners();
      log(psychologistListResponse.data?.data.toString() ?? 'empty');
      return psychologistListResponse.data?.data;
    }
    return null;
  }
}
