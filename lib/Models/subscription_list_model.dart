class SubscriptionListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  SubscriptionListModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
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
  List<Plan>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Plan>[];
      json['data'].forEach((v) {
        data!.add(Plan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  int? session;
  bool? isActive;
  dynamic price;
  dynamic totalPrice;
  String? type;
  String? sId;
  String? dueDate;
  String? cancellationDate;
  String? language;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? validMonth;

  Plan(
      {this.session,
      this.isActive,
      this.price,
      this.totalPrice,
      this.type,
      this.sId,
      this.dueDate,
      this.cancellationDate,
      this.language,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.validMonth});

  Plan.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    isActive = json['is_active'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    type = json['type'];
    sId = json['_id'];
    dueDate = json['dueDate'];
    cancellationDate = json['cancellationDate'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    validMonth = json['validMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    data['is_active'] = isActive;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['type'] = type;
    data['_id'] = sId;
    data['dueDate'] = dueDate;
    data['cancellationDate'] = cancellationDate;
    data['language'] = language;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['validMonth'] = validMonth;
    return data;
  }
}
