import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'app_exceptions.dart';

class RemoteService {
  Future<http.Response?> callGetApi({
    required String url,
  }) async {
    http.Response? responseJson;
    try {
      // var authToken = await getAuthToken();
      final response =
          await http.get(Uri.parse('$BASE_URL$url'), headers: <String, String>{
        'Content-Type': 'application/json',
        'device_type': 'mobile',
        // 'x-access-token': authToken ?? "",
      });
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      log(e.toString());
    }
    log(responseJson!.body.toString());
    return responseJson;
  }

  Future<http.Response?> callPostApi({
    required String url,
    required Map<String, dynamic> jsonData,
  }) async {
    http.Response? responseJson;
    try {
      //var authToken = await getAuthToken();
      final response = await http.post(Uri.parse('$BASE_URL$url'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'device_type': 'mobile',
            //'x-access-token': authToken ?? "",
          },
          body: jsonEncode(jsonData));
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      log(e.toString());
    }
    log('URL >>>>>>>>>>> $BASE_URL$url');
    log('BODY >>>>>>>>>>> $jsonData');
    log(responseJson!.body.toString());
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        log(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
