class ApplyDiscountModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  ApplyDiscountModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  ApplyDiscountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusText'] = statusText;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = exeTime;
    return data;
  }
}

class Data {
  dynamic discount;

  Data({this.discount});

  Data.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    return data;
  }
}
