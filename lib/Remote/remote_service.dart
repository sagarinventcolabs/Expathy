import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';
import 'app_exceptions.dart';

class RemoteService {
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppStrings.token);
    if (token == '') {
      return null;
    } else {
      return token;
    }
  }

  Future<http.Response?> callGetApi({
    required String url,
  }) async {
    http.Response? responseJson;
    try {
      var authToken = await getAuthToken();
      final response =
          await http.get(Uri.parse('$BASE_URL$url'), headers: <String, String>{
        'Content-Type': 'application/json',
        'device_type': 'mobile',
        'Authorization': 'Bearer ${authToken ?? ""}',
      });
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message: exception.message.toString());
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message:
              '${exceptionData['message'].toString()} ${exceptionData['status'].toString()}');
    }
    log('Api Url : $BASE_URL$url');
    return responseJson;
  }

  Future<http.Response?> callPostApi({
    required String url,
    required Map<String, dynamic> jsonData,
  }) async {
    http.Response? responseJson;
    try {
      var authToken = await getAuthToken();
      final response = await http.post(Uri.parse('$BASE_URL$url'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'device_type': 'mobile',
            'Authorization': 'Bearer ${authToken ?? ""}',
          },
          body: jsonEncode(jsonData));
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message: exception.message.toString());
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message:
              '${exceptionData['message'].toString()} ${exceptionData['status'].toString()}');
    }
    log('Api Url : $BASE_URL$url');
    log('Api request : $jsonData');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return response;
      case 409:
        return response;
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
