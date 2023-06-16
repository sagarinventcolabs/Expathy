class GetSessionModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetSessionModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  GetSessionModel.fromJson(Map<String, dynamic> json) {
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
  List<Session>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Session>[];
      json['data'].forEach((v) {
        data!.add(Session.fromJson(v));
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

class Session {
  bool? isActive;
  String? sessionType;
  int? amount;
  String? date;
  String? time;
  String? day;
  String? sessionTimeStamp;
  String? status;
  String? sId;
  String? psychologist;
  String? customer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? rating;
  String? review;

  Session(
      {this.isActive,
      this.sessionType,
      this.amount,
      this.date,
      this.time,
      this.day,
      this.sessionTimeStamp,
      this.status,
      this.sId,
      this.psychologist,
      this.customer,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.rating,
      this.review});

  Session.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    sessionType = json['sessionType'];
    amount = json['amount'];
    date = json['date'];
    time = json['time'];
    day = json['day'];
    sessionTimeStamp = json['sessionTimeStamp'];
    status = json['status'];
    sId = json['_id'];
    psychologist = json['psychologist'];
    customer = json['customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_active'] = isActive;
    data['sessionType'] = sessionType;
    data['amount'] = amount;
    data['date'] = date;
    data['time'] = time;
    data['day'] = day;
    data['sessionTimeStamp'] = sessionTimeStamp;
    data['status'] = status;
    data['_id'] = sId;
    data['psychologist'] = psychologist;
    data['customer'] = customer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['rating'] = rating;
    data['review'] = review;
    return data;
  }
}
